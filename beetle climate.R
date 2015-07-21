library(dplyr)
##############
# Setting up the datasets
tempData <- read.delim("C:/Users/klevan/Desktop/Beetle Baselining/tempData.txt", stringsAsFactors=FALSE)
tempData <- tempData[,1:13]

#yr <- (as.numeric(gsub('.{4}$','',tempData$DATE)))
#mo <- head(as.numeric(gsub('.{5}$','',gsub('^.{7}','',tempData$DATE))))
#day <- (as.numeric(gsub('.{3}','',tempData$DATE)))

tempData <- tempData %>% arrange (Domain,YEAR,julianDay)
dom <- sort(unique(tempData$Domain))
yr <- rep(0,length(dom))
# How many years of data per domain?
for (i in 1:length(unique(tempData$Domain))){
  x <- subset(tempData,Domain==dom[i])
  yr[i] <- length(unique(x$YEAR))
}
matrix(rep(0,(year[i,2]*2)),nrow=year[i,2],ncol=2, dimnames=list(yr,c("Start","Stop")))
# These values are based on thirty year averages of minimum lows
start <- matrix(c(1:20,119, 82, 1, 1, 124, 96, 68, 47, 124, 117, 54, 180, 96, 1, 96, 40, 12, 173, 152, 1),
                nrow=20,ncol=2,byrow=FALSE,
                dimnames=list(1:20,c("Domains","Julian Start")))
end <- matrix(c(1:20, 287,306,365,365,278,299,313,334,271,285,327,215,292,365,292,334,334,215,243,365),
                nrow=20,ncol=2,byrow=FALSE,
                dimnames=list(1:20,c("Domains","Julian End")))
year <- cbind(dom,yr,start[c(1,3,5:9,12,15:20),2],end[c(1,3,5:9,12,15:20),2])
colnames(year) <- c("Domain","Year","Start","End")
year <- as.data.frame(year) # Predicted start and stop dates based on thirty yr averages

####################
# Start and stop dates per year
# Making a matrix that includes running average
# Then synthesizing what the start and end date are for each year
obs <- matrix(c(rep(1,8),rep(3,44),rep(5,74),rep(6,101),rep(7,101),
                rep(8,101),rep(9,101),rep(12,101),rep(15,87),rep(16,31),
                rep(17,23),rep(18,66),rep(19,86),rep(20,66),rep(0,990*3)),
              nrow=990,ncol=4,byrow=FALSE,
              dimnames=list(1:990,c("Domain","Year","Julian Start","Julian End")))
k=vector()
for (i in dom){
  # Makes an empty matrix to say what the start and stop dates were for each yr
  k <- c(k,unique(subset(tempData,Domain==i)$YEAR)) 
}
obs[,2] <- k
######################
# Filling in the observed values table
k1=vector()
k2=vector()
for (i in 1:length(dom)){
  d <- subset(tempData,Domain==dom[i])
  # Makes an empty matrix to say what the start and stop dates were for each yr
  yr <- sort(unique(d$YEAR)) 
  h<-matrix(rep(0,(year[i,2]*2)),nrow=year[i,2],ncol=2, dimnames=list(yr,c("Start","Stop"))) 
  h<-as.data.frame(h)
  # Making the list of average 10-day running averages
  Avg <- rep(0,(length(d[,1])-9))
  for (j in 1:(length(d[,1])-9)){
    d$MIN <- as.numeric(d$MIN)
    Avg[j] <- mean(d$MIN[j:(j+9)])
  }
  Avg1 <- c(rep(NA,9),Avg)
  d <- cbind(d,Avg1) # now d has the 10 day running average appended

  for (k in 1:length(yr)){
    d <- d %>% filter(Avg1>-999)
    yr1<-subset(d,YEAR==yr[k])
    yr2<-subset(yr1,Avg1>=4)
    h[k,1]<-min(yr2$julianDay)
    h[k,2]<-max(yr2$julianDay)
    k=k+1
  }
  k1 <- c(k1,h[,1]) 
  k2 <- c(k2,h[,2]) 
  i=i+1
}


obs[,3] <- k1
obs[,4] <- k2
# Now obs has the start and stop dates for each year!
obs <- as.data.frame(obs)
###############
## Bootstrapping
pStart <- rep(0,length(dom))
for (i in 1:length(dom)) {
  n <- subset(obs,Domain==dom[i])[,3]
start<-sample(n,10000,replace=TRUE)
pStart[i]<-length(subset(start,year[i,3]<start))/10000
i=i+1
}

pEnd <- rep(0,length(dom))
for (i in 1:length(dom)) {
  n <- subset(obs,Domain==dom[i])[,4]
  end<-sample(n,10000,replace=TRUE)
  pEnd[i]<-length(subset(end,year[i,4]>end))/10000
  i=i+1
}
 tbl1<- cbind(year,pStart,pEnd)
