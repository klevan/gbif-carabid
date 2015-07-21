library(maps)
library(mapproj)
counties <- readRDS("data/counties.rds")
source("helpers.R")

shinyServer(
  function(input, output) {
    output$text1 <- renderText({
      paste("You have selected",input$var)
    })
    output$text2 <- renderText({
      paste("You have set a range of",input$range[1]," to ",input$range[2])
    })
    output$map <- renderPlot({
      data <- switch(input$var, 
                     "Percent White" = counties$white,
                     "Percent Black" = counties$black,
                     "Percent Hispanic" = counties$hispanic,
                     "Percent Asian" = counties$asian)
      
      percent_map(var = data, color = "darkgreen", 
                  legend.title = input$var, max = input$range[2], 
                  min = input$range[1])
    })
  }
)