source("helpers.R")
counties <- readRDS("data/counties.rds")
library(maps)
library(mapproj)

# server.R
counties<-readRDS("data/counties.RDS")
shinyServer(
  function(input, output) {
    
    #     output$map <- renderPlot({
    #       data<-switch(input$var,
    #                    "Percent White" = counties$white,
    #                    "Percent Black" = counties$black,
    #                    "Percent Hispanic" = counties$hispanic,
    #                    "Percent Asian" = counties$asian)
    #       colorr<-switch(input$var,
    #                      "Percent White" = "green",
    #                      "Percent Black" = "black",
    #                      "Percent Hispanic" = "darkorange",
    #                      "Percent Asian" = "red")
    
    output$map<-renderPlot({
      args<-switch(input$var,
                   input$var,
                   "Percent White" = list(counties$white,"darkgreen","% White"),
                   "Percent Black" = list(counties$black,"darkblue","% White"),
                   "Percent Hispanic" = list(counties$hispanic,"darkorange","% Hispanic"),
                   "Percent Asian" = list(counties$asian,"darkred","% Asian"))
      args$min<-input$range[1]
      args$max<-input$range[2]
      #     percent_map( var=data, min=input$range[1], max=input$range[2],color=colorr, legend.title=input$var
      do.call(percent_map,args)
    })
  })
