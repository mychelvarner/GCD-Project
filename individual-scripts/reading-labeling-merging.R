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
