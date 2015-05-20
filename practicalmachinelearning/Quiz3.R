require(AppliedPredictiveModeling);require(caret)
require(rattle);require(rpart.plot);
require(pgmm);require(tree);require(ElemStatLearn);
#Q1
data(segmentationOriginal)
training<-segmentationOriginal[segmentationOriginal$Case=="Train",]
set.seed(125)
mdl<-train(Class~., method="rpart",data=training)
fancyRpartPlot(mdl$finalModel)
# Plot the tree and answer using Plot
# ANSWER
# a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2 # PS
# b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100 # WS
# c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100  # PS
# d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2        # N/A



#Q2
# ANSWER
# The bias is larger and the variance is smaller.
# Under leave one out cross validation K is equal to the sample size.

#Q3
library(pgmm);data(olive)
olive = olive[,-1]
newdata = as.data.frame(t(colMeans(olive)))
#Answer
##train only worked when method was rpart2 not rpart, otherwise didnt match any answer choices
 mdl<-train(Area~.,method="rpart2",data=olive)
 predict(mdl$finalModel, newdata=newdata)
# The following worked though
library(tree)
t<-tree(Area~., data=olive)
predict(t, newdata)
#2.875. It is strange because Area should be a qualitative variable - but tree is reporting the
# average value of Area as a numeric variable in the leaf predicted for newdata


#Q4
# Run the code in question
library(ElemStatLearn);data(SAheart);set.seed(8484);
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,];testSA = SAheart[-train,]
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
#then start
set.seed(13234)
fit<-train(chd~age+alcohol+obesity+tobacco+typea+ldl, data=trainSA, method="glm", family="binomial")

trainSA$predict<-predict(fit,trainSA)
testSA$predict<-predict(fit,testSA)
missClass(trainSA$chd,trainSA$predict)
missClass(testSA$chd,testSA$predict)
c(missClass(trainSA$chd,trainSA$predict), missClass(testSA$chd, testSA$predict))
# 0.2727 0.3117


$Q5
vowel.test$y<-as.factor(vowel.test$y)
vowel.train$y<-as.factor(vowel.train$y)

set.seed(33833)
fit<-train(y~.,data=vowel.train, method="rf")
varImp(fit)
varImp(fit,useModel = T)

#ANSWER: The order of the variables is:
#x.2, x.1, x.5, x.6, x.8, x.4, x.9, x.3, x.7,x.10