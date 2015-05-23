## inv is cached inverse
makeCacheMatrix <- function(x = matrix()) {
  inv<-NULL
  set<- function(y) {
    x<<-y
    inv<<-NULL
  }

  get<-function() x

  setinv <- function(i) inv<<- i

  getinv <- function() inv

  list(get=get,set=set, getinv=getinv, setinv=setinv)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinv()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }

  data <- x$get()
  m <- solve(data)
  x$setinv(m)
  m
}