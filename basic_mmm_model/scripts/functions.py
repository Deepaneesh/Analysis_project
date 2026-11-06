# overall reuired libraries
import os
import pandas as pd
from datetime import datetime
from pathlib import Path
import shutil

#===============================================================================
# 1. Create project folders
# ==============================================================================

# Required libraries:
import os

def create_project_folders(
    dirs=("input", "output", "scripts", "temp")
):
    
    for d in dirs:
        
        if not os.path.exists(d):
            print(f"Creating directory: {d}")
        
        os.makedirs(d, exist_ok=True)
# --------------------------------------------------------------------------------

# ================================================================================
# 2. View a DataFrame in Excel or CSV format
# ==============================================================================

# Required libraries:
import os
import pandas as pd
from datetime import datetime

def excel_view(df, format="csv"):
    
    df = pd.DataFrame(df)

    if format not in ["csv", "xlsx"]:
        raise ValueError(
            "format must be either 'csv' or 'xlsx'"
        )

    dir_path = os.path.join(
        os.getcwd(),
        "temp"
    )

    os.makedirs(
        dir_path,
        exist_ok=True
    )

    timestamp = datetime.now().strftime(
        "%Y-%m-%d_%H-%M-%S"
    )

    file = os.path.join(
        dir_path,
        f"{timestamp}_temp.{format}"
    )

    if format == "csv":
        df.to_csv(file, index=False)

    elif format == "xlsx":
        df.to_excel(file, index=False)

    os.startfile(
        os.path.abspath(file)
    )
#------------------------------------------------------------------------------

#==============================================================================
# 3. Delete folders
# ==============================================================================

# Required libraries:
from pathlib import Path
import shutil

def delete_folder(
    path="temp",
    force=True
):

    paths = (
        [path]
        if isinstance(path, str)
        else path
    )

    results = []

    for p in paths:

        folder = Path(p)

        if not folder.exists():
            print(f"Not available: {p}")
            results.append(False)
            continue

        try:

            if folder.is_dir():
                shutil.rmtree(folder)

            elif force:
                folder.unlink()

            print(f"Deleted: {p}")
            results.append(True)

        except Exception:
            results.append(False)

    return results
# --------------------------------------------------------------------------------

# ==============================================================================
# 4. Trim spaces from all columns
# ==============================================================================

# Required libraries:
import pandas as pd

def trimmed_data(data):

    if not isinstance(
        data,
        pd.DataFrame
    ):
        raise TypeError(
            "`data` must be a pandas DataFrame."
        )

    numeric_var = data.select_dtypes(
        include="number"
    ).columns

    categorical_var = data.select_dtypes(
        include="category"
    ).columns

    trim_data = data.astype(str).apply(
        lambda col: col.str.strip()
    )

    for col in numeric_var:

        trim_data[col] = pd.to_numeric(
            trim_data[col],
            errors="coerce"
        )

    for col in categorical_var:

        trim_data[col] = (
            trim_data[col]
            .astype("category")
        )

    return trim_data
# ------------------------------------------------------------------------------------------

# ==============================================================================
# 5. Get the latest data file based on date in filename
# ==============================================================================

from pathlib import Path
import pandas as pd
import re


def get_latest_data(path, name=None, ext=None):

    path = Path(path)

    # Get files
    files = [
        file for file in path.iterdir()
        if file.is_file()
    ]

    if len(files) == 0:
        raise ValueError(
            "No files found in the specified path."
        )

    # If only one file exists
    if len(files) == 1:

        latest_file = files[0]

    else:

        file_names = [file.name for file in files]

        # Split filename
        split_data = [
            file_name.split(" - ", 1)
            for file_name in file_names
        ]

        # Dates
        dates = [
            x[0] if len(x) > 0 else None
            for x in split_data
        ]

        # Dataset names
        dataset_names = [
            x[1] if len(x) > 1 else ""
            for x in split_data
        ]

        # Remove extensions
        dataset_names_clean = [
            re.sub(r"\..*$", "", x)
            for x in dataset_names
        ]

        # Convert dates
        dates = pd.to_datetime(
            dates,
            format="%d-%m-%Y",
            errors="coerce"
        )

        # Filter by name
        if name is not None:

            idx = [
                bool(
                    re.search(
                        name,
                        dataset_name,
                        re.IGNORECASE
                    )
                )
                for dataset_name in dataset_names_clean
            ]

            files = [
                file
                for file, keep in zip(files, idx)
                if keep
            ]

            dates = dates[idx]

        # Filter by extension
        if ext is not None:

            ext = ext.lstrip(".")

            idx = [
                file.suffix.lower() == f".{ext.lower()}"
                for file in files
            ]

            files = [
                file
                for file, keep in zip(files, idx)
                if keep
            ]

            dates = dates[idx]

        # No files after filtering
        if len(files) == 0:
            raise ValueError(
                "No files found matching criteria"
            )

        # Latest date
        max_date = dates.max()

        latest_files = [
            file
            for file, date in zip(files, dates)
            if date == max_date
        ]

        # Multiple latest files
        if len(latest_files) > 1:

            print(
                "Multiple files found with the latest date:"
            )

            print(
                "\n".join(str(file) for file in latest_files)
            )

            raise ValueError(
                "Please specify 'name' or 'ext' to narrow down."
            )

        latest_file = latest_files[0]

    print(f"Loading: {latest_file}")

    return str(latest_file)

