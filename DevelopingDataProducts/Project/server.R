require(dplyr);
require(shiny);

cars<-select(mtcars, mpg,disp,hp,wt,qsec)
fit<-lm(mpg~disp+hp+wt+qsec, data=cars)
#fit<-lm(mpg~disp+hp+wt+qsec+hp2+wt2, data=cars)

# Create input variable to predict
x<-as.data.frame(t(colMeans(cars)))
# tot<-x[1,]

shinyServer(function(input, output) {
  mpgPrediction<-reactive({
    x$hp<-input$hp
    x$wt<-input$wt
    x$mpg<-predict(fit, newdata=x)
    return(x$mpg)
  })



  output$mpg<-renderPrint(mpgPrediction())

#   output$text2 <-renderPrint({input$invar})
#   #   output$text2 <- renderText({
#   #     paste("Library: ",input$var)})

#   output$libMap <- renderGvis({
#
#     map <- gvisMap(data=chiLibs, locationvar="Loc",tipvar="Tooltip",
#                    options=list(dataMode='Markers',enableScrollWheel='FALSE',height=500,width=400))
#     #   output$inputValue <- renderPrint({input$glucose})
#     #   output$prediction <- renderPrint({diabetesRisk(input$glucose)})
#     return(map)
#   }
#   )
}
)
