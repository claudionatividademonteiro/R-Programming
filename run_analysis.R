#loading required library
library(dplyr)

#getting file and loading into project directory
file <- "GCD_project_dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, file, method = "curl")
unzip(file)

#Data frames