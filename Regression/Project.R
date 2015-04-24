# Linear regression - basic assumptions -- see original content slides on 
# Model Checking and model selection
#     Variance is constant
#     You are summarizing a linear trend
#     You have all the right terms in the model
#     There are no big outliers


# My strategy - first use SLM mpg vs am
# Next use MultipleRegression, then compare multiple models
# by combining various factors intelligently
#The following yielded pretty good results
summary((lm(mpg~wt+hp+am+qsec,data=mtcars)))
#
# Plot residuals

#Maybe to use ggpairs to evaluate (mullti)COLLINEARITY b/w variables
require("GGally");require(dplyr);
data(mtcars);
ggpairs(mtcars,,lower=list(continous="smooth",params=c(method="loess")))

#How to evaluate parsimony
