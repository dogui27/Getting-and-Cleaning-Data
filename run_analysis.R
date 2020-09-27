
# ******************************************
# Getting and Cleaning Data - Course Project
# ******************************************

library("dplyr")

### ***************************
### SETTING Work Directory ####
### ***************************

# Clean up the environment
rm(list = ls()); gc()

path <- file.path("C:", "mio", "R", "Coursera",
                  "3-Getting and Cleaning Data",
                  "Week 4",
                  "Assignment",
                  "Getting-and-Cleaning-Data")

setwd(path)
getwd()

### ********************************
### DOWNLOAD all files from Web ####
### ********************************

if (!file.exists("0_InputFiles/UCI HAR Dataset")) {
    if (!file.exists("0_InputFiles")) {
        dir.create("0_InputFiles")
    }
    
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url = fileURL, destfile = "0_InputFiles/Dataset.zip", method = "curl")
    
    unzip(zipfile = "./0_InputFiles/Dataset.zip",
          exdir = "./0_InputFiles")
}

### **************************
### READING IN data files ####
### **************************

# Feature Labels
featureLabels <- read.table(file = "./0_InputFiles/UCI HAR Dataset/features.txt",
                            col.names = c("id_feature", "feature"))

# Activity Labels
activityLabels <- read.table(file = "./0_InputFiles/UCI HAR Dataset/activity_labels.txt",
                            col.names = c("id_activity", "activity"))

# Function to read Data and add Labels (to accomplish tasks 3 and 4 as required in Instructions)
readIN <- function(dataType) {
    # Data
    dataIN <- read.table(file = paste0("./0_InputFiles/UCI HAR Dataset/", dataType, "/X_", dataType, ".txt"))

    # Activities
    activities<- read.table(file = paste0("./0_InputFiles/UCI HAR Dataset/", dataType, "/y_", dataType, ".txt"),
                            col.names = "id_activity")
    
    # ID Subjects
    subjects <- read.table(file = paste0("./0_InputFiles/UCI HAR Dataset/", dataType, "/subject_", dataType, ".txt"),
                           col.names = "id_subject")
    
    # Adding ID Subject
    dataIN$id_subject <- subjects$id_subject
    
    # Adding Activity Labels (as requested in STEP 3)
    activities <- dplyr::inner_join(activities, activityLabels, by = "id_activity")
    dataIN$activity <- activities$activity
    
    # just to view Subject and Activity as first variables
    dataIN <- dataIN %>%
        mutate(dataSource = dataType) %>%
        select(dataSource, id_subject, activity, V1:V561)

    # Adding appropriate labels to variable names  (as requested in STEP 4)
    colnames(dataIN)[4:564] <- featureLabels$feature
    
    return(dataIN)
}

train <- readIN(dataType = "train")
test <- readIN(dataType = "test")

# head(train[,1:6])
# tail(train[,1:6])
# head(test[,1:6])
# tail(test[,1:6])

### **************************************
### 1. MERGING TRAINING AND TEST SETS ####
### **************************************

dataTot <- rbind(train, test)

### **************************************
### 2. EXTRACT mean AND std deviation ####
### **************************************

varNames <- names(dataTot)

varExtracted <- grepl("dataSource|id_subject|activity|mean\\(\\)|std\\(\\)", varNames, ignore.case = TRUE)

dataExtracted <- dataTot[, varExtracted]

### *****************************************************************************
### 5. CALCULATE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT ####
### *****************************************************************************

avgData <- dataExtracted %>%
    select(-dataSource) %>%
    group_by(id_subject, activity) %>%
    summarise_all(.funs = mean, na.rm = TRUE)

# write a tidy dataset to upload in GitHub 
write.table(avgData, file = "./1_OutputFiles/avgData.txt", quote = FALSE, row.names = FALSE)

