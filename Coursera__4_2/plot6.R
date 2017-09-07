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
NEI_LA<-NEI[NEI$fips=="06037",]

#Extract SCC numbers related to MotorVehicles
scc_motor<-SCC[grep("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE),]
scc_motor<-scc_motor[,1]


NEI_baltimore_motor<-NEI_baltimore[NEI_baltimore$SCC %in% scc_motor,]
NEI_LA_motor<-NEI_LA[NEI_LA$SCC %in% scc_motor,]

emissons_by_year_baltimore_motor<-aggregate(Emissions~year,NEI_baltimore_motor,FUN=sum)
emissons_by_year_LA_motor<-aggregate(Emissions~year,NEI_LA_motor,FUN=sum)

emissons_by_year_baltimore_motor$city<-"Baltimore"
emissons_by_year_LA_motor$city<-"LA"

combined<-rbind(emissons_by_year_baltimore_motor,emissons_by_year_LA_motor)

png(file="plot6.png",width=480,height=480)

g1<-ggplot(combined,aes(year,Emissions,col=city))
p1<-g1+geom_point()+geom_line()+labs(title="Emissions from motor vehicles in Baltimore City wand Los Angeles County")
print(p1)

dev.off()
