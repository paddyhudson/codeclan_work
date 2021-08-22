library(shiny)
library(shinythemes)
library(tidyverse)
library(CodeClanData)
library(DT)

ui <- fluidPage(
    
    fluidRow(style = "padding-top:5%",
    
    column(2,
           checkboxGroupInput(
               "gender",
               "Gender",
               choices = unique(nyc_dogs$gender)
           )
    ),
    
    column(3,
           selectInput(
               "colour",
               "Colour",
               choices = c("All" = ".", unique(nyc_dogs$colour))
           )
    ),
    
    column(3,
           selectInput(
               "borough",
               "Borough",
               choices = c("All" = ".", unique(nyc_dogs$borough))
           )
    ),
    
    column(3,
           selectInput(
               "breed",
               "Breed",
               choices = c("All" = ".", unique(nyc_dogs$breed))
           )
    ),
    
    column(style = "padding-top:2%", 1,
           actionButton("update", "Update")
           
    )

    ),
    
    textOutput("search_info"),
    
    dataTableOutput("table_output")
  
)

server <- function(input, output) {
    
    filtered_data <- reactive({
        nyc_dogs %>% 
            filter(
                gender %in% input$gender &
                    str_detect(colour, input$colour) &
                    str_detect(borough, input$borough) &
                    str_detect(breed, input$breed)
            )
    })
    
    display_data <- eventReactive(input$update, {
        filtered_data()
    })
    
    output$table_output <- renderDataTable({display_data()})
    
    output$search_info <- renderText(str_c(
        count(filtered_data()),
        " observations found with current search criteria."))
  
}

shinyApp(ui, server)