# ==============================================================================

# =============================================================================
#  6. Save file with today's date in filename
# ==============================================================================

from pathlib import Path
from datetime import date


def save_with_date(path, filename):

    # Create directory if it doesn't exist
    path = Path(path)
    path.mkdir(parents=True, exist_ok=True)

    # Today's date
    today = date.today().strftime("%d-%m-%Y")

    # Create new filename
    new_name = f"{today} - {filename}"

    print(f"Saving file as: {new_name}")

    # Return complete file path
    return str(path / new_name)

# =============================================================================


# =============================================================================
# 7. Dummy variable Creation 
# ============================================================================

import pandas as pd
import random
import warnings


def create_dummy_columns(
    data,
    variables,
    drop_first=False,
    remove_original=True,
    col_name_suffix=True,
    drop_level=None
):
    """
    Create dummy variables for categorical columns.

    Parameters
    ----------
    data : pandas.DataFrame
        Input DataFrame.

    variables : list
        List of categorical columns for which dummy variables should be created.

    drop_first : bool, default=False
        Whether to drop one level from each categorical variable.

    remove_original : bool, default=True
        Whether to remove the original categorical columns.

    col_name_suffix : bool, default=True
        If True:
            gender -> gender_Male, gender_Female
        If False:
            gender -> Male, Female

    drop_level : dict, default=None
        Dictionary specifying which level to drop for each variable.

        Example:
        {
            "gender": "Male",
            "city": "Chennai"
        }

        Only applicable when drop_first=True.

    Returns
    -------
    pandas.DataFrame
        DataFrame containing the dummy variables.
    """

    # -----------------------------
    # Validation
    # -----------------------------

    if drop_level is None:
        drop_level = {}

    if not drop_first and drop_level:
        raise ValueError(
            "drop_level cannot be provided when drop_first=False. "
            "Set drop_first=True or remove drop_level."
        )

    # Check variables exist
    missing_variables = [var for var in variables if var not in data.columns]

    if missing_variables:
        raise ValueError(
            f"The following variables are not present in the DataFrame: "
            f"{missing_variables}"
        )

    # Check drop_level variables exist in variables
    invalid_drop_variables = [
        var for var in drop_level if var not in variables
    ]

    if invalid_drop_variables:
        raise ValueError(
            f"drop_level contains variables that are not included in "
            f"'variables': {invalid_drop_variables}"
        )

    # -----------------------------
    # Work on a copy
    # -----------------------------

    df = data.copy()

    # -----------------------------
    # Create dummy variables
    # -----------------------------

    for var in variables:

        levels = df[var].dropna().unique().tolist()

        # ---------------------------------
        # Decide which level to drop
        # ---------------------------------

        level_to_drop = None

        if drop_first:

            if var in drop_level:
                level_to_drop = drop_level[var]

                if level_to_drop not in levels:
                    raise ValueError(
                        f"Level '{level_to_drop}' is not present in "
                        f"variable '{var}'. Available levels: {levels}"
                    )

            else:
                # Randomly select a level
                level_to_drop = random.choice(levels)

                warnings.warn(
                    f"You forgot to add a drop level for '{var}'. "
                    f"Randomly selected '{level_to_drop}' as the drop level.",
                    UserWarning
                )

        # ---------------------------------
        # Create dummies
        # ---------------------------------

        dummies = pd.get_dummies(
            df[var],
            prefix=var if col_name_suffix else None,
            prefix_sep="_",
            dtype=int
        )

        # ---------------------------------
        # Remove selected level
        # ---------------------------------

        if level_to_drop is not None:
            dummy_column = (
                f"{var}_{level_to_drop}"
                if col_name_suffix
                else str(level_to_drop)
            )

            if dummy_column in dummies.columns:
                dummies = dummies.drop(columns=dummy_column)

        # ---------------------------------
        # Remove original variable
        # ---------------------------------

        if remove_original:
            df = df.drop(columns=var)

        # Add dummy columns
        df = pd.concat([df, dummies], axis=1)

    return df

