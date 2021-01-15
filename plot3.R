## For Exploratory Data Analysis Week 1 Course Project
## Plot 2 (line chart of power vs weekday)

## Read only data required for February 1, 2007 to February 2, 2007
## Data is structured as one row per minute
## Starting row is determined by first reading the datetime of the first row
## and calculating number of rows to skip
## Number of rows needed is calculated by the difference in end and start times

library(lubridate)

first5 <- read.table("household_power_consumption.txt",sep=";",nrows = 5,header = TRUE)
classes <- sapply(first5,class)
cnames <- colnames(first5)

firstdatetime <- as.POSIXlt(dmy(first5$Date[1]) + hms(first5$Time[1]))
starttime <- as.POSIXlt(dmy("01-02-2007")+ hms("00:00:00"))
endtime <- as.POSIXlt(dmy("03-02-2007"))
skiprows <- as.numeric(difftime(starttime,firstdatetime,unit="mins"))
numrows <- as.numeric(difftime(endtime,starttime,unit="mins"))

ElecDB <- read.table("household_power_consumption.txt",sep=";",skip = skiprows,nrows = numrows,header = TRUE,colClasses = classes,col.names = cnames)

## add datetime column
datetime <- as.POSIXlt(dmy(ElecDB$Date)+ hms(ElecDB$Time))
ElecDB <- cbind(ElecDB,datetime)

## Make the histogram plot and copy it into the png file
par(mfrow=c(1,1))
with(ElecDB,plot(datetime,Sub_metering_1,type='l',col="black",xlab="",ylab="Energy sub metering"))
with(ElecDB,lines(datetime,Sub_metering_2,type='l',col="red"))
with(ElecDB,lines(datetime,Sub_metering_3,type='l',col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),text.width = 70000)
 
dev.copy(png,file = "plot3.png")
dev.off()