setwd("C:/Stuff/Work/Coursera/Data Analysis/CourseProject2")

library(ggplot2)

if(!file.exists("./data"))
{dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#Q3

NEI_baltimore<-NEI[NEI$fips=="24510",]
emissons_by_year_baltimore<-aggregate(Emissions~year+type,NEI_baltimore,FUN=sum) 

#Using facets

png(file="plot3.png",width=480,height=480)

g1<-ggplot(emissons_by_year_baltimore,aes(year,Emissions))

p1<-g1+geom_point()+facet_grid(type ~ .)+geom_line()

print(p1)

#OR
#g1<-ggplot(emissons_by_year_baltimore,aes(year,Emissions,col=type))
#p1<-g1+geom_point()+geom_line()
#print(p1)

dev.off()

