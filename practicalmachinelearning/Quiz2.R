#Q1
#Only worked with list = F
#----------------------------------
#Q2
# Doing a summary after doing log shows -Inf
#WRONG: The SuperPlasticizer data include negative values so the log transform can not be performed.
#WRONG : The log transform produces negative values which can not be used by some classifiers.
#----------------------------------
#Q3
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
#----------------------------------
ilNames<-names(training)[grep("^IL",names(training))]
#Way to do without caret package
#smallTrain<-training[,ilNames]
# prc<-prcomp(smallTrain, center = T, scale=T)
# summary(prc)
#Answer 7 - by looking at cumulative variance
smallTrain<-training[,ilNames]
# From https://tgmstat.wordpress.com/2013/11/28/computing-and-visualizing-pca-in-r/
trans<-preProcess(smallTrain, method=c("pca"), thresh = 0.8)
trans$rotation
#rotation provides representation of the OLD variables in terms of the
# principal components. - shows PC1 to PC7 so
#Answer 7
#----------------------------------

#Q4

set.seed(3433)
data(AlzheimerDisease)
ilNames<-names(predictors)[grep("^IL",names(predictors))]
adData = data.frame(diagnosis, predictors[ilNames])set.seed(3433)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
mdlAll<-train(diagnosis~.,method="glm",data=training)
confusionMatrix(testing$diagnosis, predict(mdlAll, newdata=testing))

mdlPCA<-train(diagnosis~.,method="glm",preProcess="pca",data=training,trControl=trainControl(preProcOptions = list(thresh=0.8)))
confusionMatrix(testing$diagnosis, predict(mdlPCA, newdata=testing))
