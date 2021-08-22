server <- function(input, output) {
  output$medal_plot <- renderPlot({
    plot_medals(t = input$team, s = input$season)
  })
}
