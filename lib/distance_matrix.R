# Applied Data Science Spring 2021
# Project 4 Group 5
# Created by Amir Idris

# Each e is a tuple s.t. e = (idx, prop_score, treatment_group_indicator)
# e.g. e_1 = (5, 0.4, False)

# U will be a matrix where each row corresponds to an e_i

# Import linear propensity distance function
source("linear_prop_distance.R")

get_distance_matrix<- function(U){
  n <- dim(U)[1]
  
  # Intialize D
  D <- matrix(, nrow = n, ncol = n)
  
  # Fill D with all pairwise distances
  for(i in 1:n){
    curr_e <- U[i,2]
    for(j in 1:n){
      other_e <- U[j,2]
      D[i,j] <- linear_prop_distance(curr_e, other_e)
    }
  }
  
  return(D)
}