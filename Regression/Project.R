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

data(mtcars);
#Maybe to use pairs for exploratory analysis and
# to evaluate (mullti)COLLINEARITY b/w variables
#require("GGally");
pairs(mtcars)
pairs(~mpg+disp+hp+qsec+am+wt,data=mtcars,main="Title")
#ggpairs(mtcars,,lower=list(continous="smooth",params=c(method="loess")))

# My strategy - first use SLM mpg vs am
# Next use MultipleRegression, then compare multiple models
# by combining various factors intelligently
# The following yielded pretty good results
# summary((lm(mpg~wt+hp+am+qsec,data=mtcars)))

# To compare coeffecients or residuals or anything of various models use
# lapply(list(m1,m2,m3),coef)

# Maybe generate C.I. of effect of am on mpg
# See https://class.coursera.org/statistics-003/lecture/167
require("VIF")
# Maybe generate variance inflation of adding am to set of other variables
# Manual way
# a<-suumar(lm(y~factor1+factor2=...factor[n-1]))$cov.unscaled[2,2] #From variance inflation lecture
# summary(lm(y~factor1+factor2+...+factor[n]))$cov.unscaled[2,2]/a # give us VIF of adding N
# Automatic way is to the vif(fit) function

# Finally use the F test value of am to test hypothesis that Beta[am] is non-zero
# This value is given by the t stat and the P value is what we need to look at
