# Applied Data Science Spring 2021
# Project 4 Group 5
# Created by Amir Idris

net_discrepancy <- function(S, D){
  
  
}

find_closest_comparison <- function(e){
  
}


propensity_matching <- function(U, S){
  # Pop new example from U
  e <- tail(U,1)
  new_U <- U[1:length(U) - 1]
  min_discrepancy <- Inf
  best_S <- NULL
  
  for(i in length(S)){
    # Insert e into one of the groups
    new_s <- append(S[i], e)
    new_S <- S
    new_S[i] <- new_s
    
    # Recurse on this new matching assignment
    new_S <- propensity_matching(new_U, new_S)
    net_dis <- net_discrepancy(new_S)
    
    # Check if this is best so far
    if (net_dis < min_discrepancy) {
      min_discrepancy <- net_dis
      best_S <- new_S
    }
    
  }
  
  # Test if putting e in new group will work best
  e_prime <- find_closest_comparison(e)
  new_group <- c(e,e_prime)
  new_S <- S
  new_S <- append(new_S, new_group)
  
  new_S <- propensity_matching(U, new_S)
  net_dis <- net_discrepancy(new_S)
  
  # Check if this is better
  if (net_dis < min_discrepancy) {
    min_discrepancy <- net_dis
    best_S <- new_S
  }
  
  return(best_S)
  
}




