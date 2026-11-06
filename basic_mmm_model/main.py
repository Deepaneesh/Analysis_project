# Cleaning the Environment ========================================================

%reset -sf
%whos

# Loading the libraries ========================================================================

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm
import matplotlib.pyplot as plt
import matplotlib.pyplot as plt
from pathlib import Path

# importing the functions
from scripts.functions import *

# Creating the project folders ========================================================================

create_project_folders(('input',
                        'scripts',
                        'output',
                        'data',
                        'plot',
                        'output',
                        'models'))


# Input ================================================================================

data = pd.read_csv(get_latest_data(path = 'input'))

# Data manipulation ================================================================================

# Data Cleaning 

# Checking for duplicates 

data[data.duplicated()].shape

# Removing the duplicates
data.drop_duplicates(inplace = True)

# Checking for missing values
data.isnull().sum()

# Drop the missing values
data.dropna(inplace = True)

# Data describe
data.dtypes
data.describe()

# Creating dummy columns for categorical variables ============================================

data = create_dummy_columns(data,
                      drop_first = True,
                      variables = ['channel','region','promotion'],
                      #col_name_suffix = False,
                      drop_level = {'channel':'Radio','region':'South','promotion':'No'})

# Data Splitting ================================================================================


x = data.drop('sales', axis = 1)
y = data['sales']

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size = 0.2, random_state = 42)
del x, y

# models =======================================================================================

# Linear regression model
lm_model = LinearRegression()
lm_model.fit(x_train, y_train)

print("Intercept:", lm_model.intercept_)

print("Coefficients:")
print(lm_model.coef_)

lm_coefficients = pd.DataFrame({
    "variable": x_train.columns,
    "coefficient": lm_model.coef_
})

print(lm_coefficients)

# OLS model

x_train_ols = sm.add_constant(x_train)
ols_model = sm.OLS(y_train, x_train_ols).fit()
print(ols_model.summary())

from statsmodels.stats.diagnostic import het_breuschpagan

bp_test = het_breuschpagan(
    ols_model.resid,
    ols_model.model.exog
)

bp_test
print("LM Statistic:", bp_test[0])
print("LM p-value:", bp_test[1])
print("F Statistic:", bp_test[2])
print("F p-value:", bp_test[3])


# For plots 
plot_folder = Path("plot")
plot_folder.mkdir(exist_ok=True)

# Residuals vs Fitted
plt.scatter(ols_model.fittedvalues, ols_model.resid)

plt.axhline(y=0)
plt.xlabel("Fitted values")
plt.ylabel("Residuals")
plt.title("Residuals vs Fitted Values")

plt.savefig(
    plot_folder / "residuals_vs_fitted.png",
    dpi=300,
    bbox_inches="tight"
)

plt.show()
plt.close()


# Distribution of Residuals
plt.hist(ols_model.resid, bins=20)

plt.xlabel("Residuals")
plt.ylabel("Frequency")
plt.title("Distribution of Residuals")

plt.savefig(
    plot_folder / "residual_distribution.png",
    dpi=300,
    bbox_inches="tight"
)

plt.show()
plt.close()

x_test_ols = sm.add_constant(x_test)
x_test["predicted_sales"] = ols_model.predict(x_test_ols)

x_test['actual_sales'] = y_test
x_test['residuals'] = x_test['actual_sales'] - x_test['predicted_sales']

# plotting actual vs predicted sales
plt.scatter(x_test['actual_sales'], x_test['predicted_sales'])
plt.xlabel("Actual Sales")
plt.ylabel("Predicted Sales")
plt.title("Actual vs Predicted Sales")
plt.close()
