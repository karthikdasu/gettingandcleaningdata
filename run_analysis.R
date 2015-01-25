
#Merges the training and the test sets to create one data set.
library(data.table)

# Read test
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")  # dim: 2947*561
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")  # dim: 2947*1
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") # dim: 2947*1

# Read train
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt") # dim: 7352*561
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt") # dim: 7352*1
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") # dim: 7352*1

# Merge
# merge test
test <- cbind(subject_test, y_test, x_test) # dim: 2947*563
# merge test
train <- cbind(subject_train, y_train, x_train) # dim: 7352*563

# Merge test & train
completeData <- rbind(test, train) # dim: 10299 * 563

# Uses descriptive activity names to name the activities in the data set
features <- read.table("./UCI HAR Dataset/features.txt") # dim: 561*2
# Convert to data frame
features <- data.frame(features)
# Create a data frame of column names
columnNames <- c("subject", "activity")
columnNames <- data.frame(columnNames)
# Extract column names from features
onlyNames <- data.frame(features[,2])
colnames(onlyNames) <- c("columnNames")
columnNames <- rbind(columnNames, onlyNames)
tfeatures <- t(columnNames)

# set column names in completeData
colnames(completeData) <- tfeatures

# Extracts only the measurements on the mean and standard deviation for each measurement. 
extractedData <- completeData[,grep("mean\\()|std\\()|subject|activity", colnames(completeData), ignore.case=TRUE), ]

# Uses descriptive activity names to name the activities in the data set
al <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Create factor using activity column of extractedData
extracted_factor <- factor(extractedData[,2], labels = al[,2])
# Replace activity column with factor
extractedData$activity <- extracted_factor

# Appropriately labels the data set with descriptive variable names. 
# Remove -, () and convert mean/std to Mean/Std
cnames <- gsub("-", "", colnames(extractedData))
cnames <- gsub("\\()", "", cnames)
cnames <- gsub("mean", "Mean", cnames)
cnames <- gsub("std", "Std", cnames)
colnames(extractedData) <- cnames

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
tidy <-
  extractedData %>%
  group_by(subject,activity) %>%
  summarise_each(funs(mean)) %>%
  print(tidy)

# Write to tidy_data.txt
write.table(tidy, "tidy_data.txt", row.name = FALSE)
