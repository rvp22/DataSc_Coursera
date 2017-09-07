Coursera Reproducible Research - Project 1
==========================================

Raghunath 9/2/2017

This assignment makes use of data from a personal activity monitoring
device. This device collects data at 5 minute intervals through out the
day. The data consists of two months of data from an anonymous
individual collected during the months of October and November, 2012 and
include the number of steps taken in 5 minute intervals each day.

Load and preprocessing the data:

    library(ggplot2)

    ## Warning: package 'ggplot2' was built under R version 3.3.3

    #setwd("C:/Stuff/Work/Coursera/RR/Course Project 1")

    #if(!file.exists("./data"))
    #{dir.create("./data")}

    #fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
    #download.file(fileUrl,destfile="./data/Dataset.zip")

    #unzip(zipfile="./data/Dataset.zip",exdir="./data")

    activity <- read.csv("C:/Stuff/Work/Coursera/RR/Course Project 1/data/activity.csv", stringsAsFactors=FALSE)

    activity$date <- as.Date(activity$date, "%Y-%m-%d") 
    names(activity)<-c("No_of_Steps","Date","Interval_Id")

#### Calculate number of steps taken per day

1.  Calculating total number of steps taken per day and plotting a
    histogram.

<!-- -->

    steps_per_day<-aggregate(No_of_Steps~Date,activity,sum)

    qplot(steps_per_day$No_of_Steps, xlab='Total steps per day', ylab='Frequency', binwidth=1000)

![](https://github.com/rvp22/RepData_PeerAssessment1/blob/master/unnamed-chunk-2-1.png)

    mean_steps<-mean(steps_per_day$No_of_Steps)
    mean_steps

    ## [1] 10766.19

    median_steps<-median(steps_per_day$No_of_Steps)
    median_steps

    ## [1] 10765

1.  

-   Mean of the total number of steps taken is 1.076618910^{4}.
-   Median of the total number of steps taken is 10765.

#### What is the average daily activity pattern?

1.  We will first create a time series plot of the 5-minute interval and
    the average number of steps taken, averaged across all days

<!-- -->

    average_daily<-aggregate(No_of_Steps~Interval_Id,activity,mean,na.rm=TRUE)

    plot(average_daily$Interval_Id,average_daily$No_of_Steps,type="l",xlab="Interval Id",ylab="Average no. of Steps")

![](https://github.com/rvp22/RepData_PeerAssessment1/blob/master/unnamed-chunk-3-1.png)

1.  Finding the most active interval on average...

<!-- -->

    Most_Active_IntervalId<-average_daily[which.max(average_daily$No_of_Steps),2]

The interval Id across all of the dates in the dataset that contains the
maximum number of steps on average is Interval 206.1698113

#### Imputing Missing values

    Number_NA<-sum(as.numeric(is.na(activity$No_of_Steps)))

    Indices_NA<-which(is.na(activity$No_of_Steps))

    Imputed_activity<-activity
    Imputed_activity[Indices_NA,1]<-average_daily[which(average_daily[,1] %in% activity[Indices_NA,3]),2]

1.  The number of missing values is 2304.

2.  Imputation of missing values is done considering the mean for the
    particular 5-minute interval in which number of steps taken is
    unknown.

3.  We will plot a histogram of the total number of steps taken each day
    after imputing the missing values. And recalculate the mean and
    median.

<!-- -->

    Imputed_steps_per_day<-aggregate(No_of_Steps~Date,Imputed_activity,sum)
    qplot(Imputed_steps_per_day$No_of_Steps, xlab='Total steps per day', ylab='Frequency', binwidth=1000)

![](https://github.com/rvp22/RepData_PeerAssessment1/blob/master/unnamed-chunk-6-1.png)

    Imputed_mean_steps<-mean(Imputed_steps_per_day$No_of_Steps)
    Imputed_median_steps<-median(Imputed_steps_per_day$No_of_Steps)

-   Mean of the total number of steps taken after imputing missing
    values is 1.076618910^{4}.
-   Median of the total number of steps taken after imputing missing
    values is 1.076618910^{4}.

So, mean before and after imputing remains same. Median increases.

### Are there differences in activity patterns between weekdays and weekends?

1.  Creating a new factor variable in the dataset with two levels -
    "weekday" and "weekend" indicating whether a given date is a weekday
    or weekend day.

<!-- -->

    Imputed_activity$WeekDay<-weekdays(Imputed_activity$Date)

    Imputed_activity$WeekDay<-(as.numeric(Imputed_activity$WeekDay %in% c("Saturday","Sunday")))

    WorkingDay_Rows<-which(Imputed_activity$WeekDay==0)
    Imputed_activity[WorkingDay_Rows,4]<-"WorkingDays"
    WorkingDay_Rows<-which(Imputed_activity$WeekDay==1)
    Imputed_activity[WorkingDay_Rows,4]<-"Weekends"

    Imputed_activity$WeekDay<-as.factor(Imputed_activity$WeekDay)

1.  A panel plot containing a time series plot of the 5-minute
    intervaland the average number of steps taken, averaged across all
    weekday days or weekend days.

<!-- -->

    Imputed_average_daily<-aggregate(No_of_Steps~Interval_Id+WeekDay,Imputed_activity,mean,na.rm=TRUE)

    g<-ggplot(Imputed_average_daily,aes(Interval_Id,No_of_Steps))
    g1<-g+geom_point()+facet_grid(WeekDay ~ .)+geom_line()+xlab("Interval ID")+ylab("Average no. of Steps")

    print(g1)

![](https://github.com/rvp22/RepData_PeerAssessment1/blob/master/unnamed-chunk-8-1.png)

Using  Base Plotting System :

    par(mfrow=c(2,1))
    Imputed_activity_WorkingDays<-Imputed_activity[which(Imputed_activity$WeekDay=="WorkingDays"),]
    average_daily_WorkingDays<-aggregate(No_of_Steps~Interval_Id,Imputed_activity_WorkingDays,mean,na.rm=TRUE)
    plot(average_daily_WorkingDays$Interval_Id,average_daily_WorkingDays$No_of_Steps,type="l",xlab="Interval ID",ylab="Average no. of Steps",main="Working Days")

    Imputed_activity_Weekends<-Imputed_activity[which(Imputed_activity$WeekDay=="Weekends"),]
    average_daily_weekends<-aggregate(No_of_Steps~Interval_Id,Imputed_activity_Weekends,mean,na.rm=TRUE)
    plot(average_daily_weekends$Interval_Id,average_daily_weekends$No_of_Steps,type="l",xlab="Interval ID",ylab="Average no. of Steps",main="Weekends")

![](https://github.com/rvp22/RepData_PeerAssessment1/blob/master/unnamed-chunk-9-1.png)
