setwd("C:/Stuff/Work/Coursera/Data Analysis/Course Project 1")

household_power_consumption <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

power<-household_power_consumption[household_power_consumption$Date %in% c("1/2/2007","2/2/2007"),]

dateTime<-paste(power$Date,power$Time," ")

#?strptime
dateTime<-strptime(dateTime,"%d/%m/%Y %H:%M:%S")

globalActivePower<-as.numeric(power$Global_active_power)

png(file="plot2.png", width=480, height=480)
plot(dateTime,globalActivePower,type="l",xlab="",ylab="Global Active Power(kiowatts)")
dev.off()
