
#Loading training datset. X contains measurements and Y contains labels, subject_train contains subject id


y_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", col.names="Label")
subject_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", col.names="SubjectID")
X_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")

y_train<- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", col.names="Label")
subject_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", col.names="SubjectID")
X_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")

#1. Merging training and test sets to create one dataset
Combined <- rbind(cbind(subject_test, y_test, X_test ),
              cbind(subject_train, y_train, X_train ))

#2. Extracting only the measurements on the mean and standard deviation for each measurement


features <- read.table("C:/Stuff/Work/Coursera/Getting and Cleaning Data/Prg Assignment Lst week/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
#Read mean and SD
features_M_S <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

# select only the means and standard deviations from data
# increment by 2 because data has subjects and labels in the beginning
Combined_M_S <- Combined[, c(1, 2, features_M_S$V1+2)]

#3
# Reading labels
labels <- read.table("C:/Stuff/Work/Coursera/Getting and Cleaning Data/Prg Assignment Lst week/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
#Give descriptive names to labels
Combined_M_S$Label <- labels[Combined_M_S$Label, 2]

#4

Current_names <- c("subject", "label", features_M_S $V2)

# Tidying the column names by removing non alphabetic characterst
New_Names <- tolower(gsub("[^[:alpha:]]", "", Current_names))

colnames(Combined_M_S) <- New_Names

#Final table by taking means of the activities for each person
new_data <- aggregate(Combined_M_S[, 3:ncol(Combined_M_S)],by=list(SubjectID = Combined_M_S$SubjectID,Label = Combined_M_S$Label),mean)

#Final Table
write.table(format(new_data, scientific=T), "tidy2.txt",row.names=F, col.names=F, quote=2) 
