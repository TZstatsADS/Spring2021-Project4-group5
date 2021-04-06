# Applied Data Science Spring 2021
# Project 4 Group 5
# Edited by Sean Harris and Amir Idris, sourced from Amir Idris

# Takes in a dataset and returns a model that predicts propensity
lr_propensity_model <- function(data, mode="logit"){
  if("Y" %in% colnames(data)){
    data <- subset(data, select = -c(Y))
  }
  data$A <- as.factor(data$A)
  A <- data$A
  
  if(mode == "logit"){
    model <- glm(A ~ ., data=data, family = "binomial")
  }
  else if(mode == "lasso"){
    model <- glmnet(y = A, x = data[ , names(data) != "A"], family = "binomial", alpha = 1)
  }
  else if(mode == "ridge"){
    model <- glmnet(y = A, x = data[ , names(data) != "A"], family = "binomial", alpha = 0)
  }

  return(model)
}

# Takes in dataset features and model and returns propensity scores
lr_propensity <- function(features, model, mode=1){
  if("Y" %in% colnames(features)){
    features <- subset(features, select = -c(Y))
  }
  if("A" %in% colnames(features)){
    features <- subset(features, select = -c(A))
  }
  if (mode == 1){
    props <- predict(model, newx = data.matrix(features), type = "response")
  } else{
    props <- predict(model, newx = data.matrix(features), type = "response", s=0.01)
    props <- props[, 1]
  }
  return(props)
  
}