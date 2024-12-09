#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)
library(shiny)

london_marathon <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-25/london_marathon.csv')

server <- function(input, output, session){
  
  output$london_plot <- renderPlot({
    
    london_marathon|>
      ggplot(aes(x = Year)) + 
      geom_point(aes( y = Accepted, color = "Accepted")) +
      geom_point(aes_string(y = input$var, color = shQuote(input$var))) + 
      labs(x = "Year", y = "Number of People") +
      theme_minimal()
  })
  
}

ui <- fluidPage(
  titlePanel("London Marathon Statistics"), 
  tags$p("Select another variable to graph against the graph of Accepted Runners over the years", 
         style = "font-size: 16px; color: gray; margin-top: -10px;"),
  sidebarLayout(
    sidebarPanel(
      selectInput("var", 
                  "Variable:", 
                  choices = c("Applicants", "Starters", "Finishers"))), 
    mainPanel(
      plotOutput("london_plot")
    )
  )
)

shinyApp(ui, server)
