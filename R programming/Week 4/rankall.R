rankall <- function(outcome, num = "best") {
    ## Read outcome data
    mortalityRates <- read.csv("outcome-of-care-measures.csv")
    ## Check that outcome is valid
    if(!is.element(outcome, c("heart attack", "heart failure", "pneumonia"))) {
        stop("invalid outcome")
    }
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    outcomeColumn <- switch(outcome, 
                            "heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                            "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                            "pneumonia" = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    outcomeFiltered <- subset(mortalityRates, (mortalityRates[, outcomeColumn] != "Not Available"), c( "Hospital.Name", outcomeColumn, "State"))
    if(num == "best") {
        numNumber <- 1
    }
    outcomeFiltered[, 2] <- as.numeric(as.character(outcomeFiltered[,2 ]))
    outcomeSplitted <- split(outcomeFiltered, outcomeFiltered$State)
    states <- character()
    hospitals <- character()
    for(i in 1:length(outcomeSplitted)) {
        outcomePerState <- outcomeSplitted[[i]]
        states[i] <- as.character(outcomePerState[, 3][1])
        if(num == "worst") {
            numNumber <- length(outcomePerState[,2])
            outcomePerStateOrdered <- outcomePerState[order(outcomePerState[outcomeColumn], rev(outcomePerState["Hospital.Name"])), ]
        } else {
            outcomePerStateOrdered <- outcomePerState[order(outcomePerState[outcomeColumn], outcomePerState["Hospital.Name"]), ]
        }
        hospitals[i] <- as.character(outcomePerStateOrdered[, "Hospital.Name"])[numNumber]
    }
    data.frame(hospital = hospitals, state=states)
}