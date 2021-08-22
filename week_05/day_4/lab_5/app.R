library(shiny)
library(tidyverse)
library(CodeClanData)

ui <- fluidPage(
    
    selectInput("variable",
                "Which variable to plot?",
                choices = colnames(select(students_big, starts_with("imp")))
                ),
    
    plotOutput("my_plot")
  
)

server <- function(input, output) {
    
    choice <- reactive({
        aes(x = input$variable)
    })
    
    output$my_plot <- renderPlot({
        students_big %>% 
            ggplot() +
            geom_density(aes(fill = gender), alpha = 0.5) +
            choice()
    })
  
}

shinyApp(ui, server)