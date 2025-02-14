predict_new_data <- function(model, new_data, target = "sale_price") {
  # Create dummy variables
  dummy_formula <- reformulate(".", target)
  mm_new <- model.matrix(dummy_formula, new_data)[,-1]

  # Align columns with training data
  train_cols <- rownames(model$importance)
  missing_cols <- setdiff(train_cols, colnames(mm_new))
  mm_new <- cbind(mm_new, matrix(0, nrow = nrow(mm_new), ncol = length(missing_cols)))
  colnames(mm_new) <- c(colnames(mm_new)[1:(ncol(mm_new)-length(missing_cols))], missing_cols)
  mm_new <- mm_new[, train_cols]

  predictions <- predict(model, mm_new)
  new_data$predicted_price <- predictions
  return(new_data)
}