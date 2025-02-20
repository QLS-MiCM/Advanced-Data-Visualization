# Load necessary libraries
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(DT)
library(gapminder)

# Define UI components for App 1
app1_ui <- tabItem(
  tabName = "app1",
  sidebarLayout(
    sidebarPanel(
      "This is the sidebar",
      textInput("title", "Text box title", "Text box content"),
      numericInput("num", "Number of cars to show", 10, min = 1, max = 30),
      sliderInput("temperature", "Body temperature", min = 35, max = 42, value = 37.5, step = 0.1),
      sliderInput("price", "Price (€)", value = c(39, 69), min = 0, max = 99),
      radioButtons("radio", "Choose your preferred time slot", 
                   choices = c("09:00 - 09:30", "09:30 - 10:00", "10:00 - 10:30", 
                               "10:30 - 11:00", "11:00 - 11:30"), 
                   selected = "10:00 - 10:30"),
      selectInput("major", "Major", 
                  choices = c("Business Administration", "Data Science", "Econometrics & Operations Research", 
                              "Economics", "Liberal Arts", "Industrial Engineering", "Marketing Management", 
                              "Marketing Analytics", "Psychology"),
                  selected = "Marketing Analytics"),
      selectInput("programming_language", "Programming Languages",
                  choices = c("HTML", "CSS", "JavaScript", "Python", "R", "Stata"),
                  selected = "R", multiple = TRUE),
      checkboxInput("agree", "I agree to the terms and conditions", value = TRUE)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("tab 1", h1("Overview"), "Content goes here"),
        tabPanel("tab 2", "The content of the second tab"),
        tabPanel("tab 3", "The content of the third tab")
      )
    )
  )
)

# Define UI components for App 2
app2_ui <- tabItem(
  tabName = "app2",
  sidebarLayout(
    sidebarPanel(
      selectInput("countries", "Select Country/Countries",
                  choices = unique(gapminder$country),
                  selected = "United States",
                  multiple = TRUE),
      selectInput("yvar", "Select Y Variable",
                  choices = c("Life Expectancy" = "lifeExp", 
                              "GDP per Capita" = "gdpPercap", 
                              "Population" = "pop"),
                  selected = "lifeExp"),
      sliderInput("yearRange", "Select Year Range", 
                  min = min(gapminder$year), 
                  max = max(gapminder$year), 
                  value = c(1952, 2007), 
                  step = 5)
    ),
    mainPanel(
      plotOutput("trendPlot"),
      DTOutput("dataTable")
    )
  )
)

# Define Dashboard UI
ui <- dashboardPage(
  dashboardHeader(title = "Multi-Page Shiny App"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("demo", tabName = "app1", icon = icon("list")),
      menuItem("Gapminder Dashboard", tabName = "app2", icon = icon("chart-line"))
    )
  ),
  dashboardBody(
    tabItems(
      app1_ui,
      app2_ui
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Filtered dataset based on user inputs for App 2
  filteredData <- reactive({
    gapminder %>%
      filter(country %in% input$countries,
             year >= input$yearRange[1], 
             year <= input$yearRange[2])
  })
  
  # Render the trend plot for App 2
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
  
  # Render the data table for App 2
  output$dataTable <- renderDT({
    datatable(filteredData())
  })
}

# Run the app
shinyApp(ui = ui, server = server)

