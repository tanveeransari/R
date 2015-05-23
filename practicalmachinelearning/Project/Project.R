require(dplyr);
require(data.table);
require(caret);
require(randomForest);

if(!(file.exists("training.csv"))) {
  download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",destfile="training.csv")
}

if(!(file.exists("testing.csv"))) {
  download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv",destfile="training.csv")
}

testing <- read.csv("testing.csv")
data <- read.csv("training.csv")
# Set a seed so results are reproducible
set.seed(32323)
folds <- createFolds(y=data$classe,k=10,
                     list=TRUE,returnTrain=TRUE)

#Check if any columns can be eliminated because they are all NA
which(sapply(data, function(x){all(is.na(x))}))

//Lets try k-fold (10 fold) cross validation
train_control<-trainControl(method = "repeatedcv", number = 10)

fit<-train(classe~.,method="rf", train_control=train_control,
    preProcess = c("center","scale"),
    data=data)