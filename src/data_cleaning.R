clean_data <- function(df, remove_cols = NULL) {
  # Convert logical columns to factors
  logical_cols <- sapply(df, is.logical)
  df[logical_cols] <- lapply(df[logical_cols], as.factor)

  # Convert character columns to factors
  char_cols <- sapply(df, is.character)
  df[char_cols] <- lapply(df[char_cols], as.factor)

  # Remove specified columns
  if (!is.null(remove_cols)) {
    df <- df[, !names(df) %in% remove_cols]
  }

  # Handle missing values
  handle_missing <- function(x) {
    if (is.numeric(x)) {
      x[is.na(x)] <- median(x, na.rm = TRUE)
    } else if(is.factor(x)) {
      levels(x) <- c(levels(x), "Unknown")
      x[is.na(x)] <- "Unknown"
    }
    return(x)
  }

  df[] <- lapply(df, handle_missing)
  return(df)
}