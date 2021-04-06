# Applied Data Science Spring 2021
# Project 4 Group 5
# Edited by Sean Harris, sourced from Amir Idris

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
  if(mode == "lasso"){
    model <- glmnet(y = A, x = data[ , names(data) != "A"], family = "binomial", alpha = 1)
  }
  if(mode == "ridge"){
    model <- glmnet(y = A, x = data[ , names(data) != "A"], family = "binomial", alpha = 0)
  }
  if(mode == "tree"){
    model <- rpart(A~., data = data, method = "class")
    min_cp = model$cptable[which.min(model$cptable[,"xerror"]),"CP"]
    model = prune(model, cp=min_cp)
  }
  if(mode == "stump"){
    n.trees = nrow(data)/5 #gets roughly # of trees Chuyun's x-val found best
    model <- gbm(as.character(A) ~ ., data=data, distribution="bernoulli", n.trees = n.trees)   
  }
  return(model)
}

# Takes in dataset features and model and returns propensity scores
lr_propensity <- function(features, model, mode = 1){
  if("Y" %in% colnames(features)){
    features <- subset(features, select = -c(Y))
  }
  if("A" %in% colnames(features)){
    features <- subset(features, select = -c(A))
  }
  if (mode == 1){
    props <- predict(model, newx = data.matrix(features), type = "response")
  } 
  else if (mode ==4){
    props <- predict(model, newx = data.matrix(features), type = "prob")[,2]
  }
  else if (mode ==5){
    props <- predict(model, newx = data.matrix(features), n.trees = 500)
  }
  else{
    props <- predict(model, newx = data.matrix(features), type = "response", s=0.01)
    props <- props[, 1]
  }
  
  return(props)
  
}