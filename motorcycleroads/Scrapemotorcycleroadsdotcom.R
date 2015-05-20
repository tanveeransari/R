require(XML);require(stringr);
library(XML)
library(dplyr)
library(stringr)
rootURL<-"http://www.motorcycleroads.com/"

mainPg<-htmlParse(rootURL)
linkshref<-getNodeSet(mainPg,"//*[@id=\"copy\"]/p[3]/a/@href")
stateIdNums<-sapply(linkshref,function(x){str_extract(x,"[0-9]+$")})

#find hyperlinks for each state page- each state has an id number for it
urls=paste("http://www.motorcycleroads.com/best/?c=",stateIdNums,sep = "")

rm(stateIdNums);rm(linkshref);rm(mainPg)

allRtTable<-data.frame()

for(i in 1:length(urls)) {
  #For each state go to best routes page
  l<-urls[i]
  statePg<-htmlParse(l)

  # Table 2 has Route Name, Rank, States and Rating
  stateTbls<-readHTMLTable(statePg,header=T,skip.rows = 1,trim=T,which=2)
  allRtTable<-rbind(allRtTable,stateTbls)

  # On state page travel each hyperlink to find all routes pages
  allPgLinks<-getNodeSet(statePg,"//*/a/@href")
  routeLinks<-allPgLinks[grep("^[0-9]+",allPgLinks)]
  for(j in 1:length(routeLinks))
  {
    routeLink<-paste(rootURL,as.character(routeLinks[j]),sep="")
    # Read Route Page
    routePg<-htmlParse(routeLink)
    getNodeSet(routePg,"//*[@id=\"copy\"]/div[2]/div[2]/text()[9]")[[1]]

    routePgLinks<-getNodeSet(routePg,"//*/a/@href")
    # On individual route page find hyperlink to gpx files
    if(length(routePgLinks[grep("gpx",routePgLinks)])>0) {

      gpxUrl<-sub("./",rootURL, as.character(routePgLinks[grep("gpx",routePgLinks)][1]), fixed=T)
      gpxFileName<-str_split(gpxUrl,"=")[[1]][2]
      # download gpx file if not exists
      if(!file.exists(gpxFileName)) {
        download.file(gpxUrl,gpxFileName)
      }
      #Extract other metadata - road length, state names
    }
  }
}

allRtTable
write.table(allRtTable,file="routeslist.csv",append=F, row.names=F, sep = "|",quote=F)
# stateNames<-c("Alabama","Alaska",  "Arizona",	"Arkansas",	"California",	"Colorado",	"Connecticut",
#               "Delaware",	"Florida",	"Georgia",	"Hawaii",	"Idaho",	"Illinois",	"Indiana",
#               "Iowa",	"Kansas",	"Kentucky",	"Louisiana",	"Maine",	"Maryland",	"Massachusetts",
#               "Michigan",	"Minnesota",	"Mississippi",	"Missouri",	"Montana",	"Nebraska",	"Nevada",
#               "New Hampshire",	"New Jersey",	"New Mexico",	"New York",	"North Carolina",
#               "North Dakota",	"Ohio",	"Oklahoma",	"Oregon",	"Pennsylvania",	"Rhode Island",
#               "South Carolina",	"South Dakota",	"Tennessee",	"Texas",	"Utah",	"Vermont",
#               "Virginia",	"Washington",	"West Virginia",	"Wisconsin",	"Wyoming")
