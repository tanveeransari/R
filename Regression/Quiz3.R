#Q1
round(coef(summary(lm(mpg~factor(cyl)+wt,mtcars))),2)
##ANSWER: -6.071

#Q2
f<-lm(mpg~factor(cyl),mtcars)
fwt<-lm(mpg~factor(cyl)+wt,data=mtcars)
sapply(list(f,fwt),function(x)summary(x)$coefficients)
##ANSWER : Holding weight constant, cylinder appears to have less of an impact on mpg than if weight is disregarded.

#Q3
f2<-lm(mpg~factor(cyl)*wt,mtcars)
anova(fwt,f2)
##ANSWER :The P-value is larger than 0.05. So, according to our criterion,
##we would fail to reject, which suggests that the interaction terms may not be necessary.

#Q4
One ton is 2000 lbs approx. 
##ANSWER :
##The estimated expected change in MPG per one ton increase in weight for a 
##specific number of cylinders (4, 6, 8).
#WRONG: The estimated expected change in MPG per one ton increase in weight.

#Q5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72);y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

#ANSWER :max(hatvalues(lm(y~x)))

#Q6
#values are same as above
hatvalues(fit)[which(hatvalues(fit)==max(hatvalues(fit)))] tells us 5 has max hatvalue

#ANSWER :dfbetas(fit)[5,2]

#Q7

##ANSWER :t is possible for the coefficient to reverse sign after adjustment. 
##For example, it can be strongly significant and positive before adjustment and strongly significant and negative after adjustment.
##
WRONG: For the the coefficient to change sign, there must be a significant interaction term.
