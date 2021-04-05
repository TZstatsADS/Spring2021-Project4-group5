# Boosted Stamps training function


# should be in lr_propensity_model function
model <- gbm(A~., data = data, 
             distribution = "bernoulli",
             n.trees = 60,
             shrinkage = 0.1, 
             interaction.depth = 1,
             n.minobsinnode = 10,
             bag.fraction = 1)

# should be in lr_propensity function
props <- predict(model, newx = data.matrix(features), n.trees = 60,type = "response")