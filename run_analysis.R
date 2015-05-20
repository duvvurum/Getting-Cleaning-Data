#clear the environment
rm(list=ls())
#set working directory
setwd("~/Personal/CourseEra/Data_science/get-data-clean-data/UCI HAR Dataset")
library(data.table)

# Download data file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
local_copy <- "original_file.zip"
# This will actually dowenload the file. To save time i am commenting it out
#download.file(url, local_copy, mode="wb")

# Unzip the local copy of the file
#unzip(local_copy)


# Read the content X_test.txt and X_train.txt.  There are 561 variables in each set
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt") #7352 observations
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt") #2947 observations

#Read the content of "y_train.txt" and "y_test.txt". 
#They contain activity labels coded as in activity_labels.txt.Here after referred as Activity_ID

y_train <- read.table("./UCI HAR Dataset/train//y_train.txt")# 7352 rows
y_test <- read.table("./UCI HAR Dataset/test//y_test.txt")   # 2947 rows

# Read content of subject_train.txt and subject_test.txt.
train_subject <- read.table("./UCI HAR Dataset/train//subject_train.txt")  # 7352 rows
test_subject <- read.table("./UCI HAR Dataset/test//subject_test.txt")    # 2947 rows

training_set = cbind(train_subject, y_train, x_train)  # Assemble training set
testing_set = cbind(test_subject, y_test, x_test)      # Assemble testing set
mydf <- rbind(training_set, testing_set)                 # Merge train and test sets
# Give descriptive labels
col_names_for_x_readings <- read.table("./UCI HAR Dataset/features.txt")
col_names_for_mydf <- c("Subject", "Activity", as.character(col_names_for_x_readings[["V2"]]))
colnames(mydf) <- col_names_for_mydf
# now get all the variables with mean/std in their names (Hint: they are in column names)
mydf_mean_std<- mydf[c("Activity","Subject", colnames(mydf)[grepl("mean|std", colnames(mydf))])]
View(mydf_mean_std)

Activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(Activity) <- c("Activity", "ActivityName")
mydf_with_activity_label <- merge(Activity, mydf_mean_std)
#chage the column names to meaningful names.
colnames(mydf_with_activity_label)<- gsub("Acc", "Accelerometer", colnames(mydf_with_activity_label))
colnames(mydf_with_activity_label)<- gsub("Gyro", "Gyroscope", colnames(mydf_with_activity_label))
colnames(mydf_with_activity_label)<- gsub("BodyBody", "Body", colnames(mydf_with_activity_label))
colnames(mydf_with_activity_label)<- gsub("Mag", "Magnitude", colnames(mydf_with_activity_label))
colnames(mydf_with_activity_label)<- gsub("^t", "Time", colnames(mydf_with_activity_label))
colnames(mydf_with_activity_label)<- gsub("^f", "Frequency", colnames(mydf_with_activity_label))
colnames(mydf_with_activity_label)<- gsub("tBody", "TimeBody", colnames(mydf_with_activity_label))
colnames(mydf_with_activity_label)<- gsub("-mean", "Mean", colnames(mydf_with_activity_label), ignore.case = TRUE)
colnames(mydf_with_activity_label)<- gsub("-std", "STD", colnames(mydf_with_activity_label), ignore.case = TRUE)
colnames(mydf_with_activity_label)<- gsub("-freq()", "Frequency", colnames(mydf_with_activity_label), ignore.case = TRUE)
colnames(mydf_with_activity_label)<- gsub("angle", "Angle", colnames(mydf_with_activity_label))
colnames(mydf_with_activity_label)<- gsub("gravity", "Gravity", colnames(mydf_with_activity_label))
#Now prepare tidy data set with mean of each column grouped by Activity and Subject
aggdata <-aggregate(mydf_with_activity_label, by=list(Activity_Name=mydf_with_activity_label$ActivityName, Subject_code = mydf_with_activity_label$Subject),FUN=mean)
aggdata$Subject <- NULL
aggdata$ActivityName <- NULL
library(dplyr)
arrange(aggdata, Activity_Name, Subject_code)
# Write output table "tidy_output.csv"
write.table(aggdata, "tidy_output.txt", sep="\t", row.names=FALSE)
write.csv(aggdata, "tidy_output.csv", row.names=FALSE)

