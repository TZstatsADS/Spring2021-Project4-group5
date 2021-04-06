# Applied Data Science Spring 2021
# Project 4 Group 5
# Created by Amir Idris

# S will be a list of lists corresponding to the matching assignment
# Y will be the outcome vector

estimate_ATE <- function(S, Y){
  S.size <- length(S)
  n <- length(Y) # number of data points we have
  n_i <- c() # vector of number of examples in each group
  subclass_ATEs <- c() # average treatment effects from each subclass
  
  for(i in 1:S.size){
    subclass <- S[[i]]
    subclass_ATE <- 0
    subclass.size <- length(subclass)
    
    for(j in 1:subclass.size){
      for(k in j:subclass.size){
        if(subclass[[j]][3] != subclass[[k]][3]){
          idx1 <- subclass[[j]][1]
          idx2 <- subclass[[k]][1]
          treatment_effect <- Y[idx1] - Y[idx2]
          
          # Ensure the difference is treatment - control
          if(subclass[[j]][3] == FALSE){
            treatment_effect <- -treatment_effect
          }
          subclass_ATE <- subclass_ATE + treatment_effect
        }
        
      }
    }
    subclass_ATE <- subclass_ATE/subclass.size
    subclass_ATEs <- c(subclass_ATEs, subclass_ATE)
    n_i <- c(n_i, subclass.size)
    
  }
  
  # Compute overall estimate of ATE
  weights <- n_i/n
  ate <- weights %*% subclass_ATEs
  
  return(ate)
  
}






