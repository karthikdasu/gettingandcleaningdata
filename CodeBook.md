Code Book
=========
  
This code book describes the variables, data and transformations performed in run_analysis.R script.

Data Collection
---------------
Raw data was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Data set information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

See README.txt file in raw data set for more information.

Data Transformation
-------------------
The raw data sets were processed with run_analysis.R file to create a tidy data set.

The raw data was read into variables "x_test", "y_test", "subject_test", "x_train", "y_train" and "subject_train".
All test data was merged into variable "test", and all train data was merged into variable "train".

Then, the test and train data was merged into a single variable called "completeData".

Next, to get descriptive names for the columns of "completeData", names for features were loaded into the variable "features" from features.txt for the raw data set.
This was converted into a vector "columnNames", with new column names added for subject and activity.
The "columnNames" variable was transposed and used to set column names for "completeData"

Next, only measurements on mean and standard deviation for each measurement were extracted from "completeData" into the variable "extractedData".

Then, descriptive names were added to the values of column "activity" by reading the descriptive names from activity_labels.txt.
After this step, the previous values in the column "activity" of "extractedData" were replaced by new values which has lables for the activities.

Next, the names of columns were changed to remove "-", "()" and change to captials when appropriate.
The result of this step is in the same variable "extractedData"

After this, dplyr package is used to create a second independent tidy data set with the average of each variable for each activity and each subject.
The result is stored in a variable "tidy".

This is then written into a file "tidy_data.txt".

Tidy Data Set
-------------
The first column of the tidy data set "subject"  is the subject number.

The second column "activity" gives a description of the activity (using activity labels from raw data set).

The subsequent columns give the mean and standard deviations of the different measurements for each "subject" and "activity" combination.
