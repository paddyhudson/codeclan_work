library(shiny)
library(shinythemes)
library(tidyverse)
library(CodeClanData)
library(DT)

ui <- fluidPage(
  
    fluidRow(style = "padding-top:5%",
    
    column(3,
        radioButtons(
            "handed_input",
            "Handedness",
            choices = unique(students_big$handed),
            inline = TRUE
        )
    ),
    
    column(3,
        selectInput(
            "region",
            "Region",
            choices = unique(students_big$region)
        )
    ),
    
    column(3,
        checkboxGroupInput(
            "gender",
            "Gender",
            choices = unique(students_big$gender),
            inline = TRUE
        )
    ),
    
    column(1,
           actionButton(
               "update",
               "Update"
           )
    ),
    
    column(2,
           radioButtons("colour",
                        "Plot Colour",
                        choices = c("Blue" = "steel blue", "Grey" = "gray40")
            )
    )
    ),
    
    fluidRow(
        
        column(6,
               plotOutput("travel_plot")
        ),
        
        column(6,
               plotOutput("spoken_plot")
        )
        
    ),
    
    dataTableOutput("table_output")
    
)

server <- function(input, output) {
    
    filtered_data <- eventReactive(input$update, {students_big %>% 
        filter(
            handed == input$handed_input &
                region == input$region &
                gender %in% input$gender
        )
    })
    
    bar_plot <- reactive(
        filtered_data() %>% 
            ggplot() +
            geom_bar(fill = input$colour)
        )
    
    output$table_output <- renderDataTable({
        filtered_data()
    })
    
    output$travel_plot <- renderPlot({
        bar_plot() +
        aes(x = travel_to_school)
    })
    
    output$spoken_plot <- renderPlot({
        bar_plot() +
        aes(x = languages_spoken)
    })
  
}

shinyApp(ui, server)

