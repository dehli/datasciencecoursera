library(xlsx)
library(XML)
library(data.table)

questionOne <- function(){
  #Codebook - https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(url, destfile="./data.csv", method="curl")
  unzip("./data.zip")
    
  file <- read.csv("./data.csv")
  subset(file, VAL == 24)
}

questionTwoPart <- function(){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
  download.file(url, destfile="./gov.xlsx", method="curl")
    
  file <- read.xlsx("./gov.xlsx", sheetIndex=1, header=FALSE)
  sub <- data.frame(file[19:23, 7:15])
  colnames(sub) <- c("Zip", "C", "P", "P2", "C2", "Ext", "1", "2", "3")
  sub
}

questionTwo <- function(){
  dat <- questionTwoPart()
  sum(dat$Zip*dat$Ext,na.rm=TRUE)
}

readXML <- function(){
  fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
  doc <- xmlTreeParse(fileURL, useInternal=TRUE)
  rootNode <- xmlRoot(doc)
  zips <- table(xpathSApply(rootNode, "//zipcode", xmlValue))
  zips[names(zips) == 21231]
}

questionFive <- function(){
  if(!file.exists("data")){
    dir.create("data")
  }
  if(!file.exists("./data/communities.csv")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(fileURL, destfile="./data/communities.csv", method="curl")
  }
  DT <- fread("./data/communities.csv")

  before <- Sys.time()
  sapply(split(DT$pwgtp15,DT$SEX),mean)
  after <- Sys.time()
  print(after-before)
  
  before <- Sys.time()
  tapply(DT$pwgtp15,DT$SEX,mean)
  after <- Sys.time()
  print(after-before)
  
  #before <- Sys.time()
  #rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
  #after <- Sys.time()
  #print(after-before)
  
  before <- Sys.time()
  mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
  after <- Sys.time()
  print(after-before)
  
  before <- Sys.time()
  DT[,mean(pwgtp15),by=SEX]
  after <- Sys.time()
  print(after-before)
  
  before <- Sys.time()
  mean(DT$pwgtp15,by=DT$SEX)
  after <- Sys.time()
  print(after-before)
}