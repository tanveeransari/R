library(shiny);
library(dplyr);

cars<-select(mtcars, mpg,disp,hp,wt,qsec)
fit<-lm(mpg~disp+hp+wt+qsec, data=cars)
# Create input variable to predict
x<-as.data.frame(t(colMeans(cars)))

#Predict mpg using x
x$mpg<-predict(fit, newdata=x)