rankhospital <- function(state, outcome, num="best"){
    ## Read outcome data
    out <- read.csv("./outcome-of-care-measures.csv", colClasses="character") 
    out[,11] <- suppressWarnings(as.numeric(out[,11]))
    out[,17] <- suppressWarnings(as.numeric(out[,17]))
    out[,23] <- suppressWarnings(as.numeric(out[,23]))
    
    ## Check that state and outcome are valid
    states <- unique(out$State)
    if(!state %in% states) stop('invalid state')
    out <- out[out$State==state,]
    
    #Selects based on outcome
    outcomes <- c('heart attack', 'heart failure', 'pneumonia')
    if(!outcome %in% outcomes) stop('invalid outcome')  
    if(outcome == 'heart attack') selector <- 11
    else if(outcome == 'heart failure') selector <- 17
    else if(outcome == 'pneumonia') selector <- 23
    
    ranked <- rank(out[,selector])
    
    index <- num
    if (num == "best"){
        index <- 1
    } else if(num == "worst"){
        index <- length(ranked)
    }
    
    ## Return hospital name in that state with the given rank 30-day death rate
    out$Hospital.Name[order(out[,selector], out$Hospital.Name)[index]]
}