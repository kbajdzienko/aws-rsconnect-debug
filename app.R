library(shiny)
library(lubridate)
library(sodium)
library(jsonlite)

ui <- fluidPage(
  titlePanel("Explore Session Meta"),
  sidebarLayout(
    NULL,
    mainPanel(
      
      fluidPage(
        fluidRow(
          helpText("Session user info"),
          verbatimTextOutput("curr_auth")
        ),
        fluidRow(
          helpText("Environment Var Lookup Panel"),
          inputPanel(
            textInput(
              inputId = "env_var_name",
              label = NULL,
              placeholder = "env name"
            ),
            verbatimTextOutput("env_var_value")
          )
          
        )
      )
      
    )
  )
)

server <- shinyServer(function(input, output, session) {
  
  r_auth_ll <- reactive({
    
    usr <- session$user
    grp <- session$groups
    
    list(username = usr, groups = grp)
    
  })
  
  
  output$curr_auth <- renderText(jsonlite::prettify(jsonlite::toJSON(r_auth_ll())))
  
  
  output$env_var_value <- renderText(Sys.getenv(x = input$env_var_name, "NA"))
})

shinyApp(ui = ui, server = server)
