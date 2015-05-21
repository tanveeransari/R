suppressPackageStartupMessages(library(googleVis))
library(shiny);
# require(caret);require(ggplot2)
require(RSocrata);
require(stringr);
#require(googleVis);

chiLibs<-read.socrata(
  "http://data.cityofchicago.org/Education/Libraries-Locations-Hours-and-Contact-Information/x8fc-8rcq")
#create index
# remove special characters
chiLibs$Loc<-str_replace_all( str_replace_all(chiLibs$LOCATION, "[() ]",""),",",":")
chiLibs$Tooltip<-paste(chiLibs$NAME,chiLibs$ADDRESS, chiLibs$PHONE, chiLibs$HOURS.OF.OPERATION,
                       sep="\n")

map<-gvisMap(data=chiLibs, locationvar="Loc",tipvar="Tooltip",
             options=list(dataMode='Markers',enableScrollWheel='TRUE'))
plot(map)
