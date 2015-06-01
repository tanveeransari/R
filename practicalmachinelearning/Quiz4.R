library(caret)
library(ElemStatLearn)
Q1:

data(vowel.train)
data(vowel.test)
vowel.train$y<-as.factor(vowel.train$y)
vowel.test$y<-as.factor(vowel.test$y)
set.seed(33833)
rffit<-train(y~.,data=vowel.train, method="rf")
gbmfit<-train(y~., method="gbm", data=vowel.train, verbose=F)
vowel.test$y.gbm<-predict(gbmfit, newdata=vowel.test)
vowel.test$y.rf<-predict(rffit, newdata=vowel.test)

count(vowel.test$y==vowel.test$y.gbm)
sum(vowel.test$y==vowel.test$y.gbm)/nrow(vowel.test)
#52.6%
count(vowel.test$y==vowel.test$y.rf)
sum(vowel.test$y==vowel.test$y.rf)/nrow(vowel.test)
#60.3%
confusionMatrix(vowel.test$y.gbm, vowel.test$y.rf)
sum(vowel.test$y.gbm==vowel.test$y.rf)/nrow(vowel.test)
#66.67%
#None of the answers matched so picked the closest
# RF Accuracy = 0.6061
# GBM Accuracy = 0.5325
# Agreement Accuracy = 0.6518

Q2:
library(caret)
library(gbm)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
#Do the question load work then
set.seed(62433)
rffit<-train(diagnosis~.,method="rf",data=training)
gbmfit<-train(diagnosis~.,method="gbm",data=training, verbose=F)
ldafit<-train(diagnosis~., method="lda",data=training)

predrf<-predict(rffit, testing)
predgbm<-predict(gbmfit,testing)
predlda<-predict(ldafit,testing)

# Stacked prediction
predstacked<-data.frame(predrf,predgbm,predlda, diagnosis=testing$diagnosis)
set.seed(62433)
comboFit<-train(diagnosis~.,method="rf",data=predstacked)
comboPred<-predict(comboFit, testing)

confusionMatrix(predrf,testing$diagnosis)$overall[[1]]    #0.7682
confusionMatrix(predgbm,testing$diagnosis)$overall[[1]]   #0.804878
confusionMatrix(predlda,testing$diagnosis)$overall[[1]]   #0.7682927
confusionMatrix(comboPred,testing$diagnosis)$overall[[1]] #0.8170732

#ANSWER:  Since none of the answers matched exactly I chose
# Stacked Accuracy: 0.79 is better than random forests and lda and the same as boosting.

#Q3
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
### Load above stuff then
set.seed(233)
lassofit<-train(CompressiveStrength~.,method="lasso",data=training)
plot.enet(lassofit$finalModel, xvar="penalty", use.color=T)
# ANSWER : Concrete

#Q4:
library(lubridate)  # For year() function below
#dat = read.csv("~/Desktop/gaData.csv")
dat<-read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)
#====================
library(forecast)
batsmodel<-bats(tstrain)
# DOESNT WORK - predict(batsmodel, newdata, interval="confidence/prediction")
fcastTrain<-forecast(batsmodel,nrow(testing),level=c(95))
t<-data.frame(value=testing$visitsTumblr, lower=fcastTrain$lower, upper=fcastTrain$upper)
t<-data.frame(value=testing$visitsTumblr, lower=fcastTrain$lower, upper=fcastTrain$upper)
100 * nrow(t[which(t$value<t$upper & t$value>t$lower),])/nrow(testing) # 96.17
#ANSWER : 96%

#Q5
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
set.seed(3523)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
# and then.....
set.seed(325)
y<-training$CompressiveStrength
x<-subset(training,select = -CompressiveStrength)
svmModel<-svm(x,y)
testing$pred<-predict(svmModel, newdata=subset(testing, select=-CompressiveStrength))
sqrt(mean((testing$pred - testing$CompressiveStrength)^2)) # 6.715
#ANSWER: 6.72

