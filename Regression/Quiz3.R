#Q1
round(coef(summary(lm(mpg~factor(cyl)+wt,mtcars))),2)
#ANSWER: -6.071

#Q2
f<-lm(mpg~factor(cyl),mtcars)
fwt<-lm(mpg~factor(cyl)+wt,data=mtcars)
sapply(list(f,fwt),function(x)summary(x)$coefficients)
#ANSWER : Holding weight constant, cylinder appears to have less of an impact on mpg than if weight is disregarded.

#Q3
#ANSWER :

#Q4

#ANSWER :

#Q5

#ANSWER :

#Q6

#ANSWER :

#Q7

#ANSWER :

#Q8

#ANSWER :