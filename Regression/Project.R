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

# My strategy - first use SLM mpg vs am
# Next use MultipleRegression, then compare multiple models
# by combining various factors intelligently
# The following yielded pretty good results
# summary((lm(mpg~wt+hp+am+qsec,data=mtcars)))

# To compare coeffecients or residuals or anything of various models use
# lapply(list(m1,m2,m3),coef)

#Maybe to use ggpairs to evaluate (mullti)COLLINEARITY b/w variables
require("GGally");require(dplyr);
data(mtcars);
ggpairs(mtcars,,lower=list(continous="smooth",params=c(method="loess")))

#How to evaluate parsimony
