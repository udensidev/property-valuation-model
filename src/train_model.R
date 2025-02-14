library(caret)
library(randomForest)

# Function to train linear regression model
train_lm_model <- function(train_data) {
  train_control <- trainControl(method = "cv", number = 5)
  lm_model <- train(sale_price ~ ., data = train_data, method = "lm", trControl = train_control)
  return(lm_model)
}

# Function to train Random Forest model
train_rf_model <- function(train_data) {
  dummies_train <- model.matrix(sale_price ~ ., data = train_data)[, -1]
  rf_model <- randomForest(x = dummies_train, y = train_data$sale_price, ntree = 35, importance = TRUE)
  return(rf_model)
}

# Function to evaluate model performance
evaluate_lm_model <- function(model, test_data, target = "sale_price") {
  preds <- predict(model, test_data)
  
  actual <- test_data[[target]]
  rmse <- sqrt(mean((actual - preds)^2))
  r2 <- 1 - (sum((actual - preds)^2) / sum((actual - mean(actual))^2))
  
  list(rmse = rmse, r2 = r2, predictions = preds)
}

evaluate_rf_model <- function(model, test_data, target = "sale_price") {
  dummies_test <- model.matrix(sale_price ~ ., data = test_data)[, -1]
  preds <- predict(model, dummies_test)
  
  actual <- test_data[[target]]
  rmse <- sqrt(mean((actual - preds)^2))
  r2 <- 1 - (sum((actual - preds)^2) / sum((actual - mean(actual))^2))
  
  list(rmse = rmse, r2 = r2, predictions = preds)
}