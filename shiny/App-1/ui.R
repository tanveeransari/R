library(shiny)

# Define UI for application that draws a histogram
shinyUI(
  fluidPage
  (
    titlePanel("My Shiny App"),

    sidebarLayout
    (
      sidebarPanel
      (
        h2("Installation"),
        p("Shiny is available on CRAN, so you can install it in the usual
        way from your R console:"),
        code("install.packages(\"shiny\")", style="color:red"),
        br(),
        span(
          img(src="bigorb.png", height=72, width=72),
          "shiny is a product of",
          span("RStudio", style="color:blue")
        )
      ),

      mainPanel(
        h1("Intorducing Shiny"),
        p("Shiny is a new package from RStudio that makes it",
          em("incredibly easy"),
          "to build interactive web applications with R."
        ),

        p("For an introduction and live examples, visit the",
          a("Shiny Home Page", href="http://shiny.rstudio.com")
        ),

        h2("Features"),
        p("* Build useful web applications with only a few lines of code -
        no JavaScript required."),
        p("* Shiny applications are automatically \"live\" in the sampe way that
        spreadsheets are live. Outputs change instantly as users modify inputs,without requireing a reload of the browser")
      )
    )
  )
)