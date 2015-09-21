cacheSolve <- function(funcs, ...) {
    ## Computes the inverse of the martix, if it hasn't been calculated. 
    ##  If it has been calculated already, it returns the cached value of the inverse.
    
    ## Args:
    ##  'funcs' a list of functions:
    ##      *'get': get the value of the matrix
    ##      *'setinverse': set the value of the inverse matrix
    ##      *'getinverse': get the value of the inverse matrix
    
    ## Returns:
    ##  The inverse of the martix
    
    invX <- funcs$getinverse()
    if(!is.null(invX)) {
        message("getting cached inverse matrix")
        return(invX)
    }
    x <- funcs$get()
    invX <- solve(x, ...)
    funcs$setinverse(invX)
    invX
}