# Load necessary libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(gapminder)

# UI - Define the layout of the app
ui <- fluidPage(
  
  # App title
  titlePanel("Interactive Gapminder Dashboard"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    sidebarPanel(
      
      # Select country or countries
      selectInput("countries", 
                  label = "Select Country/Countries",
                  choices = unique(gapminder$country),
                  selected = "United States",
                  multiple = TRUE),
      
      # Select variable for y-axis
      selectInput("yvar", 
                  label = "Select Y Variable",
                  choices = c("Life Expectancy" = "lifeExp", 
                              "GDP per Capita" = "gdpPercap", 
                              "Population" = "pop"),
                  selected = "lifeExp"),
      
      # Select year range
      sliderInput("yearRange", 
                  label = "Select Year Range", 
                  min = min(gapminder$year), 
                  max = max(gapminder$year), 
                  value = c(1952, 2007), 
                  step = 5)
    ),
    
    mainPanel(
      # Output for the plot
      plotOutput("trendPlot"),
      
      # Output for the data table
      DTOutput("dataTable")
    )
  )
)

# Server - Define the logic of the app
server <- function(input, output) {
  
  # Filtered dataset based on user inputs
  filteredData <- reactive({
    gapminder %>%
      filter(country %in% input$countries,
             year >= input$yearRange[1], 
             year <= input$yearRange[2])
  })
  
  # Render the trend plot
  output$trendPlot <- renderPlot({
    ggplot(filteredData(), aes(x = year, y = .data[[input$yvar]], color = country)) +
      geom_line(size = 1.2) +
      geom_point(size = 2) +
      labs(x = "Year", 
           y = input$yvar, 
           color = "Country",
           title = paste("Trend of", input$yvar, "Over Time")) +
      theme_minimal()
  })
  
  # Render the data table
  output$dataTable <- renderDT({
    datatable(filteredData())
  })
}

# Run the app
shinyApp(ui = ui, server = server)
