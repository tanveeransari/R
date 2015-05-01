
library(MASS)
data(shuttle)

#NOTE : f you want to interpret the estimated effects as relative odds ratios,
# just do exp(coef(x)) (gives you e??, the multiplicative change in the odds ratio
# for y=1 if the covariate associated with ?? increases by 1).

##Q1
useauto<-as.numeric(shuttle$useauto)
#Relevel to set tail as first because Denominator is tail and head is numerator
windtail<-relevel(shuttle$wind,"tail")
exp(summary(glm(useauto~factor(windtail),family=binomial))$coefficients)
##ANSWER: Coefficient of factor(windtail)head os 0.968688

##Q2
exp(summary(glm(useauto~factor(windtail)+factor(magn),family=binomial))$coefficients

##Q3
#Compare the following two
summary(glm(useauto~factor(windtail),family=binomial))$coefficients
summary(glm(1-useauto~factor(windtail),family=binomial))$coefficients

##ANSWER:  Coefficients reverse their sign

##Q4
# We relevel to set B as the base level so it becomes intercept as
# SprayB is denorminator and SprayA is numerator
spraylevels<-relevel(as.factor(InsectSprays$spray),'B')
exp(summary(glm(InsectSprays$count~spraylevels,family=poisson,data=InsectSprays))$coefficients)

##Q5
#WRONG : The coefficient estimate is divided by 10.
#WRONG : The coefficient is subtracted by log(10).
##ANSWER : The coefficients reverse their signs.
##Q6
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
knots=0

splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
xMat <- cbind(1, x, splineTerms)
summary(lm(y ~ xMat-1)) # because we added intercept to xMat in the line before
yhat<-predict(lm(y~xMat-1))

yhat[8]-yhat[7]