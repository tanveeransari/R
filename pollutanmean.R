pollutantmean <- function(directory, pollutant, id = 1:332) {
  dat = data.frame()
  for(i in id)
  {
    filename<-sprintf("%03d%s",i,".csv")
    fl<-read.csv(file.path(directory,filename))
    dat<-rbind(dat,fl)
  }
  
  #Method 1 - use is.na to remove NAs
  #plt<-dat[pollutant]
  #mean(plt[!is.na(plt)])
  
  #Method 2 - use the na.rm to remove bad args
  mean(dat[,pollutant],na.rm=TRUE)
}