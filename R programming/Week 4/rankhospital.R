rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    mortalityRates <- read.csv("outcome-of-care-measures.csv")
    ## Check that state and outcome are valid
    if(!is.element(state, mortalityRates$State)) {
        stop("invalid state")
    }
    if(!is.element(outcome, c("heart attack", "heart failure", "pneumonia"))) {
        stop("invalid outcome")
    }
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    outcomeColumn <- switch(outcome, 
                            "heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                            "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                            "pneumonia" = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    outcomePerState <- subset(mortalityRates, (mortalityRates$State == state & mortalityRates[, outcomeColumn] != "Not Available"), c( "Hospital.Name", outcomeColumn))
    if(num == "best") {
        num <- 1
    }
    else if(num == "worst") {
        num <- length(outcomePerState[, 2])
    }
    else if(nlevels(outcomePerState[, 2]) < num) {
        return(NA)
    }
    outcomePerState[, 2] <- as.numeric(as.character(outcomePerState[,2 ]))
    outcomePerStateOrdered <- outcomePerState[order(outcomePerState[outcomeColumn], outcomePerState["Hospital.Name"]), ]
    as.character(outcomePerStateOrdered[, "Hospital.Name"])[num]
}