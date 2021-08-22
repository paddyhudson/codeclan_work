library(shiny)
library(tidyverse)
library(CodeClanData)

ui <- fluidPage(
  
    sidebarLayout(
        
        sidebarPanel(
            
            radioButtons(
                "colour",
                "Colour Choice",
                choices = c(Blue = "#3891A6", Yellow = "#FDE74C", Red = "#E3655B")
            ),
            
            sliderInput(
                "transparency",
                "Transparency of Points",
                min = 0,
                max = 1,
                value = 0.5
                
            ),
            
            selectInput(
                "shape",
                "Shape of Points",
                choices = c(Square = 15, Circle = 16, Triangle = 17)
            ),
            
            textInput(
                "title",
                "Title of Graph"
            )
            
        ),
        
        mainPanel(plotOutput("my_plot"))
        
    )
    
)

server <- function(input, output) {
    
    output$my_plot <- renderPlot({
        students_big %>% 
            ggplot() +
            aes(
                x = reaction_time,
                y = score_in_memory_game,
                colour = input$colour,
                shape = as.integer(input$shape)
            ) +
            geom_point(alpha = input$transparency, show.legend = FALSE)+
            ggtitle(input$title) +
            scale_shape_identity() +
            scale_colour_identity()
    })
}

shinyApp(ui, server)