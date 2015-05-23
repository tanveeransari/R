require(shiny);require(dplyr);

cars<-select(mtcars, mpg,disp,hp,wt,qsec)
fit<-lm(mpg~disp+hp+wt+qsec, data=cars)
#fit<-lm(mpg~disp+hp+wt+qsec+hp2+wt2, data=cars)

# Create input variable to predict
x<-as.data.frame(t(colMeans(cars)))

shinyServer(function(input, output) {
  mpgPrediction<-reactive({
    x$hp<-input$hp
    x$wt<-input$wt
    x$mpg<-predict(fit, newdata=x)
    return(x$mpg)
  })

  output$mpg<-renderPrint(mpgPrediction())
}
)
####  ------------- Older version using googleVis maps   -------------
# suppressPackageStartupMessages(library(googleVis))
# require(RSocrata);require(stringr);require(googleVis);
# # Get Data
# url<-"http://data.cityofchicago.org/Education/Libraries-Locations-Hours-and-Contact-Information/x8fc-8rcq";
# chiLibs<-read.socrata(url)
#
# #   ----------Clean data and create new vars
# chiLibs$Loc<-str_replace_all( str_replace_all(chiLibs$LOCATION, "[() ]",""),",",":")
# chiLibs$Tooltip<-paste(chiLibs$NAME,chiLibs$ADDRESS, chiLibs$PHONE,
#                        chiLibs$HOURS.OF.OPERATION,sep="\n")
# # create map
# gvmp<-gvisMap(data=chiLibs, locationvar="Loc",tipvar="Tooltip",
#               options=list(dataMode='Markers',enableScrollWheel='TRUE'))
#
# shinyServer(function(input, output) {
#
#   output$libraryNames<- renderUI(
#     selectInput(inputId="invar", label=("Select library"), choices = chiLibs$NAME)
#   )
#
#   output$libMap <- renderGvis({
#
#     map <- gvisMap(data=chiLibs, locationvar="Loc",tipvar="Tooltip",
#                    options=list(dataMode='Markers',enableScrollWheel='FALSE',height=500,width=400))
#     return(map)
#   }
#   )
# }
# )
