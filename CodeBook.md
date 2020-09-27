# Getting and Cleaning Data Course Project

## Initial Raw Data
Raw data are obtained from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
In particular the *Human Activity Recognition Using Smartphone* datasets [[UCI HAR Dataset]](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) were used (refer to README for a brief overview).

This bunch of datasets provide the following variables:

 * subject - ID of participant [values 1-30]
 * features - 561 features measurements (see **Feature Selection**)
 * activity - ID of activity type [values 1-6]

| Code | Label |
| --- | --- |
| 1 | WALKING |
| 2 | WALKING_UPSTAIRS |
| 3 | WALKING_DOWNSTAIRS |
| 4 | SITTING |
| 5 | STANDING |
| 6 | LAYING |

### Feature Selection 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

 * tBodyAcc-XYZ
 * tGravityAcc-XYZ
 * tBodyAccJerk-XYZ
 * tBodyGyro-XYZ
 * tBodyGyroJerk-XYZ
 * tBodyAccMag
 * tGravityAccMag
 * tBodyAccJerkMag
 * tBodyGyroMag
 * tBodyGyroJerkMag
 * fBodyAcc-XYZ
 * fBodyAccJerk-XYZ
 * fBodyGyro-XYZ
 * fBodyAccMag
 * fBodyAccJerkMag
 * fBodyGyroMag
 * fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

 * mean(): Mean value
 * std(): Standard deviation
 * mad(): Median absolute deviation 
 * max(): Largest value in array
 * min(): Smallest value in array
 * sma(): Signal magnitude area
 * energy(): Energy measure. Sum of the squares divided by the number of values. 
 * iqr(): Interquartile range 
 * entropy(): Signal entropy
 * arCoeff(): Autorregresion coefficients with Burg order equal to 4
 * correlation(): correlation coefficient between two signals
 * maxInds(): index of the frequency component with largest magnitude
 * meanFreq(): Weighted average of the frequency components to obtain a mean frequency
 * skewness(): skewness of the frequency domain signal 
 * kurtosis(): kurtosis of the frequency domain signal 
 * bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
 * angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

 * gravityMean
 * tBodyAccMean
 * tBodyAccJerkMean
 * tBodyGyroMean
 * tBodyGyroJerkMean

**Note**: No unit of measures is reported as all features were normalized and bounded within [-1,1].

## Final Tidy Data
The purpose of the project is to obtain a summarized tidy dataset containing the average for only measurements related to Mean Value and Standard Deviation.
To accomplish this task `run_analysis.R` creates an intermediate dataset `dataExtracted` with:

 * 10299 obs. Train Set+Test Set
 * 69 variables
    * `dataSource`: record coming from Train or Test dataset
    * `id_subject`: ID of participant
    * `activity`: activity type
    * **66 features** related to mean() and std() measurement
      * tBodyAcc-XYZ
      * tGravityAcc-XYZ
      * tBodyAccJerk-XYZ
      * tBodyGyro-XYZ
      * tBodyGyroJerk-XYZ
      * tBodyAccMag
      * tGravityAccMag
      * tBodyAccJerkMag
      * tBodyGyroMag
      * tBodyGyroJerkMag
      * fBodyAcc-XYZ
      * fBodyAccJerk-XYZ
      * fBodyGyro-XYZ
      * fBodyAccMag
      * fBodyAccJerkMag
      * fBodyGyroMag
      * fBodyGyroJerkMag
 
In the end `run_analysis.R` creates a summary dataframe `avgData` (180 obs. of 68 vars) including **Average** of each measurement (the 66 features mentioned above) for each Subject and each Activity and the dataset is written to the file `avgData.txt`
