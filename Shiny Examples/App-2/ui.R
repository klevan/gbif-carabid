shinyUI(fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel(
      h1("Installation"),
      p("Shiny is available on CRAN, so you can install it in the usual way from your R console:"),
      code('install.packages("shiny")'),
      br(),
      br(),
      br(),
      br(),
      img(src="bigorb.png", height = 72,width = 72,"shiny is a product of",
          a("RStudio",ref="http://rstudio.com"))
      ),
    mainPanel(
      h1("Introducing Shiny"),
      p("Shiny is a new package from RStudio that makes",em("incredibly"),"easy to build 
        interactive web applications with R."),
      p("For an introduction and live examples, visit the",a("Shiny homepage.",
        ref="http://shiny.rstudio.com")),
      br(),
      h2("Features"),
      p("* Build useful web applications with only a few lines of code--no Javascript needed."),
      p("* Shiny applications are automatically 'live' in the same way that",strong("spreadsheets"),
           "are live. Outputs change instantly as users modify inputs, without requiring a reload of 
           the browser.")
    )
  )
))