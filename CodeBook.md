Process based on code comments:

reading activity and feature labels from UCI HAR Dataset directory

clarifying feature labels using features.txt

reading, labeling, relabeling, and combining train set from 
UCI HAR Dataset/train

reading, labeling, and combining test set from UCI HAR Dataset/test

merge training set and test set

identify columns with averages and standard deviations

select columns with subject and activity labels, 
means, and standard deviations

clarify activity using activity_labels.txt

combine selected data

requires dplyr "install.packages("dplyr")
library(dplyr)

group data by subject and activity

get averages for time-domain variables and frequency-domain variables

combine results in secondtable
