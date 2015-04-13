complete<-function(directory, id = 1:332) {
  dat<-data.frame(length(id),2)
  dat<-dat[-1,]
  files_full = list.files(directory, full.names = TRUE)
  for(i in id) {   
      fl<-read.csv(files_full[i])
      tmp<-c(i,nrow(fl[complete.cases(fl),]))
      dat<-rbind(dat,tmp)
  }
  names(dat)[1]<-"id";names(dat)[2]<-"nobs";
  dat
}