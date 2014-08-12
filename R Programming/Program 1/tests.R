fileURL <- "http://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
download.file(fileURL, "./specdata.zip")
unzip("./specdata.zip")

pollutantmean("specdata", "sulfate", 1:10)

complete("specdata", c(2, 4, 8, 10, 12))

complete("specdata", 150)

cr <- corr("specdata", 150)
head(cr)
summary(cr)