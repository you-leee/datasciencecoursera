makeCacheMatrix <- function(x = matrix()) {
    ## Creates a list of functions for caching an invertible matrix and its inverse
    
    ## Args:
    ##  'x' is an invertible matrix
    
    ## Returns:
    ##  A list of functions:
    ##      *'get': get the value of the matrix
    ##      *'setinverse': set the value of the inverse matrix
    ##      *'getinverse': get the value of the inverse matrix
    
    invX <- NULL
    get <- function() {
        x
    }
    setinverse <- function(inverse) {
        invX <<- inverse
    }
    getinverse <- function() {
        invX
    }
    list(get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}