library(shiny)
library(tidyverse)
library(CodeClanData)

ui <- fluidPage(
  
    radioButtons(
        "age",
        "Age",
        choices = sort(unique(students_big$ageyears)),
        inline = TRUE
    ),
    
    fluidRow(
        
        column(6, plotOutput("height_plot")),
        column(6, plotOutput("armspan_plot"))
        
    )
    
)

server <- function(input, output) {
  
    draw_hist <- reactive({
        students_big %>%
        select(ageyears, arm_span, height) %>% 
        filter(ageyears == input$age) %>% 
        ggplot() +
        geom_histogram()
    })
    
    output$height_plot <- renderPlot(
        draw_hist() +
        aes(x = height)
    )
    
    output$armspan_plot <- renderPlot(
        draw_hist() +
        aes(x = arm_span)
    )
}

shinyApp(ui, server)