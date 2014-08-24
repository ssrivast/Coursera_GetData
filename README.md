Coursera_GetData
================
This repo is for Coursera course Getting and Cleaning Data. Following are the objects in this repository: 

run_analysis.R
==============

This has the R script does following: 

  * Merges the training and the test sets to create one data set.
  * Extracts only the measurements on the mean and standard deviation for each measurement. 
  * Uses descriptive activity names to name the activities in the data set
  * Appropriately labels the data set with descriptive variable names. 
  * Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Structure of the R script:

  * Load following files into DF
    ** x_test 
    ** y_test
    ** subject_test
    ** x_train
    ** y_train
    ** subject_train
    ** features
  * Combine x, y and subject DF from test and train
  * Update the columns to be meaningful column names
  * Pick only the columns with mean and std in the column name
  * Add verbose activity description in y DF
  * Combine subject, activity and x 
  * Melt and cast dataset to get the mean for all columns by subject and activity
  * Write the tidy dataset 'UCI HAR Tidy DataSet.txt'
  
How to run this script: 

source('./run_analysis.R')

Code Book
=========

Describes the variable of the tidy dataset






