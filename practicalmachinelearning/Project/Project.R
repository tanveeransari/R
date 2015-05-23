# The goal of your project is to predict the manner in which they did the exercise.
# This is the "classe" variable in the training set. You may use any of the other variables to predict with.
# You should create a report describing how you built your model,
# how you used cross validation, what you think the expected out of sample error is,
# and why you made the choices you did.
# You will also use your prediction model to predict 20 different test cases.
#
# 1.  Your submission should consist of a link to a Github repo with your R markdown
#     and compiled HTML file describing your analysis. Please constrain the text of
#     the writeup to < 2000 words and the number of figures to be less than 5.
#     It will make it easier for the graders if you submit a repo with a gh-pages branch
#     so the HTML page can be viewed online (and you always want to make it easy on graders :-).
# 2 You should also apply your machine learning algorithm to the 20 test cases available
#     in the test data above. Please submit your predictions in appropriate format to the
#     programming assignment for automated grading. See the programming assignment for additional details.
require(dplyr);

require(rattle);require(rpart.plot);

  trainAll<-read.csv(text=trainURL)
  saveRDS(trainAll,"train.rds")
} else {
  trainAll<-readRDS("train.rds")
}

  testingFinal<-read.csv(text=testURL)
  saveRDS(testingFinal,"test.rds")
} else {
  testingFinal<-readRDS("test.rds")
}
# Set seed so results are reproducible
set.seed(34455)
## -----------Cleaning DATA---------------------
#Order by username and timestamp
tidyTrain<-arrange(trainAll, user_name,num_window, raw_timestamp_part_1, raw_timestamp_part_2);
tidyTrain$X<-NULL # remove sequence number from data
# remove user_name, and num_window from dataset
tidyTrain$user_name<-NULL
tidyTrain$num_window<-NULL
# remove timestamp columns from dataset
tidyTrain<-tidyTrain[,-grep("time",names(tidyTrain))]
testing <- read.csv("testing.csv")
## -----------Choosing predictors----------
## Which columns have minimal variance
# Do analysis using nearZeroVar function based on caret preprocessing tutorial at  http://topepo.github.io/caret/preprocess.html
names(tidyTrain)[nzv]
# #This shows that new_window has near zero variance but i feel this is important as it is the start of a rep
# colsToEliminate=nzv[-1]
tidyTrain<-(tidyTrain[,-nzv])
# Set a seed so results are reproducible
## Remove columns that are mostly NAs - more than 97% NA
apply(tidyTrain,2,function(x){sum(is.na(x))/length(x)})
nullMoreThan97<-apply(tidyTrain,2,function(x){as.logical(sum(is.na(x))/length(x) > 0.975)})
tidyTrain<-tidyTrain[,-which(nullMoreThan97)]
set.seed(32323)
folds <- createFolds(y=data$classe,k=10,
## Partition training set further into training and test
trainIndex <- createDataPartition(y=tidyTrain$classe, p=0.75, list=FALSE)
training<- tidyTrain[trainIndex,]
testing<- tidyTrain[-trainIndex,]
                     list=TRUE,returnTrain=TRUE)
## Fit a Decision Tree model to the data
rpMdl<-train(classe~.,method="rpart",data=training)
#fancyRpartPlot(rpMdl$finalModel)
testing$predicted <- predict(rpMdl, newdata = testing)
confusionMatrix(testing$predicted,testing$classe)
#Shows accuracy of ~52% - terrible
#Check if any columns can be eliminated because they are all NA
## Fit a Decision Tree rpart2 model to the data
rpMdl<-train(classe~.,method="rpart2",data=training)
#fancyRpartPlot(rpMdl2$finalModel)
testing$predicted <- predict(rpMdl, newdata = testing)
confusionMatrix(testing$predicted,testing$classe)
#Shows a better accuracy of 65% better
which(sapply(data, function(x){all(is.na(x))}))
#Fit a randomForest model to data
rfMdl<-train(classe~.,method="rf",data=training)
testing$predicted<-predict(rfMdl, newdata = testing)
table(testing$predicted,testing$classe)
confusionMatrix(testing$predicted,testing$classe)
#Random forest model had an accuracy of 99%

//Lets try k-fold (10 fold) cross validation

#For the final model - lets train it on the entire testing dataset
    preProcess = c("center","scale"),
testingFinal$classe<-predict(rfMdlFinal,newdata=testingFinal)
