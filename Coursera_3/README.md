One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:
 '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Analysis File Explanation: 

#1.Merges the training and the test sets to create one data set.
	This involves merging files : y_test.txt,  X_test.txt and  subject_test.txt,  and also  y_train.txt,  X_train.txt and  subject_train.txt

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
	Regular expressions are used to extract only mean and standard deviation from the merged dataset.

#3.Uses descriptive activity names to name the activities in the data set
	The activity label description is contained in activity_labels.txt. The description is read and labels replaced with description.
 
#4.Appropriately labels the data set with descriptive variable names. 
	The labels are already applied in the Step 1 while binding the dataframes.

#5.From the data set in step 4 an independent tidy data set is created with the average of each variable for each activity and each subject.
	Mean of each activity of each subject is calculated.
	
