library(shiny)
library(CodeClanData)
library(tidyverse)
library(shinythemes)

ui <- fluidPage(
    
    theme = shinytheme("superhero"),
    
    titlePanel("Five Country Medal Comparison"),
    
    plotOutput("plot"),
    
    fluidRow(
        
        column(6,
            
            radioButtons("season", "Summer or Winter Olympics?", c("Summer", "Winter")),
        
        ),
        
        column(6,
            checkboxGroupInput(
                        "medal",
                        "Medal Type?",
                        c("Gold", "Silver", "Bronze"),
                        inline = TRUE
            )
        )
        
    )
    
)

server <- function(input, output){
    
    output$plot <- renderPlot({
        olympics_overall_medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal %in% input$medal) %>%
            filter(season == input$season) %>% 
            ggplot() +
            aes(x = team, y = count, fill = medal) +
            geom_col(position = "dodge") +
            scale_fill_manual(values = c("Gold" = "gold",
                                "Silver" = "gray70",
                                "Bronze" = "darkorange"))
    })
    
}

shinyApp(ui = ui, server = server)