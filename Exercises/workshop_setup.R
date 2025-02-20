## Please make sure to install all the required packages before the workshop.
# List of required packages
packages <- c("dplyr", "tidyverse", "ggplot2", "ggridges", "datasauRus", 
              "colorspace", "pheatmap", "survival", "survminer", "qqman", 
              "plotly", "gganimate", "gifski", "palmerpenguins", "gapminder", 
              "shiny", "DT", "shinydashboard")

# Install missing packages
missing_packages <- packages[!(packages %in% installed.packages()[, "Package"])]

if (length(missing_packages) > 0) {
  install.packages(missing_packages, dependencies = TRUE)
}

# Load packages
lapply(packages, library, character.only = TRUE)

