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
  suppressWarnings(
    allOut[,outComeColNum]<-as.numeric(allOut[,outComeColNum])
  )
  allOut<-subset(allOut, allOut$State==state)
  
  bestOutComeVal <- min(allOut[outComeColNum],na.rm = TRUE)
#  sprintf("%s  %f","bestOutComeVal =", bestOutComeVal)
  goodHosp<-subset(allOut, !is.na(allOut[outComeName]))
  bestHosps<-goodHosp[which(goodHosp[outComeName]==bestOutComeVal),]

  if(nrow(bestHosps)==1){
    bestHosps$Hospital.Name
  }
  else if(length(bestHosps)>1) {
    b<-bestHosps[order(bestHosps$Hospital.Name),]
    b$Hospital.Name
  }
  else
  {
    bestHosps$Hospital.Name
  }
}
