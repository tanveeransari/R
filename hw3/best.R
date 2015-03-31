best <- function(state, outcome) {
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

  ## Return hospital name in that state with lowest 30-day death rate
  allOut[,outComeColNum]<-as.numeric(allOut[,outComeColNum])
  bestOutComeVal <- max(allOut[outComeColNum],na.rm = TRUE)
  print("bestOutComeVal =");print(bestOutComeVal)
  goodHosp<-subset(allOut, !is.na(allOut[outComeName]))
#   str(goodHosp)
  bestHosps<-goodHosp[which(goodHosp$outComeName==bestOutComeVal),1]
  if(length(bestHosps)==1){
    bestHosps[1]
  }
  else if(length(bestHosps)>1) {
    sort(bestHosps)[1]
  }
  else
  {
    bestHosps
  }
}