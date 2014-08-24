questionOne <- function(){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    #https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
    download.file(fileURL, destfile="data.csv", method="curl")
    
    # identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products
    x <- read.csv("data.csv")
    agricultureLogical <- x$ACR == 3 & x$AGS == 6 & !is.na(x$ACR) & !is.na(x$AGS)
    
    which(agricultureLogical)
}

questionTwo <- function(){
    library(jpeg)
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
    download.file(fileURL, destfile="jeff.jpg", method="curl")
    jpeg <- readJPEG("jeff.jpg", native=TRUE)
    quantile(jpeg, probs=c(0.3, 0.8), native=TRUE)
}

questionThree <- function(){
    gdpURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(gdpURL, destfile="gdp.csv", method="curl")
    gdp <- read.csv("gdp.csv")
    gdp <- gdp[c(5:194),c(1,2,4,5)]
    colnames(gdp) <- c("ID", "Ranking", "Economy", "Millions in USD")
    
    eduURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    download.file(eduURL, destfile="edu.csv", method="curl")
    edu <- read.csv("edu.csv")
    
    library(doBy)
    merged <- merge(gdp, edu, by=1)
    merged$Ranking <- as.numeric(as.character(merged$Ranking))
    sorted <- orderBy(~-Ranking, data=merged)
    sorted
}

questionFour <- function(){
    data <- questionThree()
    tidy <- aggregate(data, by=list(data$Income.Group), FUN=mean, na.rm=TRUE)
}

questionFive <- function(){
    #Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?
    #Answer 5
}