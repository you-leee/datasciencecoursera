corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!
    
    files <- list.files(directory, full.names = TRUE)
    correlations <- numeric()
    for (file in files) {
        data <- read.csv(file)
        data.complete <- complete.cases(data)
        completeNo <- sum(data.complete)
        if(threshold < completeNo) {
            correlations <- c(correlations, cor(data$nitrate[data.complete], data$sulfate[data.complete]))
        }
    }
    correlations
}