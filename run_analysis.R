## Getting and cleaning data project
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)
library(data.table)
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"
if (!file.exists("UCI HAR Dataset")) { 
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileURL, filename, method="curl")
unzip(filename) 
}

# Load: activity labels and columns
act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Extract only the measurements on the mean and standard deviation for each measurement.
extractfeatures <- grepl("mean|std", features)

# Load and process Xtest & ytest data.
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(Xtest) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
Xtest = Xtest[,extractfeatures]

# Load activity labels
ytest[,2] = activitylabels[ytest[,1]]
names(ytest) = c("Activity_ID", "Activity_Label")
names(subjecttest) = "subject"

# Bind data
testdata <- cbind(as.data.table(subjecttest), ytest, Xtest)

# Load and process Xtrain & ytrain data.
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(Xtrain) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
Xtrain = Xtrain[,extractfeatures]

# Name the activities in the data set
ytrain[,2] = activitylabels[ytrain[,1]]
names(ytrain) = c("Activity_ID", "Activity_Label")
names(subjecttrain) = "subject"

# Appropriately lable the data set with descriptive activity names
traindata <- cbind(as.data.table(subjecttrain), ytrain, Xtrain)

data = rbind(testdata, traindata)

idlabels   = c("subject", "Activity_ID", "Activity_Label")
datalabels = setdiff(colnames(data), idlabels)
meltdata      = melt(data, id = idlabels, measure.vars = datalabels)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata   = dcast(meltdata, subject + Activity_Label ~ variable, mean)

# Save as txt file
write.table(tidydata, file = "./tidydata.txt",row.names=FALSE)
