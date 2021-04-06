# Applied Data Science Spring 2021
# Project 4 Group 5
# Created by Yandong Xiong, Edited by Amir Idris and Sean Harris

regression_tree_propensity_model <- function(data){
  if ("Y" %in% colnames(data)){
    data <- subset(data, select = -c(Y))
  }
  
  model <- rpart(A~., data = data, method = "class")
  #min_cp = model$cptable[which.min(model$cptable[,"xerror"]),"CP"]
  #model = prune(model, cp=min_cp)
  return(model)
}

regression_tree_propensity <- function(features, model){
  if("Y" %in% colnames(features)){
    features <- subset(features, select = -c(Y))
  }
  if("A" %in% colnames(features)){
    features <- subset(features, select = -c(A))
  }
  
  props <- predict(model, newx = data.matrix(features), type = "prob")[,2]
  dx <- 0.000001
  props <- ifelse(props == 1, props - dx, props)
  props <- ifelse(props == 0, props + dx, props)
  names(props) <- c(1:length(props))
  return(props)
}