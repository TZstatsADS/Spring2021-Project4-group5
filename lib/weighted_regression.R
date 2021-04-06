# Applied Data Science Spring 2021
# Project 4 Group 5
# Created by Yandong Xiong and  Amir Idris

weighted_regression <- function(data, prop_scores){
  features <- data
  if("Y" %in% colnames(features)){
    features <- subset(features, select = -c(Y))
  }
  if("A" %in% colnames(features)){
    features <- subset(features, select = -c(A))
  }
  
  #x = model.matrix(A~.,data.l[,-1])[,-1]
  #y = data.l[,2]
  #cv.lasso <- cv.glmnet(x, y, alpha = 1, family = "binomial")
  #fit_lasso = glmnet(x, y, family = "binomial", alpha = 1, lambda = cv.lasso$lambda.min)
  #ps = predict(fit_lasso, x, type="response")
  #ps.dt = as_tibble(ps) %>% mutate(index = 1:length(ps), treatedOrNot = data.l$A) %>% rename(ps="s0")
  
  # Get inverse propensity weights
  A <- as.numeric(data$A)
  w <- (A/prop_scores) + ((1 - A)/(1 - prop_scores))
  
  #Filter covariates
  d <- dim(features)[2]
  selected <- c()
  A <- as.factor(data$A)
  alpha <- 0.05
  
  for(i in 1:d){
    curr_feature <- features[, i]
    mod <- lm(Y ~ A + curr_feature, data=data)
    mod.summary <- summary(mod)
    if(mod.summary$coefficients[3, "Pr(>|t|)"] < alpha){
      selected <- c(selected, i)
    }
  }
  z <- features[, selected]
  
  # Get full dataframe for weighted regression
  Y <- data$Y
  zbar <- colMeans(z)
  zMinusZBar <- sweep(z, 2, zbar)
  colnames(zMinusZBar) <- sapply(colnames(zMinusZBar), function(x) paste(x,paste(x,"_bar",sep=""),sep="_"))
  wr_data <- as.data.frame(cbind(z, zMinusZBar))
  wr_data <- as.data.frame(cbind(wr_data, A, Y))
  
  # Weighted Regression Model
  formula_string <- "Y ~ A"
  for(name in colnames(z)){
    formula_string <- paste(formula_string, name, sep= " + ")
  }
  for(name in colnames(zMinusZBar)){
    term <- paste(name, "A", sep=" * ")
    formula_string <- paste(formula_string, term, sep= " + ")
  }
  wr_formula <- as.formula(formula_string)
  wr_mod <- lm(wr_formula, data=wr_data, weights=w)
  wr_mod.summary <- summary(wr_mod)
  ATE_est <- wr_mod.summary$coefficients["A1", "Estimate"]
  
  return(ATE_est)
  
  #w = (as.numeric(ps.dt$treatedOrNot)-1)/ps.dt$ps + (2-as.numeric(ps.dt$treatedOrNot))/(1-ps.dt$ps)
  #var.indicator = summary(lm(Y~., data=data.l))$coefficients[,4]<.05
  #z = model.matrix(A~.,data.l[,-1])[,var.indicator[-2]][,-1]
  #zMinusZBar = (z - rowMeans(z))*(as.numeric(y)-1)
  #colnames(zMinusZBar) = sapply(colnames(zMinusZBar), function(x) paste(x,paste(x,"_bar",sep=""),sep="-"))
  #(ATE.l = lm(Y~.,data = cbind(data.l[,1:2], z, zMinusZBar), weights = w)) # with zMinusZBar
  #lm(Y~.,data = cbind(data.l[,1:2], z), weights = w) # without zMinusZBar
}



