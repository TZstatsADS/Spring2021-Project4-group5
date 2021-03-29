# Applied Data Science Spring 2021
# Project 4 Group 5
# Edited by Sean Harris, sourced from Amir Idris

# Takes in a dataset and returns a model that predicts propensity
lr_propensity_model <- function(data, mode="logit"){
  if("Y" %in% colnames(data)){
    data <- subset(data, select = -c(Y))
  }
  data$A <- as.factor(data$A)
  
  if(mode == "logit"){
    model <- glm(A ~ ., data=data, family = "binomial")
  }
  if(mode == "lasso"){
    model <- glmnet(y = A, x = data[[ , names(dd) != "A"]], family = "binomial", alpha = 1)
  }
  if(mode == "ridge"){
    model <- glmnet(y = A, x = data[[ , names(dd) != "A"]], family = "binomial", alpha = 0)
  }
  
  return(model)
}

# Takes in dataset features and model and returns propensity scores
lr_propensity <- function(features, model){
  if("Y" %in% colnames(features)){
    features <- subset(features, select = -c(Y))
  }
  if("A" %in% colnames(features)){
    features <- subset(features, select = -c(Y))
  }
  
  props <- predict(model, newx = features, type = "response")
  return(props)
  
}