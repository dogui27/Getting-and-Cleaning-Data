# Getting and Cleaning Data Course Project

## Project Description
This project is the submission to Peer-graded Assignment for Coursera **"Getting and Cleaning Data"** Course Project.
The aim of this project is to:

 * download datasets from a research on *"Human Activity Recognition Using Smartphones"*
 * process and clean those data
 * finally generate a tidy dataset containing just a subset of original information to be used for later analysis

## Repository Structure
 * **CodeBook.md**: description of information stored in initial raw data and final tidy data `AvgData.txt`
 * **run_analysis.R**: R script to download raw data, process and transform them in a summarised tidy dataset
 * **AvgData.txt**: final dataset (created by `run_analysis.R`) to be used for further analysis

## Background Data
Raw Data were collected by conducting experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, reaserchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Deeper understanding of experiment and a full description of data can be found in [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data Transformation (how R script works)
The included R script `run_analysis.R` conducts the following main steps (refer to the Outline in R script for better clarification):

 1. Download datasets from web if they don't already exist in the working directory (raw data stored in [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip))
 2. Read **Feature** and **Activity** labels
    - `features.txt` includes 561 different features
    - `activity_labels.txt` includes 6 different activities
 3. Read **Measurements (X)**, **Activities (y)**, **ID Subjects** and merge them for both **Train** and **Test** datasets
    - `train/X_train.txt` includes the measurements of the features in Train set (7352 observations) 
    - `train/y_train.txt` includes the activities for each subject in Train set (7352 observations)
    - `train/subject_train.txt` includes the ID for each subject in Train set (7352 observations)
    - `test/y_test.txt` includes the activities for each subject in Test set (2947 observations)
    - `test/X_test.txt` includes the measurements of the features in Test set (2947 observations)
    - `test/subject_test.txt` includes the ID for each subject in Test set (2947 observations)
 4. Merge **Train** and **Test** datasets in a single dataframe `dataTot`
 5. Create a dataframe `dataExtracted` including only **Mean** and **Standard Deviation** for each measurement per Subject and Activity
 6. Create a summary dataframe `avgData` including **Average** of each measurement (selected in step 5.) for each Subject and each Activity (required R package: `dplyr`)
 7. Write the *Tidy Dataset* `avgData.txt` to be uploaded in GitHub repository
 
 
 
 
