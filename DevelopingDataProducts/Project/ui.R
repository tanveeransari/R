require(shiny);

shinyUI(fluidPage(
  titlePanel("Predict mpg by weight and horsepower"),

  sidebarLayout(
    sidebarPanel(
      helpText("Explore effect of hp and wt on mpg"),

      sliderInput("wt",
                  label = "Weight in thousands of pounds",
                  min = 1, max = 6, value = 3),
      sliderInput("hp",label="Gross Horsepower",
                  min=50,max=350, value=123)
    ),

    mainPanel(
      h2("Predicted MPG"),
      h2(textOutput("mpg")),
      hr(),
      h3("Explanation"),
      p("This page fits a linear model to the mtcars dataset in the base package"),
      code("cars <- mtcars"),
      br(),
      br(),
      code("fit <- lm(mpg~disp+hp+wt+qsec, data=mtcars)"),
      br(),
      p("It uses the fitted linear model(fit) to predict mpg"),
      br(),
      code("x <- as.data.frame(t(colMeans(cars)))"),
      br(),
      p(" x is the input data frame used for prediction."),
      br(),
      code("x$mpg <- predict(fit, newdata=x)"),
      br(),
      p(" The sliders change wt and hp values for x"),
      br(),
      div("You can predict Mpg by varying the Weight and Horsepower")
    )
  )
)
)
