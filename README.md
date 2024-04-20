# Project: Regression Model for Housing Prices in Los Angeles Area

## Introduction

The objective of this project was to develop a regression model to predict housing prices in the Los Angeles area. This project served as an introduction to time-series datasets and incorporating time-fixed effects into regression models.

## Dataset

The dataset comprised merged real estate transactions in the LA area during the first months of 2016. It consisted of two datasets: residentialsales1 and residentialsales2, merged on the `sr_unique_id` variable. The resulting merged dataset contained 5080 entries with 17 variables.

## Analyzing the Dataset

- Examined sales distribution by month:
  - January: 1565 sales
  - February: 1497 sales
  - March: 2018 sales
- Counted distinct zip codes within the dataset and within each sale month:
  - Total distinct zip codes: 111
  - Distinct zip codes in January: 108
  - Distinct zip codes in February: 109
  - Distinct zip codes in March: 109
- Removed outliers, including houses priced below $200,000 (46 houses).
- Created a descriptive statistics table to gain insights into the dataset.

## Building the Regression Model

- Initial model included variables:
  - lnpr (natural logarithm of sales price)
  - livingarea
  - livingarea2 (livingarea squared)
  - pr_age
  - pr_age2 (property age squared)
  - beds
  - baths
  - lotarea
- Identified insignificant variables (lotarea and pr_age2) and removed pr_age2 while retaining lotarea.
- Added dummy variables for February and March sales months and ZIP code dummy variables.
- Conducted multicollinearity analysis using correlation matrix and VIF chart, resulting in removal of baths and beds due to high correlation with livingarea.
- Final regression model included relevant variables.

## Conclusion

- Developed a regression model with an r-squared value of 0.801 for predicting house prices in the Los Angeles area.
- Residual analysis indicated no heteroskedasticity.
- Further details and full results are available in the Google Doc.
- Identified potential avenues for future research and discussed limitations of the analysis.
