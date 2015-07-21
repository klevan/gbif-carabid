library(shiny)
shinyUI(fluidPage(titlePanel("Exploring Data from Old Faithful"),
                  sidebarLayout(
                    sidebarPanel(
                      sliderInput("bins","Number of bins:",
                                  min = 5,
                                  max = 50,
                                  value = 30)),
                    mainPanel(plotOutput("distPlot")) )))