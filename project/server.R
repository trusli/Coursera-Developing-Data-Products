library(shiny)

# Load data
data <- fread("./tidy_data.csv")

# Shiny server
shinyServer(
  function(input, output) {
      
      groupByYearPop <- function(dt, minYear, maxYear, minPop,
                                   maxPop) {
          result <- dt %>% filter(year >= minYear, year <= maxYear,
                                  population >= minPop, population <= maxPop) 
          return(result)
      }

      #############################
      
      groupByUSStateAvg <- function(dt,  minYear, maxYear, minPop,
                                       maxPop) {
          dt <- groupByYearPop(dt, minYear, maxYear, minPop,
                                 maxPop)
          result <- dt %>% 
              group_by(usState) %>% 
              summarise(avgPop = mean(population)) %>%
              arrange(usState)
          return(result)
      }
      
      plotStateAvg <- function(dt, dom = "USStateAvg", 
                                xAxisLabel = "US States", 
                                yAxisLabel = "Population") {
          USStateAvg <- nPlot(
              avgPop ~ usState,
              data = dt,
              type = "multiBarChart",
              dom = dom, width = 1500
          )
          USStateAvg$chart(margin = list(left = 100))
          USStateAvg$chart(color = c('pink', 'blue', 'green'))
          USStateAvg$yAxis(axisLabel = yAxisLabel, width = 80)
          USStateAvg$xAxis(axisLabel = xAxisLabel, width = 200,
                                 rotateLabels = -20, height = 200)
          USStateAvg
          
      }
      
      dataTableByUSStateAvg <- reactive({
          groupByUSStateAvg(data, input$timeline[1],input$timeline[2],
                               input$population[1], input$population[2])
      })
      
      output$USStateAvg <- renderChart({
          plotStateAvg(dataTableByUSStateAvg())
          })
      
      ############################################
      
      groupByUSageAvg <- function(dt,  minYear, maxYear, minPop,
                                    maxPop) {
          dt <- groupByYearPop(dt, minYear, maxYear, minPop,
                               maxPop)
          result <- dt %>% 
              group_by(age) %>% 
              summarise(avgPop = mean(population)) %>%
              arrange(age)
          return(result)
      }
      
      plotAgeAvg <- function(dt, dom = "USageAvg", 
                               xAxisLabel = "Gender", 
                               yAxisLabel = "Population") {
          USageAvg <- nPlot(
              avgPop ~ age,
              data = dt,
              type = "multiBarChart",
              dom = dom, width = 1500
          )
          USageAvg$chart(margin = list(left = 100))
          USageAvg$chart(color = c('blue', 'blue', 'green'))
          USageAvg$yAxis(axisLabel = yAxisLabel, width = 80)
          USageAvg$xAxis(axisLabel = xAxisLabel, width = 200,
                           rotateLabels = -20, height = 200)
          USageAvg
          
      }
      
      dataTableByUSageAvg <- reactive({
          groupByUSageAvg(data, input$timeline[1],input$timeline[2],
                            input$population[1], input$population[2])
      })
      
      output$USageAvg <- renderChart({
          plotAgeAvg(dataTableByUSageAvg())
      })
      
      
  } # end of function(input, output)
)