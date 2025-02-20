library(shiny)


ui <- fluidPage(
  # Define UI components 
  
  sidebarLayout(
    
    sidebarPanel(
      "This is the sidebar",
      
      # textbox that accepts both numeric and alphanumeric input
      textInput(inputId = "title", label="Text box title", value = "Text box content"),
      
      # textbox that only accepts numeric data between 1 and 30
      numericInput(inputId = "num", label = "Number of cars to show", value = 10, min = 1, max = 30),
      
      # slider that goes from 35 to 42 degrees with increments of 0.1
      sliderInput(inputId = "temperature", label = "Body temperature", min = 35, max = 42, value = 37.5, step = 0.1),
      
      # slider that allows the user to set a range (rather than a single value)
      sliderInput(inputId = "price", label = "Price (€)", value = c(39, 69), min = 0, max = 99),
      
      # input field that allows for a single selection
      radioButtons(inputId = "radio", label = "Choose your preferred time slot", choices = c("09:00 - 09:30", "09:30 - 10:00", "10:00 - 10:30", "10:30 - 11:00", "11:00 - 11:30"), selected = "10:00 - 10:30"),
      
      # a dropdown menu is useful when you have plenty of options and you don't want to list them all below one another
      selectInput(inputId = "major", label = "Major", choices = c("Business Administration", "Data Science", "Econometrics & Operations Research", "Economics", "Liberal Arts", "Industrial Engineering", "Marketing Management", "Marketing Analytics", "Psychology"),
                  selected = "Marketing Analytics"),
      
      # dropdown menu that allows for multiple selections (e.g., both R and JavaScript)
      selectInput(inputId = "programming_language", label = "Programming Languages",
                  choices = c("HTML", "CSS", "JavaScript", "Python", "R", "Stata"),
                  selected = "R", multiple = TRUE),
      
      # chekcbox: often used to let the user confirm their agreement
      checkboxInput(inputId = "agree", label = "I agree to the terms and conditions", value=TRUE)
      
    ),
    
    mainPanel(
      "Main panel goes here",
      
      tabsetPanel(
        tabPanel(title = "tab 1",
                 h1("Overview"),
                 "Content goes here"),
        tabPanel(title = "tab 2", "The content of the second tab"),
        tabPanel(title = "tab 3", "The content of the third tab")
      )
    )
  )
  
  
)

server <- function(input, output){
  # Implement server logic here
}

shinyApp(ui = ui, server = server)
