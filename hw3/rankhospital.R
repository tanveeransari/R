rankhospital <- function(state, outcome, num = "best") {
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
  
  ## Return hospital name in that state with the given rank 30-day death rate
  ## Return hospital name in that state with lowest 30-day death rate

  suppressWarnings(
    allOut[,outComeColNum]<-as.numeric(allOut[,outComeColNum])
  )
  
  allOut<-subset(allOut, allOut$State==state)
  goodHosp<-subset(allOut, !is.na(allOut[outComeName]))
  
  if(num=="best"|| num=="worst") {
    if(num=="best")   {
      bestOutComeVal <- min(goodHosp[outComeColNum],na.rm = TRUE)
      sprintf("%s  %f","Best OutCome =", bestOutComeVal)
    } else if(num=="worst")  {
      bestOutComeVal <- max(goodHosp[outComeColNum],na.rm = TRUE)
      sprintf("%s  %f","Worst Out Come =", bestOutComeVal)
    }
    
    bestHosps<-goodHosp[which(goodHosp[outComeName]==bestOutComeVal),]
    
    if(nrow(bestHosps)==1){
      bestHosps$Hospital.Name
    } else if(length(bestHosps)>1) {
      b<-bestHosps[order(bestHosps$Hospital.Name),]
      b$Hospital.Name
    } else
    {
      bestHosps$Hospital.Name
    }
  } else {  #Not best or worst  
    #check if num is integer
    if(!is.na(as.numeric(num))) 
    {
      b<-goodHosp[order(goodHosp[outComeColNum], goodHosp$Hospital.Name),]
      if(nrow(b)<num) {
        NA
      } else {
        #vlu = b[num,outComeColNum] #b<-b[which(b[outComeName]==vlu),]
        #print(b[1:num,c(2,7,17)])
        b[num,2]
      } 
    } else {
      # Throw error as num was not "best"/"worst" or numeric
      stop("num must be \"best\", \"worst\", or a numeric value")
      #return
    }
  }
  
}
