library(shiny)
shinyUI(
  fluidPage(
    titlePanel("This awesome app"),
                  sidebarLayout(
                    sidebarPanel(
                      selectInput("dist",
                                  label="Choose a distribution",
                                  choices=list("Normal","Cauchy","Uniform","My data")),
                      numericInput("num",label="Input number of samples",value=100),
                      sliderInput("bins","Number of bins:",
                                  min = 1,
                                  max = 50,
                                  value = 30)
                      ),
                    mainPanel(
                      wellPanel(
                        p("Data Distributions"),
                        plotOutput("distPlot")
                        )
                      ) 
                    
    )
  )
)