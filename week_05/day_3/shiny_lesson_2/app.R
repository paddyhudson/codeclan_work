library(shiny)
library(tidyverse)
library(CodeClanData)
library(shinythemes)

all_teams <- unique(olympics_overall_medals$team)

ui <- fluidPage(
    
    theme = shinytheme("slate"),
    
    titlePanel(tags$h1("Olympic Medals")),
    
    tabsetPanel(
        
        tabPanel(
            "Season",
            radioButtons("season_input",
                         tags$i("Summer or Winter Olympics?"),
                         choices = c("Summer", "Winter")
            )
        ),
        
        tabPanel(
            "Team",
            selectInput("team_input",
                        tags$b("Which Team?"),
                        choices = all_teams
            )
        ),
        
        tabPanel(
            "Plot",
            plotOutput("medal_plot1")
        ),
        
        tabPanel(
            "Links", 
            tags$a("The Olympics Website", href = "https://www.Olympic.org/")
        )
    )
)


server <- function(input, output) {
    
    output$medal_plot1 <- renderPlot({
        olympics_overall_medals %>%
            filter(team == input$team_input) %>%
            filter(season == input$season_input) %>%
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            geom_col()
    })
    
    output$medal_plot2 <- renderPlot({
        olympics_overall_medals %>%
            filter(team == input$team_input) %>%
            filter(season == input$season_input) %>%
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            geom_col()
    })
}

shinyApp(ui = ui, server = server)