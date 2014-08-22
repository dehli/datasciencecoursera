## File turned in for Getting and Cleaning Data - Course Project

##  Downloads and unzips the file for use
getFile <- function(){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, "./dataset.zip", method="curl")
    unzip("./dataset.zip")
}
    
##  Merges the training set with the test set and adds labels
mergeData <- function(){
    folderLocation <- "./UCI HAR Dataset/"
    types <- c("test", "train")

    result <- NA
    for(i in 1:length(types)){
        file1 <- paste(folderLocation, types[i], "/subject_", types[i], ".txt", sep="")
        file2 <- paste(folderLocation, types[i], "/Y_", types[i], ".txt", sep="")
        file3 <- paste(folderLocation, types[i], "/X_", types[i], ".txt", sep="")
        
        table1 <- read.table(file1)
        table2 <- read.table(file2)
        table3 <- read.table(file3)
        
        combined <- cbind(table1, table2, table3)
        if(length(result) == 1){
            result <- combined
        }
        else{
            result <- rbind(result, combined)
        }
    }
    
    ## Labels the columns appropriately
    featureLabelFile <- paste(folderLocation, "features.txt", sep="")
    featureLabels <- t(read.table(featureLabelFile, stringsAsFactors=FALSE)[2])
    featureLabels <- cbind("subject", "activity", featureLabels)
    colnames(result) <- featureLabels
    
    ## Labels the activities appropriately
    activityLabelFile <- paste(folderLocation, "activity_labels.txt", sep="")
    activityLabels <- t(read.table(activityLabelFile, stringsAsFactors=FALSE)[2])
    for(i in 1:length(activityLabels)){
        result$activity[result$activity == i] <- activityLabels[i]
    }
    
    result
}

##  Takes merged data and extracts the cols with mean or std
extractCols <- function(){
    data <- mergeData()
    
    # labels will contain the columns that should be extracted
    labels <- colnames(data)
    str1 <- "mean"
    str2 <- "std"
    for(i in 3:length(labels)){ #bypasses subject and activity
        if(!grepl(str1, labels[i]) & !grepl(str2, labels[i])){
            labels[i] <- NA
        }
    }
    labels <- labels[!is.na(labels)]
    
    data <- subset(data, select=labels)
    data
}

##  This function creates a second independent tidy data set
tidySet <- function(){
    data <- extractCols()
    tidy <- aggregate(data[,3:length(data)], by=list(data$subject,data$activity), FUN=mean, na.rm=TRUE)
    colnames(tidy)[1] <- "subject"
    colnames(tidy)[2] <- "activity"
    tidy
}

##  This function saves the tidy set
saveTidySet <- function(){
    tidy <- tidySet()
    write.table(tidy, row.name=FALSE, file="tidy.txt")
}