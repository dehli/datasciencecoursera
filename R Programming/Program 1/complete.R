complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating the location of the CSV files
  files <- list.files(directory, full.names=TRUE)
    
  ## This creates an empty data frame
  dat <- data.frame()
  
  ## 'id' is an integer vector indicating the monitor ID numbers to be used
  for(i in id) {
    temp <- read.csv(files[i])
    temp <- na.omit(temp)
    dat <- rbind(dat, data.frame(id=i, nobs=nrow(temp)))
  }
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  dat
}