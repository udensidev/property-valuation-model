# Property Valuation Using Machine Learning

## Case Overview
The Cook County Assessor’s Office (CCAO) is responsible for determining the fair market value of properties, which is crucial for property tax collection. This funding supports essential public services, including education, law enforcement, and infrastructure. Historically, property assessment suffered from inaccuracies and a lack of transparency. Since 2018, new leadership has focused on modernizing the valuation process by incorporating data science and technology to improve accuracy and fairness.

This project aims to enhance property valuation methodologies by leveraging machine learning techniques to predict market values of residential properties. Our objective is to develop models that minimize the Mean Squared Error (MSE) of predictions, ensuring accuracy and reliability in property assessments.

---

## Methodology

### 1. Data Understanding and Preparation
#### Data Exploration
The project utilizes two primary datasets:
- **Historic Property Data (historic_property_data.csv):** Contains historical sales data for 50,000 properties.
- **Prediction Property Data (predict_property_data.csv):** Contains 10,000 properties requiring value predictions.
- **Codebook (codebook.csv):** Provides descriptions of variables.

Key steps:
- Libraries `tidyverse` (for data manipulation/visualization) and `caret` (for machine learning tasks) are loaded.
- Initial dataset structure is examined using `str()` to identify variable types, missing values, and required transformations.

#### Data Cleaning
- Logical columns (e.g., `ind_large_home`, `ind_garage`, `ind_arms_length`) are converted into factors for model compatibility.
- Redundant or irrelevant columns are removed.
- Missing values are handled:
  - Numeric columns: replaced with the median.
  - Categorical columns: replaced with "Unknown."
- Binary variables are transformed for better interpretability.
- Final NA check is performed using `is.na()`.

#### Feature Selection
- **Numeric Predictors:** Selected based on correlation (≥ 0.4) with `sale_price`.
- **Categorical Predictors:** Evaluated using ANOVA and Lasso regression with one-hot encoding.
- A final dataset with 25 significant variables is created for model training.

---

### 2. Model Development and Validation
#### Data Splitting
The cleaned dataset is split:
- **Training Set:** 80%
- **Testing Set:** 20%
(Split done using `createDataPartition` from `caret`)

#### Initial Models
1. **Linear Regression Model:**
   - Establishes baseline predictions.
   - Built using 5-fold cross-validation.
   - Evaluated using RMSE and R-squared.
   
2. **Random Forest Model:**
   - One-hot encoding applied before training.
   - Optimal number of trees determined (ntree = 35).
   - Feature importance assessed.
   
#### Model Evaluation
- **Linear Regression:**
  - RMSE: 124,135.7
  - R²: 0.8378 (83.78% variance explained)
- **Random Forest:**
  - RMSE: 122,593.5 (lower error, better performance)

The **Random Forest model performed best**, capturing non-linear relationships and providing more accurate predictions.

---

### 3. Predictions
- The **Random Forest model** was selected for generating predictions.
- The `predict_property_data.csv` dataset was prepared:
  - One-hot encoding applied.
  - Missing columns added (default value = 0).
  - Extra columns removed for consistency.
- Predictions were saved in CSV format with:
  - `pid`: Property ID
  - `assessed_value`: Predicted market value

---

## Results and Insights
- The **Random Forest model** outperformed the Linear Regression model, achieving a lower RMSE.
- Summary statistics of predicted values:
  - **Mean Sale Price:** $317,342.3
  - **Median Sale Price:** $244,165.82
- The **distribution of predicted sale prices** was visualized (Figure 12 in the report).
- The model’s performance supports its effectiveness in improving property valuation for CCAO.

---

## Repository Structure
```
.
├── data/
│   ├── historic_property_data.csv
│   ├── predict_property_data.csv
│   ├── codebook.csv
├── src/
│   ├── data_cleaning.R
│   ├── feature_engineering.R
│   ├── train_model.R
│   ├── predict_values.R
├── results/
│   ├── predictions.csv
│── analysis.Rmd
├── README.md
└── report.pdf
```

---

## Installation and Usage
### Prerequisites
- R (version >= 4.0)
- R libraries: `tidyverse`, `caret`, `randomForest`

### Running the Code
1. Clone the repository:
   ```sh
   git clone https://github.com/udensidev/property-valuation.git
   ```
2. Set the working directory to `src/` in R.
3. Run the scripts in the following order:
   ```r
   source("data_cleaning.R")
   source("feature_engineering.R")
   source("train_model.R")
   source("predict_values.R")
   ```
4. Check the `results/` folder for `predictions.csv` and performance metrics.

---

## Future Improvements
- **Model Optimization:** Tune hyperparameters for better accuracy.
- **Feature Engineering:** Explore additional predictors.

