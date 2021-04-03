# Applied Data Science Spring 2021
# Project 4 Group 5
# Created by Amir Idris

# Each e is a tuple s.t. e = (idx, prop_score, treatment_group_indicator)
# e.g. e_1 = (5, 0.4, False)

# U will be a matrix where each row corresponds to an e_i

# D is the matrix of pairwise distances between all prop scores in our data

# S will be a list of lists corresponding to the matching assignment

net_discrepancy <- function(S, D){
  total_disc <- 0
  
  for(i in 1:length(S)){
    curr_group <- S[[i]]
    for(j in 1:length(curr_group)){
      for(k in 2:length(curr_group)){
        if(j != k){
          
          # Check that groups are opposite
          if(curr_group[[j]][3] != curr_group[[k]][3]){
            # Get discrepancy between points
            idx1 <- curr_group[[j]][1]
            idx2 <- curr_group[[k]][1]
            d <- D[idx1, idx2]
            total_disc <- total_disc + d
          }
          
        }
      }
    }
  }
  
  return(total_disc)
  
}

find_closest_comparison <- function(e, U, D){
  min_disc <- Inf
  closest_comp <- NULL
  n <- dim(U)[1]
  e_idx <- e[1]
  
  for(i in 1:n){
    curr_e <- U[i,]
    curr_idx <- curr_e[1]
    curr_disc <- D[e_idx, curr_idx]
    if((curr_e[3] != e[3]) & (curr_disc < min_disc)){
      min_disc <- curr_disc
      closest_comp <- curr_e
    }
  }
  
  return(closest_comp)
  
}

# Root method for propensity matching
propensity_matching_root <- function(U, D){
  
  S <- list()
  ans <- propensity_matching( U, S, D)
  return(ans)
}


propensity_matching <- function(U, S, D){
  # Base Case
  if(is.null(U)){
    return(S)
  }
  
  # Pop new example from U
  n <- dim(U)[1]
  if(is.null(n)){
    e <- U
    new_U <- c()
  }
  else{
    e <- U[n,]
    new_U <- U[1:n-1,]
  }
  min_discrepancy <- Inf
  best_S <- NULL
  
  if(length(S) > 0){
    for(i in 1:length(S)){
      # Insert e into one of the groups
      new_s <- S[[i]]
      new_s.size <- length(new_s)
      new_s[[new_s.size + 1]] = e
      new_S <- S
      new_S[[i]] <- new_s
      
      # Recurse on this new matching assignment
      new_S <- propensity_matching(new_U, new_S, D)
      net_dis <- net_discrepancy(new_S, D)
      
      # Check if this is best so far
      if (net_dis < min_discrepancy) {
        min_discrepancy <- net_dis
        best_S <- new_S
      }
      
    }
  }
  
  # Only if current example is not last example to be placed
  if(!is.null(n)){
    # Test if putting e in new group will work best
    e_prime <- find_closest_comparison(e, U, D)
    if(!is.null(e_prime)){
      new_group <- list()
      new_group[[1]] <- e
      new_group[[2]] <- e_prime
      new_S <- S
      S.size <- length(new_S)
      new_S[[S.size + 1]] <- new_group
      
      new_S <- propensity_matching(new_U, new_S, D)
      net_dis <- net_discrepancy(new_S, D)
      
      # Check if this is better
      if (net_dis < min_discrepancy) {
        min_discrepancy <- net_dis
        best_S <- new_S
      }
    }
  }
  
  
  return(best_S)
  
}




