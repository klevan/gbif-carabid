library(shiny)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  input.data <- data(Orange)
  graph <- reactive({
    if(input$dist=="Normal")
      return(rnorm(input$num))
    if(input$dist=="Cauchy")
      return(rcauchy(input$num))
    if(input$dist=="Uniform")
      return(runif(input$num))
    if(input$dist=="My data")
      return(sample(Orange$age,size = input$num, replace = TRUE))
  })
  output$distPlot <- renderPlot({
    hist(graph(), breaks = input$bins, col = 'skyblue', border = 'white',xlab="Values",main="")
  })
})