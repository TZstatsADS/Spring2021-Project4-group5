# Applied Data Science Spring 2021
# Project 4 Group 5
# Created by Amir Idris

logit <- function(p){
  output <- log(p/(1-p))
  return(output)
}

linear_prop_distance <- function(e1, e2){
  logit1 <- logit(e1)
  logit2 <- logit(e2)
  output <- abs(logit1 - logit2)
  return(output)
}
