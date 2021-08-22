library(shiny)
library(tidyverse)
library(CodeClanData)

ui <- fluidPage(
  
    radioButtons(
        "plot_type",
        "Plot Type",
        choices = c("Bar",
                    "Horizontal Bar",
                    "Stacked Bar")
    ),
    
    plotOutput("my_plot")
    
)

server <- function(input, output) {
    
    plot_adj <- reactive({
        if (input$plot_type == "Stacked Bar"){
            geom_bar()
        } else{
            geom_bar(position = "dodge")
        }
    })
    
    output$my_plot <- renderPlot({
        students_big %>% 
            ggplot() +
            aes(x = handed, fill = gender) +
            plot_adj() +
            if(input$plot_type == "Horizontal Bar"){coord_flip()}
     })
        
}

shinyApp(ui, server)
