require(shiny);require(googleVis);
shinyUI(fluidPage(
  titlePanel("Chicago Public Libraries"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Choose a library to highlight it"),
      #       selectInput("var", 
      #                   label = "Choose a variable to display",
      #                   choices = textOutput("libraryNames"),
      #                   #selected = "Percent White"
      #       ),
      uiOutput("libraryNames"),
      textOutput("text1")
    ),
    
    mainPanel(
      textOutput("libMap")
    )
  )
))
