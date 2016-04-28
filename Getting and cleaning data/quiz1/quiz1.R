#How many properties are worth $1,000,000 or more?
#install.packages("data.table")
library(data.table)
fileName = "housing.csv"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", fileName)
housing <- read.csv(fileName)
housing.complete <- housing[complete.cases(housing[,37]),]
nrow(housing.complete[housing.complete$VAL == 24,])

#What is the value of: sum(dat$Zip*dat$Ext,na.rm=T) 
#install.packages("xlsx")
#library(xlsx)
fileName = "gas.xlsx"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", fileName)
dat <- read.xlsx(fileName, 1, TRUE, colIndex = 7:15, rowIndex = 18:23)
sum(dat$Zip*dat$Ext,na.rm=T) 

#How many restaurants have zipcode 21231?
#install.packages("XML")
library(XML)
fileName = "restaurants.xml"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", fileName)
rest <- xmlParse(fileName, useInternalNodes = TRUE)
root <- xmlRoot(rest)
zipcodes <- xpathSApply(root, '//zipcode', xmlValue)
length(zipcodes[zipcodes == 21231])

#Which of the following is the fastest way to calculate the average value of the variable pwgtp15 
#broken down by sex using the data.table package?
fileName = "housing2.csv"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", fileName)
DT <- fread(fileName)
system.time(rowMeans(DT)[DT$SEX==1])
system.time(rowMeans(DT)[DT$SEX==2])

system.time(mean(DT[DT$SEX==1,]$pwgtp15)) #0.03    0.00    0.03 
system.time(mean(DT[DT$SEX==2,]$pwgtp15)) #0.04    0.00    0.03
    
system.time(mean(DT$pwgtp15,by=DT$SEX))

system.time(DT[,mean(pwgtp15),by=SEX]) #0       0       0

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)) #0.02    0.00    0.01 

system.time(tapply(DT$pwgtp15,DT$SEX,mean)) #0.02    0.00    0.02
