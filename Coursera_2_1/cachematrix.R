## Caching in R

## Creates the matrix which is really a list to :

## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse
## 4. get the value of the inverseset and get the value of the matrix and its inverse

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) m <<- inverse
  getinverse <- function() m
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
  
}

## Calculates inverse of matrix created above
#iI first checks to see if the inverse
## has already been caclulated. If so, it 'get's the inverse from the cache
## and skips the computation. Otherwise, it calculates the matrix inverse
## and sets the value of the inverse in the cache via the 'setinverse' function.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
m<-x$getinverse()
if(!is.null(m)) {
  message("getting cached data")
  return(m)
}
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}

  

