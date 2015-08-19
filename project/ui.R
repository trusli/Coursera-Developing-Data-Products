library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(pageWithSidebar(
    headerPanel("US Population"),
    sidebarPanel(
        sliderInput("timeline", 
                    "Timeline:", 
                    min = 2010,
                    max = 2014,
                    value = c(2010, 2014)),
        sliderInput("population", 
                    "Total Population",
                    min = 0,
                    max = 400000000,
                    value = c(0, 400000000) 
        ),
        #format = "####"),
        uiOutput("themesControl"), # the id
        actionButton(inputId = "clearAll", 
                     label = "Clear selection", 
                     icon = icon("square-o")),
        actionButton(inputId = "selectAll", 
                     label = "Select all", 
                     icon = icon("check-square-o"))
        
    ),
    mainPanel(
        tabPanel(p(icon("line-chart"), "Visualize the Data"), 
                 h4('Age by Year', align = "center"),
                 showOutput("ageByYear", "nvd3"),
                 h4('Gender by Year', align = "center"),
                 showOutput("genderByYear", "nvd3")
        ) # end of "Visualize the Data" tab panel
    )     
))
