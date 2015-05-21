suppressPackageStartupMessages(library(googleVis))
require(shiny);require(RSocrata);require(stringr);require(googleVis);
# Get Data
url<-"http://data.cityofchicago.org/Education/Libraries-Locations-Hours-and-Contact-Information/x8fc-8rcq";
chiLibs<-read.socrata(url)

#Clean data and create new vars
chiLibs$Loc<-str_replace_all( str_replace_all(chiLibs$LOCATION, "[() ]",""),",",":")
chiLibs$Tooltip<-paste(chiLibs$NAME,chiLibs$ADDRESS, chiLibs$PHONE,
                       chiLibs$HOURS.OF.OPERATION,sep="\n")
# create map
gvmp<-gvisMap(data=chiLibs, locationvar="Loc",tipvar="Tooltip",
              options=list(dataMode='Markers',enableScrollWheel='TRUE'))

shinyServer(function(input, output) {
  
  output$libraryNames<- renderUI(
    selectInput(inputId="invar", label=("Select library"), choices = chiLibs$NAME)
  )
  
  output$text2 <-renderPrint({input$invar})
  #   output$text2 <- renderText({ 
  #     paste("Library: ",input$var)})
  
  output$libMap <- renderGvis({
    
    map <- gvisMap(data=chiLibs, locationvar="Loc",tipvar="Tooltip",
                   options=list(dataMode='Markers',enableScrollWheel='FALSE',height=500,width=400))
    #   output$inputValue <- renderPrint({input$glucose})
    #   output$prediction <- renderPrint({diabetesRisk(input$glucose)})
    return(map)
  }
  )
}
)
