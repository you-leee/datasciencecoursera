#How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
#http://biostat.jhsph.edu/~jleek/contact.html 
con <-url("http://biostat.jhsph.edu/~jleek/contact.html")
content <- readLines(con)
c(nchar(content[10]), nchar(content[20]), nchar(content[30]), nchar(content[100]))
close(con)

#Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
#https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
forFile <- x <- read.fwf(
    file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
    skip=4,
    widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4))
sum(forFile[,4])
close(url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"))

#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
#Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
url <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")
acs <- read.csv(url)
