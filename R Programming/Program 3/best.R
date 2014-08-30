best <- function(state, outcome) {
    ## Read outcome data
    out <- read.csv("./outcome-of-care-measures.csv", colClasses="character")
    out[,11] <- suppressWarnings(as.numeric(out[,11]))
    out[,17] <- suppressWarnings(as.numeric(out[,17]))
    out[,23] <- suppressWarnings(as.numeric(out[,23]))
    
    ## Check that state and outcome are valid
    states <- unique(out$State)
    if(!state %in% states){
        stop('invalid state')
    }
    outcomes <- c('heart attack', 'heart failure', 'pneumonia')
    if(!outcome %in% outcomes){
        stop('invalid outcome')
    }
    
    #subset for selected state
    subset <- out[grep(state, out$State),]
    
    #selects based on outcome
    if(outcome == 'heart attack'){ 
        selector <- 11
    }
    else if(outcome == 'heart failure'){
        selector <- 17
    }
    else if(outcome == 'pneumonia'){
        selector <- 23
    }
    
    ## Return hospital name in that state with lowest 30-day death rate
    sorted <- subset[order(subset[,selector],subset[,2]),]
    sorted[1,2]
}