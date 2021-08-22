library(shiny)
library(tidyverse)
library(CodeClanData)
library(DT)

ui <- fluidPage(
  
    sidebarLayout(
        
        sidebarPanel(
            
            selectInput(
                "gender",
                "Gender",
                choices = unique(students_big$gender)
            ),
            
            selectInput(
                "region",
                "Region",
                choices = unique(students_big$region)
            ),
            
            actionButton("generate", "Generate Plots and Table")
            
        ),
        
        mainPanel(
            
            tabsetPanel(
            
            tabPanel("Plots",
                fluidRow(
                    column(6,
                        plotOutput("internet_plot")
                    ),
                    column(6,
                        plotOutput("pollution_plot") 
                    )
                )
            ),
            
            tabPanel("Data",
                dataTableOutput("my_table")
            )
            )
        )
    )
)

server <- function(input, output) {
    
    filtered_data <- eventReactive(input$generate, {
        students_big %>% 
            filter(gender == input$gender & region == input$region) %>% 
            select(region,
                   gender,
                   importance_internet_access,
                   importance_reducing_pollution)
        })
    
    output$internet_plot <- renderPlot({
        filtered_data() %>% 
            ggplot() +
            aes(x = importance_internet_access) +
            geom_histogram()
    })
    
    output$pollution_plot <- renderPlot({
        filtered_data() %>% 
            ggplot() +
            aes(x = importance_reducing_pollution) +
            geom_histogram()
    })
    
    output$my_table <- renderDataTable(filtered_data(), rownames = FALSE)
  
}

shinyApp(ui, server)