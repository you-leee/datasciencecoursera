best <- function(state, outcome) {
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
    outcomePerState[, 2] <- as.numeric(as.character(outcomePerState[,2 ]))
    minOutcomePerState <- subset(outcomePerState, outcomePerState[outcomeColumn] == min(as.numeric(outcomePerState[,outcomeColumn])))
    minOutcomePerStateOrdered <- minOutcomePerState[order(minOutcomePerState["Hospital.Name"]), ]
    as.character(minOutcomePerStateOrdered[, "Hospital.Name"])[1]
}