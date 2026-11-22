geometric_adstock <- function(x, theta) {
  
  result <- numeric(length(x))
  
  result[1] <- x[1]
  
  for (i in 2:length(x)) {
    
    result[i] <-
      x[i] +
      theta * result[i - 1]
    
  }
  
  result
}

hill_saturation <- function(x, k, s) {
  
  x^s / (x^s + k^s)
  
}
