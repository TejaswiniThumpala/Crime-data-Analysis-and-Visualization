library(shiny)
library(shinythemes)
shinyUI(fluidPage(theme = "crimetheme.css",
                  tags$head(
                    tags$style(HTML("
                                    @import url('//fonts.googleapis.com/css?family=Geneva&effect=shadow-multiple|font-effect-emboss	');
                                    
                                    h1 {
                                    font-family: 'IBM Plex Serif', bold;
                                    font-size:80px;
                                    font-weight: 6000;
                                    line-height: 1.1;
                                    color: #EEE861;
                                    text-align: center;
                                    }
                                    "))
                    ),
                  headerPanel("Crime Data Analysis & Visualization"),
                  titlePanel("Data Source: COLORADO STATE - USA"),
                  
                  sidebarLayout(
                    sidebarPanel(
                      
                      
                      dateRangeInput("reportedDateRange", "Reported Date Range:",
                                     start = min(df$REPORTED_DATE), end = max(df$REPORTED_DATE)),
                      
                      selectInput("groupCategory","Explore Data by Category:",
                                  choices = c("OFFENSE_CATEGORY_ID", "OFFENSE_TYPE_ID", "NEIGHBORHOOD_ID", "IS_TRAFFIC", "IS_CRIME"),
                                  selected = "OFFENSE_CATEGORY_ID"),
                      
                      checkboxGroupInput("offenseCategory", "Offense Category:",
                                         choices = OFFENSE_CATEGORY_CHOICES,
                                         selected = OFFENSE_CATEGORY_CHOICES[1:3]),
                      
                      actionButton("updateFilter", "Update")
                      
                    ),
                    
                    mainPanel(
                      tabsetPanel(id = 'main',
                                  
                                  
                                  
                                  tabPanel('Core Analysis', p(),
                                           fluidRow(selectInput("groupTimeChoice", "Explore by Time Period:",
                                                                choices = c("Year","Month","DayOfWeek","Hour"),
                                                                selected = "DayOfWeek"),
                                                    plotOutput('plotDOW'))
                                  ),
                                  
                                  
                                  
                                  tabPanel('Neighborhood Analysis', p(),
                                           fluidRow(sliderInput("neighborhoodRows", "Maximum Results: ",
                                                                min = 1,
                                                                max = 25,
                                                                value = 15),
                                                    plotOutput('neighborhood'))
                                  ),
                                  
                                  tabPanel('Map', p(),
                                           fluidRow(sliderInput("mapRows", "Maximum Results: ",
                                                                min = 100,
                                                                max = 5000,
                                                                value = 600,
                                                                step = 100),
                                                    leafletOutput('map'))
                                  )
                      )
                    )
                  )))
