#Getting and Cleaning Data Course Project
#This script:
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation 
#     for each measurement. 
#  3. Uses descriptive activity names to name the activities in the data set.
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.

#reading activity and feature labels
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

#clarifying feature labels
clearfeatures <- features
clearfeatures[,2] <- sub("tB","time-domain-B",features[,2])
clearfeatures[,2] <- sub("tG","time-domain-G",clearfeatures[,2])
clearfeatures[,2] <- sub("fB","frequency-domain-B",clearfeatures[,2])
clearfeatures[,2] <- sub("fG","frequency-domain-G",clearfeatures[,2])

#reading, labeling, relabeling, and combining train set
trainset <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(trainset) <- clearfeatures[,2]
trainlabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
colnames(trainlabel) <- "Activity"
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(trainsubject) <- "Subject"
train <- cbind(trainsubject, trainlabel, trainset)

#reading, labeling, and combining test set
testset <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(testset) <- clearfeatures[,2]
testlabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
colnames(testlabel) <- "Activity"
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(testsubject) <- "Subject"
test <- cbind(testsubject, testlabel, testset)

#merge training set and test set
data <- rbind(train, test)

#identify columns with averages and standard deviations
meannames <- grepl("mean()",names(data))
stdnames <- grepl("std()",names(data))

#select columns with subject and activity labels, 
#means, and standard deviations
subjectactivitydata <- data[,1:2]
meandata <- data[,meannames]
stddata <- data[,stdnames]

#clarify activity
clearsubjectactivity <- subjectactivitydata
clearsubjectactivity[,2] <- sub("1", "Walking", subjectactivitydata[,2])
clearsubjectactivity[,2] <- sub("2", "Walking Upstairs", clearsubjectactivity[,2])
clearsubjectactivity[,2] <- sub("3", "Walking Downstairs", clearsubjectactivity[,2])
clearsubjectactivity[,2] <- sub("4", "Sitting", clearsubjectactivity[,2])
clearsubjectactivity[,2] <- sub("5", "Standing", clearsubjectactivity[,2])
clearsubjectactivity[,2] <- sub("6", "Laying", clearsubjectactivity[,2])

#combine selected data
selecteddata <- cbind(clearsubjectactivity,meandata,stddata)

#requires dplyr "install.packages("dplyr")
#library(dplyr)

#group data by subject and activity
clumpeddata <- group_by(selecteddata, Subject, Activity)

#get averages for time-domain variables and frequency-domain variables
timetable <- summarise(clumpeddata, across(starts_with("time"), mean))
freqtable <- summarise(clumpeddata, across(starts_with("freq"), mean))

#combine
secondtable <- merge(timetable,freqtable)

