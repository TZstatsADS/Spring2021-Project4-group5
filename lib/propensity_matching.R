# Applied Data Science Spring 2021
# Project 4 Group 5
# Created by Amir Idris

# EACH e is a tuple s.t. e = (idx, prop_score, treatment_group_indicator)
# e.g. e_1 = (5, 0.4, False)

# D is the matrix of pairwise distances between all prop scores in our data

net_discrepancy <- function(S, D){
  total_disc <- 0
  
  for(i in 1:length(S)){
    curr_group <- S[i]
    for(j in 1:length(curr_group)){
      for(k in 2:length(curr_group)){
        if(j != k){
          
          # Check that groups are opposite
          if(curr_group[j][3] != curr_group[k][3]){
            # Get discrepancy between points
            idx1 <- curr_group[j][1]
            idx2 <- curr_group[k][1]
            d <- D[idx1, idx2]
            total_dis <- total_dis + d
          }
          
        }
      }
    }
  }
  
}

find_closest_comparison <- function(e, U, D){
  min_disc <- Inf
  closest_comp <- NULL
  curr_idx <- e[1]
  for(i in 1:dim(D)[1]){
    if(i != curr_idx){
      curr_e <- U[i]
      curr_disc <- D[curr_idx, i]
      if((curr_e[3] != e[3]) & (curr_disc < min_disc)){
        min_disc <- curr_disc
        closest_comp <- curr_e
      }
    }
  }
  
  return(closest_comp)
  
}


propensity_matching <- function(U, S, D){
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
    net_dis <- net_discrepancy(new_S, D)
    
    # Check if this is best so far
    if (net_dis < min_discrepancy) {
      min_discrepancy <- net_dis
      best_S <- new_S
    }
    
  }
  
  # Test if putting e in new group will work best
  e_prime <- find_closest_comparison(e, U, D)
  new_group <- c(e,e_prime)
  new_S <- S
  new_S <- append(new_S, new_group)
  
  new_S <- propensity_matching(U, new_S)
  net_dis <- net_discrepancy(new_S, D)
  
  # Check if this is better
  if (net_dis < min_discrepancy) {
    min_discrepancy <- net_dis
    best_S <- new_S
  }
  
  return(best_S)
  
}




