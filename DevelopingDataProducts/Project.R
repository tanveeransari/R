library(shiny);
library(dplyr);

setwd("/media/tanveer/Windows8_OS//Users/Tanveer/Documents/DataScience/CourseRa/RProgramming/DevelopingDataProducts/")

cars<-select(mtcars, mpg,disp,hp,wt,qsec)
fit<-lm(mpg~disp+hp+wt+qsec, data=cars)
# Create input variable to predict
x<-as.data.frame(t(colMeans(cars)))

#Predict mpg using x
x$mpg<-predict(fit, newdata=x)

#------------Slidify presentation setup----------
# find.package("stringr")
# remove.packages("stringr")
# install_version("stringr",version = "0.6.2")
#author("MpgPrediction")
