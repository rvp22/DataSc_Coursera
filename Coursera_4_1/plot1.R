setwd("C:/Stuff/Work/Coursera/Data Analysis/Course Project 1")

if(!file.exists("./data"))
{dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

household_power_consumption <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

#household_power_consumption$Date<-as.Date(household_power_consumption$Date,"%d/%m/%Y")
#household_power_consumption$Date<-format(household_power_consumption$Date,"%d/%m/%Y")

power<-household_power_consumption[household_power_consumption$Date %in% c("1/2/2007","2/2/2007"),]

globalActivePower<-as.numeric(power$Global_active_power)

png(file="plot1.png",width=480,height=480)

hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()

