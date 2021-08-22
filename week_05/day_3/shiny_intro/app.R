library(shiny)
library(tidyverse)
library(CodeClanData)

all_teams <- unique(olympics_overall_medals$team)

ui <- fluidPage(
    
    titlePanel("Title"),
    
    sidebarLayout(
        
        sidebarPanel(
            column(6,
            radioButtons(
                "season_input",
                "Summer or Winter Olympics",
                choices = c("Summer", "Winter"),
                selected = "Winter"
            )),
            column(6,
            selectInput(
                "team_input",
                "Which Team?",
                choices = all_teams,
                selected = "Great Britain"
            ))
        ),
        
        mainPanel(
            plotOutput("medal_plot")
        )
    ) 
    
)

server <- function(input, output) {
    
    output$medal_plot <- renderPlot({
        
        olympics_overall_medals %>%
            filter(team == input$team_input) %>%
            filter(season == input$season_input) %>%
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            geom_col() +
            ggtitle(str_c(input$team_input, " ", input$season_input, " Medals"))
    })
    
}

shinyApp(ui = ui, server = server)