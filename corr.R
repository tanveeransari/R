corr<-function(directory, threshold = 0) {
  allcorr=vector()
  files_full = list.files(directory, full.names = TRUE)
  
  for(i in files_full) {
    file<-read.csv(i)
    
    goodros<-file[complete.cases(file),]
    if(nrow(goodros)>threshold) {
      cr<-cor(goodros$sulfate,goodros$nitrate)
      allcorr=c(allcorr,cr)
    }
  }
  
  allcorr
}