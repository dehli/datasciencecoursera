source("complete.R")

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating the location of the CSV files
  files <- list.files(directory, full.names=TRUE)
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  observations <- complete(directory)
  observations <- subset(observations, nobs > threshold)
  observations <- observations[,1]
  
  ## Creates empty numeric to return
  correlations <- numeric()
  
  ## If there are no observations that meet the threshold then
  ## don't calculate any correlations
  if(length(observations) > 0){
    for(i in 1:length(observations)){
      temp <- read.csv(files[observations[i]])
      temp <- na.omit(temp)
      corr <- cor(temp[,2], temp[,3])
      correlations <- c(correlations, corr)
    }
  }
  
  ## Return a numeric vector of correlations
  correlations
}