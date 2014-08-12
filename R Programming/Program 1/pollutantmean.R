pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating the location of the CSV files
  files <- list.files(directory, full.names=TRUE)
  
  ## This creates an empty data frame
  dat <- data.frame()
  
  ## This binds the data that should be included
  ## 'id' is an integer vector indicating the monitor ID numbers to be used
  for(i in id) {
    dat <- rbind(dat, read.csv(files[i]))
  }
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  dat <- subset(dat, select=pollutant)
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  colMeans(dat, na.rm=TRUE)
}