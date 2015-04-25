# Linear regression - basic assumptions -- see original content slides on
# Model Checking and model selection
#     Variance is constant
#     You are summarizing a linear trend
#     You have all the right terms in the model
#     There are no big outliers

#Conditions restated from other course
# 1) Linear relationship  - Plot residuals of e vs x (not y vs x) where e is residuals
# 2) Nearly normally distributed residuals - Can check by making histogram or a normal probability plot(qqnorm and qqline)
# 3) Constant variability of residuals. Make plot of residuals vs predicted (yhat) [Not residuals vs x]
# 4) Independent residuals . Just plot residuals without any x axis

require("car");require("GGally")

data(mtcars);
#Maybe to use pairs for exploratory analysis and
#pairs(~mpg+disp+hp+qsec+am+wt,data=mtcars,main="Title")
ggpairs(c(1,3,4,6,7,9),data=mtcars,lower=list(continous="smooth",params=c(method="loess")))

# The following yielded pretty good results
# summary((lm(mpg~wt+hp+am+qsec,data=mtcars)))

all<-lm(mpg~.,mtcars)
wthp<-lm(mpg~wt+hp,mtcars)
wthpqsec<-lm(mpg~wt+hp+qsec,mtcars)
wthpam<-lm(mpg~wt+hp+am,mtcars)
wthpqsecam<-lm(mpg~wt+hp+qsec+am,mtcars)
wthpqsecamdspl<-lm(mpg~wt+hp+qsec+am+disp,mtcars)
models<-list("all"=all,"wthp"=wthp,"wthpqsec"=wthpqsec,"wthpam"=wthpam,
             "wthpqsecam"=wthpqsecam,"wthpqsecamdspl"=wthpqsecamdspl)

sapply(models,function(x){summary(x)$adj.r.squared})


anova(wthp,wthpam,wthpqsecam,wthpqsecamdspl)
anova(wthp,wthpqsec,wthpqsecam,wthpqsecamdspl)

# Maybe generate C.I. of effect of am on mpg
# See https://class.coursera.org/statistics-003/lecture/167
