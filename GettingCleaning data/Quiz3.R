# ------------Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="hid.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf",destfile="hidDescription.pdf")
#ACR==3 for ten or more acres, AGs=6 for Ags product sales>$10000
library(data.table)
all<-fread("hid.csv")
someCols<-select(all,RT:AGS)
agricultureLogical<-someCols$ACR==3 & someCols$AGS==6
which(agricultureLogical)
#ANSWER: 125, 238,262

# ------------Q2
install.packages("jpeg")
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",method = "auto", destfile="jeff.jpg")
#Note above downloaded corrupted file - i downloaded it manually

img<-readJPEG("jeff.jpg", native = T)
quantile(img)
quantile(img, probs =c(0.3,0.8))
#ANSWER : -15259150 -10575416

# ------------Q3
# using fread wtih download.file was having trouble complaining about /r/rn line endings
# so used fready to directly download the file using fread(url)
country<-fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
setwd("../GettingCleaning data/")
GDP<-read.csv("GDP.csv",skip=4,nrows=190)
gdp<-GDP[,c(1,2,4,5)]
all<-merge(CNT,gdp,by.x="CountryCode",by.y="Code",all=T)
mergedsorted<-arrange(merged,desc(Rank))
mergedsorted[13,1:10] #St Kitts
#WRONG -sum(!is.na(merged$Rank)) - 
#There are duplicates in rank - both Grenada and St Kitts are Rank 178
sum(!is.na(unique(mergedsorted$Rank)))

# ------------Question 4
#What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
tapply(merged$Rank, merged$Income.Group, mean, na.rm=T)
#ANSWER : 32.96667, 91.91304

# ------------Question 5
#Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
#How many countries are Lower middle income but among the 38 nations with highest GDP?

#####WRONG - when he said 5 quantiles that meant lenght.out should have been 6
gdp$qntls<-quantile(gdp$Rank, probs=seq(0,1,length.out=5))
merge2<-merge(CNT,gdp,by.x="CountryCode",by.y="Code",all=T)
table(merge2$Income.Group,merge2$qntls,useNA = "ifany")
###RIGHT
breaks <- quantile(gdp$Rank, probs = seq(0, 1, 0.2), na.rm = TRUE)
merge2$qntls<-cut(merge2$Rank, breaks=breaks)
table(merge2$Income.Group, merge2$qntls)
#ANSWER - 5