# ===========================================================================================================================================================================
# 1. Best Subset Regression 
# ===========================================================================================================================================================================

# This function performs best subset regression on the given dataset. 
# It evaluates all possible combinations of predictor variables and computes various statistics for each model, including RSS, R², Adjusted R², Mallows' Cp, AIC, and BIC.

# Required libraries:
import itertools
import pandas as pd
import statsmodels.api as sm

def best_subset_regression(X, y):
    
    results = []

    # Full model for Mallows' Cp
    X_full = sm.add_constant(X)
    full_model = sm.OLS(y, X_full).fit()
    
    mse_full = full_model.ssr / full_model.df_resid
    n = len(y)

    # All possible combinations
    for k in range(1, len(X.columns) + 1):

        for variables in itertools.combinations(X.columns, k):

            X_temp = sm.add_constant(X[list(variables)])
            model = sm.OLS(y, X_temp).fit()

            rss = model.ssr
            r2 = model.rsquared
            adj_r2 = model.rsquared_adj
            aic = model.aic
            bic = model.bic

            # Number of parameters including intercept
            p = k + 1

            # Mallows' Cp
            cp = (rss / mse_full) - (n - 2 * p)

            results.append({
                "Variables": ", ".join(variables),
                "RSS": rss,
                "R2": r2,
                "Adj R2": adj_r2,
                "Cp": cp,
                "AIC": aic,
                "BIC": bic
            })

    return pd.DataFrame(results)

# ---------------------------------------------------------------------------------------------------------------
def time_accuracy(actual, predicted, digits=4):

    # Convert to numeric arrays
    actual = np.asarray(actual, dtype=float)
    predicted = np.asarray(predicted, dtype=float)

    # Check same length
    if len(actual) != len(predicted):
        raise ValueError(
            "'actual' and 'predicted' must have the same length."
        )

    # Check missing values
    if np.isnan(actual).any() or np.isnan(predicted).any():
        raise ValueError(
            "Missing values are not allowed."
        )

    # Check finite values
    if not np.isfinite(actual).all() or not np.isfinite(predicted).all():
        raise ValueError(
            "Inputs must contain only finite numeric values."
        )

    # Errors
    errors = actual - predicted

    # Mean Error
    me = np.mean(errors)

    # Mean Squared Error
    mse = np.mean(errors ** 2)

    # Root Mean Squared Error
    rmse = np.sqrt(mse)

    # Mean Absolute Error
    mae = np.mean(np.abs(errors))

    # Mean Percentage Error
    if np.any(actual == 0):
        mpe = np.nan
    else:
        mpe = np.mean(errors / actual) * 100

    # Mean Absolute Percentage Error
    if np.any(actual == 0):
        mape = np.nan
    else:
        mape = np.mean(np.abs(errors / actual)) * 100

    # Symmetric Mean Absolute Percentage Error
    denominator = np.abs(actual) + np.abs(predicted)

    smape_values = (
        2 * np.abs(errors) / denominator
    )

    # Equivalent to na.rm = TRUE
    smape = np.nanmean(smape_values) * 100

    # Mean Absolute Scaled Error
    if len(actual) < 2:
        mase = np.nan
    else:
        scale = np.mean(np.abs(np.diff(actual)))

        if scale == 0:
            mase = np.nan
        else:
            mase = mae / scale

    # R-squared
    ss_res = np.sum(errors ** 2)
    ss_tot = np.sum(
        (actual - np.mean(actual)) ** 2
    )

    if ss_tot == 0:
        r_squared = np.nan
    else:
        r_squared = 1 - (ss_res / ss_tot)

    # Correlation
    correlation = np.corrcoef(actual, predicted)[0, 1]

    # Output
    out = pd.DataFrame({
        "Metric": [
            "R-squared",
            "Correlation",
            "RMSE",
            "MSE",
            "MAE",
            "ME",
            "MPE",
            "MAPE",
            "SMAPE",
            "MASE"
        ],
        "Value": np.round(
            [
                r_squared,
                correlation,
                rmse,
                mse,
                mae,
                me,
                mpe,
                mape,
                smape,
                mase
            ],
            digits
        )
    })

    return out

# -------------------------------------------------------------------------------------------------------------
