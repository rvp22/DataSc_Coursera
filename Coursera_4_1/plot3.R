setwd("C:/Stuff/Work/Coursera/Data Analysis/Course Project 1")

household_power_consumption <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

power<-household_power_consumption[household_power_consumption$Date %in% c("1/2/2007","2/2/2007"),]

dateTime<-paste(power$Date,power$Time," ")
dateTime<-strptime(dateTime,"%d/%m/%Y %H:%M:%S")

subMeter_1 <- as.numeric(power$Sub_metering_1)
subMeter_2 <- as.numeric(power$Sub_metering_2)
subMeter_3 <- as.numeric(power$Sub_metering_3)

png(file="plot3.png", width=480, height=480)
    plot(dateTime, subMeter_1, type="l", ylab="Energy sub metering", xlab="")
    lines(dateTime, subMeter_2, type="l",col="red")
    lines(dateTime, subMeter_3, type="l",col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
