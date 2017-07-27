# Getting And Cleaning Data Course Project

### Purpose:
This project uses the Human Activity Recognition Using Smartphones Data Set from UIC to demonstrate our ability to collect, work with, and clean a data set.

### Goal:
Run the run_analysis.R script creates a tidy data set with the average on the mean and standard deviation for the 33 features for each of the 6 activities and each of the 30 subjects.

### Steps:
Here are the steps for the procoess:

  -a. read measured data, activity lables, subjects and features(variable names) for both the test and train sets into R
  
  -b. combine measured data, activity lables & subjects into one dataset using the column combine function for both the test and train sets
  
  -c. combine test and train sets into one dataset using the row combine function
  
  -d. extract only the measurements on the mean and standard deviation for each measurement using the features.txt file to index and select columns in the data
  
  -e. rename data variables using the features.txt file so that variable names are descriptive
  
  -f. recode the activity column using values from the Activity labels text file so that activities are descriptive
  
  -g. create an independent tidy data set with the average of each variable for each activity and each subject, and writes the data into a txt file
