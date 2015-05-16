library(XML)
require(dplyr)

download.file("https://data.cityofchicago.org/api/views/wwy2-k7b3/rows.csv?accessType=DOWNLOAD","parks.csv")
parks<-read.csv("https://data.cityofchicago.org/api/views/wwy2-k7b3/rows.csv?accessType=DOWNLOAD",header = T)
download.file("https://data.cityofchicago.org/api/views/pk66-w54g/rows.csv?accessType=DOWNLOAD","events.csv")
events<-read.csv("events.csv",header = T)
#------------------NOW GET LOCATIONS FOR EACH FILE------------
streetAddr<-sapply(parks$LOCATION, function(x){strsplit(as.character(x),"\n")[[1]][1]})
parks$streetAddr<-streetAddr
zips<-sapply(parks$LOCATION, function(x){strsplit(as.character(x),"\n")[[1]][2]})
parks$zips<-zips

latLongs<-unlist(sapply(parks$LOCATION, function(x){strsplit(as.character(x),"\n")[[1]][3]}))
latLongs<-sub("^\\(","",latLongs)
latLongs<-sub("\\)$","",latLongs)
lats<-sapply(latLongs,function(x){as.character( strsplit(x,",")[[1]][1])})
longss<-sapply(latLongs,function(x){as.character( strsplit(x,",")[[1]][2])})
names(lats)<-NULL
names(longss)<-NULL
parks$LatLong<-latLongs
parks$Latitude<-lats
parks$Longitude<-longss



all<-merge(x=events, y=parks,by.x ="Park.Number",by.y="PARK.NUMBER" )
eventsSmall<-select(all,Park.Number,PARK.NAME,Event.Type,Event.Description,
                    Requestor,Reservation.Start.Date, Reservation.End.Date,Organization,
                    LatLong,Latitude,Longitude,zips, Permit.Status)
write.csv(eventsSmall,"eventsWithLoc.csv")
