rankall <- function(outcome, num = "best") {
  ## Read outcome data
  allOut<-read.csv("outcome-of-care-measures.csv",colClasses="character")
  vldIns = list(abbr=c("heart attack", "heart failure", "pneumonia"), idx=c(11,17,23))
  ## Check that state and outcome are valid
  allStates<-levels(factor(allOut$State))
  if(!(state %in% allStates)) {stop("invalid state")}
  if(!(outcome %in% vldIns$abbr)) {stop("invalid outcome")}
  
  idx=match(outcome,vldIns$abbr)
  outComeColNum=vldIns$idx[idx]
  outComeName=names(allOut)[outComeColNum]
  
  suppressWarnings(
    allOut[,outComeColNum]<-as.numeric(allOut[,outComeColNum])
  )
  
  goodHosp<-subset(allOut, !is.na(allOut[outComeName]))
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
}

rankOne<-function(state,outcome,num)
{
  
  
}
