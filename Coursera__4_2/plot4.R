setwd("C:/Stuff/Work/Coursera/Data Analysis/CourseProject2")

library(ggplot2)

if(!file.exists("./data"))
{dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#Extract SCC numbers related to Coal
scc_coal<-SCC[grep("coal",SCC$EI.Sector,ignore.case=TRUE),]
scc_coal<-scc_coal[,1]

#Subset NEI based on SCC numbers related to coal
NEI_coal<-NEI[NEI$SCC %in% scc_coal,]

emissons_by_year_coal<-aggregate(Emissions~year,NEI_coal,FUN=sum)

png(file="plot4.png",width=480,height=480)
barplot(emissons_by_year_coal$Emissions,names.arg=emissons_by_year_coal$year,ylab="Total Emissions",xlab="Years",main="Variation of PM emissions across years due to Coal")
dev.off()
