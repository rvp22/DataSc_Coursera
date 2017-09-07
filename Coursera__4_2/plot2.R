setwd("C:/Stuff/Work/Coursera/Data Analysis/CourseProject2")

if(!file.exists("./data"))
{dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#Q2

NEI_baltimore<-NEI[NEI$fips=="24510",]
emissons_by_year_baltimore<-aggregate(Emissions~year,NEI_baltimore,FUN=sum) #http://stackoverflow.com/questions/18799901/data-frame-group-by-column

png(file="plot2.png",width=480,height=480)
barplot(emissons_by_year_baltimore$Emissions,names.arg=emissons_by_year_baltimore$year,ylab="Total Emissions",xlab="Years",main="Variation of PM emissions across years in Baltimore City")
dev.off()
