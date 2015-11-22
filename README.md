You should create one R script called run_analysis.R that does the following.

1.Merges the training and the test sets to create one data set.		
2.Extracts only the measurements on the mean and standard deviation for each measurement.	
3.Uses descriptive activity names to name the activities in the data set	
4.Appropriately labels the data set with descriptive activity names.	
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Run source("run_analysis.R")		
The run_analysis.R script downloads library reshape2 and data.table and the data set from 		
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 		
It also unzips the file in the same working directory as where you save the script.		
After the script is ran and completed, it will generate a tidydata.txt file in the same working directory which 
shows the cleaned data set 
