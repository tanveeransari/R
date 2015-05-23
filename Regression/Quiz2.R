#Question 1

Consider the following data with x as the predictor and y as as the outcome.
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
Give a P-value for the two sided hypothesis test of whether β1 from a linear regression model is 0 or not

summary(lm(y~x)) #Read p values from here
#F-statistic: 5.408 on 1 and 7 DF,  p-value: 0.05296
###----ANSWER : p-value: 0.05296
#-------------QUESTION 2------------------------------
#Consider the previous problem, give the estimate of the residual standard deviation.
###----ANSWER - From summary in Q1 read
#Residual standard error: 0.223 on 7 degrees of freedom

#------------Question 3
xwt<-mtcars$wt; ympg<-mtcars$mpg; n<-length(mtcars$wt)
ssx<-sum((xwt-mean(xwt))^2)
fit<-lm(ympg~xwt);sumCoef<-summary(fit)$coeffecients
# sumCoef<-summary(fit)$coefficients
# intEst<-sumCoef[1,1];intSerr<-sumCoef[1,2];slopeEst<-sumCoef[2,1];slopSerr<-sumCoef[2,2];
# interceptCI<-intEst +c(-1,1)*qt(0.975, df=fit$df)*intSerr
# slopeCI<-slopeEst + c(-1,1)*qt(0.975,df=fit$df)*slopSerr
# newx<-seq(min(x),max(x), along.with = x)
# newRng<-data.frame(x=newx)
#
# beta1<-cor(y,x)*sd(y)/sd(x);beta0=mean(y)-beta1*mean(x);
# e<-y-beta0-beta1*x
# seBeta0=((1/n)+(mean(x)^2/ssx)^.5)*sigma
# sigma<-sqrt(sum(e^2))/(n-2)
# seBeta0=((1/n)+(mean(x)^2/ssx)^.5)*sigma
# seBeta1<-sigma/sqrt(ssx)
# se1<-sigma*sqrt(1/n)
# se2<-sigma*sqrt(1 +1/n)
###----ANSWER :
predict(fit, newdata = data.frame(x=mean(x)), interval=("confidence"))
#------------Question 5
###----ANSWER :
predict(fit, newdata = data.frame(x=3), interval=("prediction"))
#------------Question 4
#Refer to the previous question. Read the help file for mtcars. What is the weight coefficient interpreted as?
###----ANSWER : The estimated expected change in mpg per 1,000 lb increase in weight.

rm(list=ls())
#------------Question 6
x1<-mtcars$wt
y<-mtcars$mpg
x2<-x1/2
x<-x2
fit<-lm(y~x)
fit1<-lm(y~x1)
summary(fit)$coefficients
sumCoef[2,1]+c(-1,1)*qt(.975,df=fit$df)*sumCoef[2,2]
sumCoef<-summary(fit)$coefficients
#------------Question 7
#If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to the slope coefficient?
###----ANSWER : It would get multiplied by 100.

#------------Question 8
#I have an outcome, Y, and a predictor, X and fit a linear regression model with Y=β0+β1X+ϵ to obtain β^0 and β^1. What would be the consequence to the subsequent slope and intercept if I were to refit the model with a new regressor, X+c for some constant, c?
###----ANSWER : The new intercept would be β^0−cβ^1

#------------Question 9
#Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor.
#About what is the ratio of the the sum of the squared errors, \sum_{i=1}^n (Y_i - \hat Y_i)^2
# when comparing a model with just an intercept (denominator) to the model with the intercept and slope (numerator)?
fit<-lm(mpg~wt, data=mtcars);fitnoslope<-lm(mpg~1, data=mtcars)
#Hint by googling: The sum of squared errors is given by sum(sm$residuals^2)
###----ANSWER :
sum((summary(fit)$residuals)^2)/sum((summary(fitnoslope)$residuals)^2) =  0.2471672


#Question 10
#Do the residuals always have to sum to 0 in linear regression?
#The residuals must always sum to zero - WRONG
# The residuals never sum to zero.    - WRONG
###----ANSWER If an intercept is included, then they will sum to 0.
###----               Statement from Lesson01_06  Page 3/17 [Properties of the residuals]
