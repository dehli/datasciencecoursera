## File turned in for Getting and Cleaning Data - Course Project

#fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileURL, "./dataset.zip", method="curl")
#unzip("./dataset.zip")

##  Merges the training set with the test set
##  and returns the result
mergeData <- function(){
    folderLocation <- "./UCI HAR Dataset/"
    types <- c("test", "train")

    result <- NA
    for(i in 1:length(types)){
        file1 <- paste(folderLocation, types[i], "/subject_", types[i], ".txt", sep="")
        file2 <- paste(folderLocation, types[i], "/X_", types[i], ".txt", sep="")
        file3 <- paste(folderLocation, types[i], "/Y_", types[i], ".txt", sep="")
        
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
    result
}