# Applied Data Science Spring 2021
# Project 4 Group 5
# Created by Ruize Yu, Edited by Amir Idris
# Boosted Stamps training function



gbm_propensity_model <- function(data){
  if ("Y" %in% colnames(data)){
    data <- subset(data, select = -c(Y))
  }
  
  model <- gbm(A~., data = data, 
               distribution = "bernoulli",
               n.trees = 60,
               shrinkage = 0.1, 
               interaction.depth = 1,
               n.minobsinnode = 10,
               bag.fraction = 1)
  return(model)
}

gbm_propensity <- function(features, model){
  if("Y" %in% colnames(features)){
    features <- subset(features, select = -c(Y))
  }
  if("A" %in% colnames(features)){
    features <- subset(features, select = -c(A))
  }
  
  props <- predict(model, newx = data.matrix(features), n.trees = 60,type = "response")
  names(props) <- c(1:length(props))
  return(props)
}


