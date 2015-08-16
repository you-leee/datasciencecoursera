w1<-read.csv(file="hw1_data.csv")
w1[1:2,]
nrow(w1)
w1[152:153,]
w1[47,]$Ozone
bad <- is.na(w1$Ozone)
mean(w1$Ozone[!bad])
goodW1 <- complete.cases(w1)
goodW1 <- w1[goodW1,]
highOzoneAndTemp <- goodW1$Ozone>31 & goodW1$Temp>90
goodW1.highOzoneAndTemp <- goodW1[highOzoneAndTemp,]
mean(goodW1.highOzoneAndTemp$Solar.R)
w1.completeTempMonth <- w1[complete.cases(w1$Temp,w1$Month),]
mean(w1.completeTempMonth[w1.completeTempMonth$Month == 6,]$Temp)
w1.completeMonthOzone <- w1[complete.cases(w1$Ozone,w1$Month),]
max(w1.completeMonthOzone[w1.completeMonthOzone$Month == 5,]$Ozone)