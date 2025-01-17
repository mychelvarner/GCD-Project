#requires dplyr "install.packages("dplyr")
#library(dplyr)

#group data by subject and activity
clumpeddata <- group_by(selecteddata, Subject, Activity)

#get averages for time-domain variables and frequency-domain variables
timetable <- summarise(clumpeddata, across(starts_with("time"), mean))
freqtable <- summarise(clumpeddata, across(starts_with("freq"), mean))

#combine
secondtable <- merge(timetable,freqtable)
