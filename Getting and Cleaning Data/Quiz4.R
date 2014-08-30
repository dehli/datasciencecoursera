##Question 1
questionOne <- function(){
    ##Codebook: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    file <- download.file(url, destfile="q1.csv", method="curl")
    data <- data.table(read.csv("./q1.csv"))
    names <- names(data)
    split <- strsplit(names, "wgtp")
    split[[123]]
}

##Question 2
questionTwo <- function(){
    ##Codebook:
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    file <- download.file(url, destfile="q2.csv", method="curl")
    data <- data.table(read.csv("./q2.csv", skip=4, nrows=215, stringsAsFactors=FALSE))
    data <- data[X != ""]
    data <- data[, list(X, X.1, X.3, X.4)]
    setnames(data, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
    gdp <- as.numeric(gsub(",", "", data$gdp))
    mean(gdp, na.rm=TRUE)
}

##Question 3
united <- grepl("^United", data$Long.Name)
summary(united)

##Question 4
##data comes from question 2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
file <- download.file(url, destfile="q4.csv", method="curl")
dtEd <- data.table(read.csv("./q4.csv"))
dt <- merge(data, dtEd, all=TRUE, by=c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)
dt[isFiscalYearEnd & isJune, Special.Notes]

##Question 5
library(quantmod)
amzn <- getSymbols("AMZN", auto.assign=FALSE)
sampleTimes <- index(amzn) 
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))