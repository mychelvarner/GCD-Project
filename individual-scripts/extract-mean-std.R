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