# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
#     
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
# Good luck!
###################################################################################
# I assume here that the required files have already been copied in the working directory before this code is executed.

# 1. Merges the training and the test sets to create one data set.

# read the x training and test data sets
x_train <- read.table("x_train.txt", header = FALSE)
x_test <- read.table("x_test.txt", header = FALSE)
ncol(x_train)
nrow(x_train)

# merge the x training and test data sets into a single data set.
x_all <- rbind(x_train, x_test)

# read the y training and test data sets
y_train <- read.table("y_train.txt", header = FALSE)
y_test <- read.table("y_test.txt", header = FALSE)

# merge the y training and test data sets into a single data set.
y_all <- rbind(y_train, y_test)

# read the s training and test data sets
s_train <- read.table("subject_train.txt", header = FALSE)
s_test <- read.table("subject_test.txt", header = FALSE)

# merge the s training and test data sets into a single data set.
s_all <- rbind(s_train,s_test)

head(s_all)

###################################################################################
# 4. Appropriately labels the data set with descriptive variable names. 
# use the names of the features as column names for the x_all data

# read the feature names into a data set
fnamesInRow <- read.table("features.txt", header = FALSE)
names(fnamesInRow)
head(fnamesInRow)

# use the feature names as column names for the data in x_all
names(x_all) <- fnamesInRow$V2

###################################################################################
# 3. Uses descriptive activity names to name the activities in the data set
# now we will add label ids and names to all the rows in the data set.

# read the activity labels and ids into labels data set
labels <- read.table("activity_labels.txt", header = FALSE)
head(labels)

names(labels) <- c("id", "name")
labels$name <- as.character(labels$name)

# assigne the activity label ids to the x_all data set from y_all data set
x_all$labelId <- y_all$V1
x_all$label <- y_all$V1

# now using the mapping in the labels data set, name the activities in x_all data set
x_all[x_all$labelId == 1, c("label")] <- labels[labels$id == 1, "name"]
x_all[x_all$labelId == 2, c("label")] <- labels[labels$id == 2, "name"]
x_all[x_all$labelId == 3, c("label")] <- labels[labels$id == 3, "name"]
x_all[x_all$labelId == 4, c("label")] <- labels[labels$id == 4, "name"]
x_all[x_all$labelId == 5, c("label")] <- labels[labels$id == 5, "name"]
x_all[x_all$labelId == 6, c("label")] <- labels[labels$id == 6, "name"]

# test if there are records for some labels in the data.frame
length(x_all[x_all$label == "STANDING", c("label")])
length(x_all[x_all$label == "WALKING", c("label")])

# now also add the subjects to the x_all data.frame
x_all$subject <- s_all$V1

###################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# only extract the column that have mean or std in their column names
meanCols <- names(x_all)[grep(pattern = "mean", names(x_all))]
stdCols <- names(x_all)[grep(pattern = "std", names(x_all))]

# combine the columns that we need to for the new data set from the x_all data set.
meanAndStdCols <- c(meanCols, stdCols, "labelId", "label", "subject")

length(meanAndStdCols)

# extact the data set for the smaller list of columns previouly selected into x_meanAndstd data set
x_meanAndstd <- x_all[,meanAndStdCols]

###################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy <- aggregate(x_meanAndstd[,c(meanCols,stdCols)], by=list(x_meanAndstd$label, x_meanAndstd$subject), mean)

# assign appropriate names to the new group by columns in the data set.
names(tidy)[1] <- "activityLabel"
names(tidy)[2] <- "subjectId"

# test code
# tidy[1:4,c(1,2, 5:8)]

write.table(tidy,"tidy_data.txt",row.name=FALSE)
