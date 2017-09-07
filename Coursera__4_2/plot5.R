setwd("C:/Stuff/Work/Coursera/Data Analysis/CourseProject2")

library(ggplot2)

if(!file.exists("./data"))
{dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI_baltimore<-NEI[NEI$fips=="24510",]

#Extract SCC numbers related to MotorVehicles
scc_motor<-SCC[grep("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE),]
scc_motor<-scc_motor[,1]

#Subset NEI based on SCC numbers related to Motor
NEI_baltimore_motor<-NEI_baltimore[NEI_baltimore$SCC %in% scc_motor,]

emissons_by_year_baltimore_motor<-aggregate(Emissions~year,NEI_baltimore_motor,FUN=sum)

png(file="plot5.png",width=480,height=480)
barplot(emissons_by_year_baltimore_motor$Emissions,names.arg=emissons_by_year_baltimore_motor$year,ylab="Emissions due to Motor Vehicles in Baltimore",xlab="Years",main="Emissions across years due to Motor Vehicles in Baltimore")
dev.off()

