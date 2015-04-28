#Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",dest="hid.csv")
d<-read.csv("hid.csv")
strsplit(names(d),"wgtp")[123]
#ANSWER:"" "15"
file.remove("hid.csv")


#Q2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",dest="GDP.csv")
gdp<-read.csv("GDP.csv",header=T,skip=3)
names(gdp)<-c("code","ranking","X1","name","economy","T1","T2","T3","T4","T5")
gdp<-select(gdp,code,ranking,name,economy)
gdp$economy<-gsub(",","",gdp$economy)
gdp$econ<-as.numeric(gdp$economy)
g<-gdp[2:191,]
mean(g$econ,na.rm=T)
#ANSWER : 377652.4

#Q3
#gdp[grepl("^United",gdp$name),]
nrow(gdp[grepl("^United",gdp$name),])

#Q4
g<-gdp[2:232,]
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",dest="fedstats.csv")
fedstats<-read.csv("fedstats.csv",header = T)
m<-merge(g,fedstats,by.x = "code",by.y="CountryCode")
dim(m[grepl( "[fF]iscal year end: [Jjune]", m$Special.Notes),c(1,14)])
#Answer 15 - WRONG

#Q5
require("quantmod");require("lubridate")
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
twelve<-sampleTimes[format(sampleTimes,"%y")=="12"]
length(sampleTimes[format(sampleTimes,"%y")=="12"])
length(twelve[weekdays(twelve)=="Monday"])