#Loading required library
library(dplyr)

#Getting file and loading into project directory
file <- "GCD_project_dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, file, method = "curl")
unzip(file)

#Data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

#Merging train and test data sets
X_Merg <- rbind(x_train, x_test)
Y_Merg <- rbind(y_train, y_test)
Subject_Merg <- rbind(subject_train, subject_test)

Data_Merg <- cbind(Subject_Merg, Y_Merg, X_Merg)

#Extracting mean and STD for each measurement
Tidy_data <- Data_Merg %>% select(subject, code, contains("mean"), contains("std"))

#Rename lables with descriptive names
names(Tidy_data)[2] = "activity"
names(Tidy_data)<-gsub("BodyBody", "Body", names(Tidy_data))
names(Tidy_data)<-gsub("Mag", "Magnitude", names(Tidy_data))
names(Tidy_data)<-gsub("Acc", "Accelerometer", names(Tidy_data))
names(Tidy_data)<-gsub("Gyro", "Gyroscope", names(Tidy_data))
names(Tidy_data)<-gsub("^t", "Time", names(Tidy_data))
names(Tidy_data)<-gsub("^f", "Frequency", names(Tidy_data))
names(Tidy_data)<-gsub("tBody", "TimeBody", names(Tidy_data))
names(Tidy_data)<-gsub("-mean()", "Mean", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("-std()", "STD", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("-freq()", "Frequency", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("angle", "Angle", names(Tidy_data))
names(Tidy_data)<-gsub("gravity", "Gravity", names(Tidy_data))

#Data set creation, averaging each measurement
Second_data_set <- Tidy_data %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(Second_data_set, "Final_Set.txt", row.name=FALSE)





