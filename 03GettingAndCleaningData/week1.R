rm(list=ls())
setwd("03- Getting and Cleaning Data/")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" ,destfile = "getdata_data_ss06hid.csv" )

MyData <- read.csv("getdata_data_ss06hid.csv")
names(MyData) 
values <- MyData$VAL
sum(values[!is.na(values)]==24)

MyData.FES <- MyData$FES
View(MyData.FES)


# Question 3 --------------------------------------------------------------
library(xlsx)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx" , destfile = "getdata_data_DATA.gov_NGAP.xlsx", mode='wb')

dat <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx" ,sheetIndex = 1, rowIndex= 18:23 , colIndex=7:15 , header = T)

sum(dat$Zip*dat$Ext,na.rm=T) 


# Question 4 --------------------------------------------------------------

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml " , destfile = "getdata_data_restaurants.xml" )
library(XML)
doc <- xmlTreeParse("getdata_data_restaurants.xml" , useInternal = T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
zipcode <-as.integer(xpathSApply(rootNode , "//zipcode" , xmlValue))
sum(zipcode==21231)


# Question 5 --------------------------------------------------------------
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
 " , destfile = "data_2.R" )
library(data.table)
DT <- as.data.table(read.csv("data_2.csv"))
DT$pwgtp15
DT 
# Which of the following is the fastest way to calculate the average value of the variable
# pwgtp15 
# broken down by sex using the data.table package?

DT[,mean(pwgtp15),by=SEX]
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
sapply(split(DT$pwgtp15,DT$SEX),mean)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
tapply(DT$pwgtp15,DT$SEX,mean)
mean(DT$pwgtp15,by=DT$SEX)

system.time(DT[,mean(pwgtp15),by=SEX])
system.time(rowMeans(DT)[DT$SEX==1])
system.time(rowMeans(DT)[DT$SEX==2])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))


