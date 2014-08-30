##Downloads and unzips required data
url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
download.file(url, destfile="./data.zip", method="curl")
unzip("./data.zip")

histogram <- function(){
    outcome <- read.csv("./outcome-of-care-measures.csv", colClasses="character")
    head(outcome)
    outcome[, 11] <- as.numeric(outcome[, 11])
    ## You may get a warning about NAs being introduced; that is okay
    hist(outcome[, 11])
}