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
evaluate_model <- function(model, test_data) {
  predictions <- predict(model, newdata = test_data)
  rmse <- sqrt(mean((test_data$sale_price - predictions)^2))
  return(list(predictions = predictions, rmse = rmse))
}