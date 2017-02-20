---
title: "Getting and Cleaning Data Project 1 - CodeBook"
output: html_document
---

### Data Source <sup>1</sup>

The raw data for assignment was obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. This represents data that was gathered for human activities using the sensors available on modern smartphones, e.g. accelerometers, gyroscopes, etc...

### Raw Data Set Information <sup>1</sup>

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


### Feature Information

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated (and kept for this assignment) from these signals are:

* mean(): Mean value
* std(): Standard deviation

No unit of measures is reported, and all features were normalized and bounded within [-1,1].

### Processed Data Set Information

The processed data set contains only variables from the raw that represent a mean or standard deviation. The data was then aggregated by activity type and subject id and a mean was calculated for all the columns of the variables. These were then extracted to a new data which was given the name "Tidy Data.txt"

### Transformations made to the processed data set.
1. First the training and test data sets were merged into a single data set for X, Y, S data sets.
2. Then the names for all the features were read from the features.txt file and saved to a data set. Using this, the column names for the x_all data set were renamed to their appropriate feature names.
3. Data for the activity ids and their labels was read into a data set. Using this 2 new columns were created in the x_all data set which were named as labelId and label.
4. Using the data in s_all data set, a new column was created in x_all data set to include the subject ids
5. After that only variables that had value of "mean" or "std" in their column names were extracted from x_all to x_meanAndstd data set.
6. The data in x_meanAndstd data set was aggregated by activity label and subject id to give a new data set called as tidy. Rename the group by columns to appropriate names of activity and subject id
7. This data set was then written to the working directory in file "tidy_data.txt".


***
#### References
1. http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones