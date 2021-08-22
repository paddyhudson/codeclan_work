source("helper.R")

ui <- fluidPage(
  titlePanel("Olympic Medals"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("season",
                   "Summer or Winter Olympics?",
                   choices = c("Summer", "Winter")
      ),
      
      selectInput("team",
                  "Which Team?",
                  choices = all_teams,
                  selected = "Great Britain"
      )
    ),
    
    mainPanel(
      plotOutput("medal_plot")
    )
  )
)