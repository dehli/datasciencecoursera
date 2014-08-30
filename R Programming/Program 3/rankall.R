rankall <- function(outcome, num="best") {
    ## Read outcome data
    out <- read.csv("./outcome-of-care-measures.csv", colClasses="character")
    out[,11] <- suppressWarnings(as.numeric(out[,11]))
    out[,17] <- suppressWarnings(as.numeric(out[,17]))
    out[,23] <- suppressWarnings(as.numeric(out[,23]))
    
    ## Check that state and outcome are valid
    states <- unique(out$State)
    outcomes <- c('heart attack', 'heart failure', 'pneumonia')
    if(!outcome %in% outcomes) stop('invalid outcome')
    if(outcome == 'heart attack') col <- 11
    else if(outcome == 'heart failure') col <- 17
    else if(outcome == 'pneumonia') col <- 23
    
    hospitals <- rep("", length(states))
    
    ## For each state, find the hospital of the given rank
    for(i in 1:length(states)){
        data <- out[out$State==states[i],]
        ranked <- rank(data[,col])
        
        index <- num
        if (num == "best"){
            index <- 1
        } else if(num == "worst"){
            index <- length(ranked)
        }
        hospitals[i] <- data$Hospital.Name[order(data[,col], data$Hospital.Name)[index]]
    }
    
    ## Return a data frame with the hospital names and the (abbreviated) state name
    data.frame(hospital=hospitals, state=states)
}