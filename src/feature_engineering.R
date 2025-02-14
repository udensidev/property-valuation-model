select_features <- function(df, target = "sale_price", cor_threshold = 0.4, anova_threshold = 0.05) {
  # Numeric feature selection
  numeric_data <- df[, sapply(df, is.numeric)]
  cor_matrix <- cor(numeric_data, use = "complete.obs")
  numeric_features <- rownames(cor_matrix)[abs(cor_matrix[, target]) >= cor_threshold]

  # Categorical feature selection
  categorical_features <- names(df)[sapply(df, is.factor)]
  categorical_features <- setdiff(categorical_features, target)

  anova_test <- function(col) {
    if (nlevels(df[[col]]) < 2) return(NA)
    aov_res <- aov(reformulate(col, target), data = df)
    summary(aov_res)[[1]][["Pr(>F)"]][1]
  }

  p_values <- sapply(categorical_features, anova_test)
  categorical_features <- names(p_values[p_values < anova_threshold & !is.na(p_values)])

  return(unique(c(target, numeric_features, categorical_features)))
}