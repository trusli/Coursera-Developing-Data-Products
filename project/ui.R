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
                    max = 250000,
                    value = c(0, 250000))
    ),
    mainPanel(
        tabPanel(p(icon("line-chart"), "Visualize Data"), 
                 h4('US Population Breakdown By State', align = "center"),
                 showOutput("USStateAvg", "nvd3"),
                 h4('US Population Breakdown By Age', align = "center"),
                 showOutput("USageAvg", "nvd3"))
        )     
    )
)
