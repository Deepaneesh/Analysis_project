
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

import numpy as np
from scipy.interpolate import (
    CubicSpline,
    PchipInterpolator,
    Akima1DInterpolator
)

# ==============================================================================================================
# 1. Fill missing values in a time series using spline interpolation 
# ==============================================================================================================

# required libraries:
import numpy as np
from scipy.interpolate import (
    CubicSpline,
    PchipInterpolator,
    Akima1DInterpolator
)

def fill_spline(
    x,
    inside=True,
    outside=True,
    back=False,
    method="natural"
):
    """
    Fill missing values using spline interpolation.

    Parameters
    ----------
    x : array-like
        Time series containing numeric values and NaN values.

    inside : bool, default=True
        Fill missing values between the first and last non-NA values.

    outside : bool, default=True
        Fill missing values outside the observed range.

    back : bool, default=False
        If True, fill missing values before the first non-NA value.

    method : str, default="natural"
        Interpolation method. Choose one of:
        "natural", "not-a-knot", "periodic", "pchip", "akima".

    Returns
    -------
    numpy.ndarray
        Time series with missing values filled.
    """

    # Available methods
    methods = [
        "natural",
        "not-a-knot",
        "periodic",
        "pchip",
        "akima"
    ]

    # Check method
    if method not in methods:
        raise ValueError(
            f"Invalid method '{method}'. "
            f"Choose one of: {', '.join(methods)}"
        )

    # Convert to numeric array
    x = np.asarray(x, dtype=float)

    n = len(x)

    # Non-NA indices
    idx = np.where(~np.isnan(x))[0]

    # At least two non-NA values required
    if len(idx) < 2:
        raise ValueError(
            "At least two non-NA values are required for spline filling."
        )

    # Copy original data
    y = x.copy()

    # Python indices → spline x values
    x_idx = idx + 1

    # ------------------------------------------------------------------
    # Create interpolation function
    # ------------------------------------------------------------------

    if method == "natural":

        sf = CubicSpline(
            x_idx,
            x[idx],
            bc_type="natural"
        )

    elif method == "not-a-knot":

        sf = CubicSpline(
            x_idx,
            x[idx]
        )

    elif method == "periodic":

        # Periodic spline requires first and last values to be equal
        if not np.isclose(x[idx[0]], x[idx[-1]]):
            raise ValueError(
                "For 'periodic' interpolation, "
                "the first and last non-NA values must be equal."
            )

        sf = CubicSpline(
            x_idx,
            x[idx],
            bc_type="periodic"
        )

    elif method == "pchip":

        sf = PchipInterpolator(
            x_idx,
            x[idx]
        )

    elif method == "akima":

        sf = Akima1DInterpolator(
            x_idx,
            x[idx]
        )

    # ------------------------------------------------------------------
    # Fill inside missing values
    # ------------------------------------------------------------------

    if inside:

        left = idx[0]
        right = idx[-1]

        na_inside = np.where(
            np.isnan(x) &
            (np.arange(n) >= left) &
            (np.arange(n) <= right)
        )[0]

        if len(na_inside) > 0:
            y[na_inside] = sf(na_inside + 1)

    # ------------------------------------------------------------------
    # Fill outside missing values
    # ------------------------------------------------------------------

    if outside:

        # Fill values before first observed value
        if back and idx[0] > 0:

            left_idx = np.arange(0, idx[0])

            y[left_idx] = sf(left_idx + 1)

        # Fill values after last observed value
        if idx[-1] < n - 1:

            right_idx = np.arange(idx[-1] + 1, n)

            y[right_idx] = sf(right_idx + 1)

    return y
# -------------------------------------------------------------------------------------------------------------

# =============================================================================================================
# 2. Calculating the growth rate of the series 
# =============================================================================================================

# Required libraries:
import numpy as np

def growth_rate(x, k=1):
    
    # -----------------------------
    # Input validation
    # -----------------------------
    x = np.asarray(x, dtype=float)

    n = len(x)

    if k < 1 or k >= n:
        raise ValueError(
            "k must be >= 1 and less than length of x"
        )

    # -----------------------------
    # Initialize output
    # -----------------------------
    g = np.full(n, np.nan)

    # -----------------------------
    # Compute growth rate
    # -----------------------------
    for t in range(k, n):

        if (
            not np.isnan(x[t])
            and not np.isnan(x[t - k])
            and x[t - k] != 0
        ):
            g[t] = (x[t] - x[t - k]) / x[t - k]
        else:
            g[t] = np.nan

    return g
# -------------------------------------------------------------------------------------------------------------

# =============================================================================================================
# 3. apply growth rate to the series 
# =============================================================================================================

# Required libraries:
import numpy as np

def apply_growth_rate(gr, series, k=1):

    # -----------------------------
    # Input validation
    # -----------------------------
    gr = np.asarray(gr, dtype=float)
    series = np.asarray(series, dtype=float)

    n = len(gr)

    if len(series) != n:
        raise ValueError(
            "gr and series must have the same length"
        )

    if k < 1 or k >= n:
        raise ValueError(
            "k must be >= 1 and less than length of series"
        )

    # -----------------------------
    # Initialize output
    # -----------------------------
    x = np.full(n, np.nan)

    # -----------------------------
    # Process each chain
    # -----------------------------
    for start in range(k):

        # Positions belonging to this chain
        idx = np.arange(start, n, k)

        # Known positions
        known_pos = idx[~np.isnan(series[idx])]

        #  Multiple anchors → STOP
        if len(known_pos) > 1:
            positions = ", ".join(
                str(pos + 1) for pos in known_pos
            )

            raise ValueError(
                f"Chain {start + 1} has multiple values "
                f"at positions: {positions}"
            )

        # ⚠️ No anchor → leave NA
        if len(known_pos) == 0:
            print(
                f"Chain {start + 1}: no known value "
                f"→ returning NA for this chain"
            )
            continue

        # -----------------------------
        # Anchor point
        # -----------------------------
        pos = known_pos[0]

        x[pos] = series[pos]

        # -----------------------------
        # Forward reconstruction
        # -----------------------------
        forward_idx = idx[idx > pos]

        for t in forward_idx:

            if (
                not np.isnan(gr[t])
                and not np.isnan(x[t - k])
            ):
                x[t] = x[t - k] * (1 + gr[t])

        # -----------------------------
        # Backward reconstruction
        # -----------------------------
        backward_idx = idx[idx < pos][::-1]

        for t in backward_idx:

            if (
                not np.isnan(gr[t + k])
                and not np.isnan(x[t + k])
            ):
                x[t] = x[t + k] / (1 + gr[t + k])

    return x

# -------------------------------------------------------------------------------------------------------------

# =============================================================================================================
# 4. Force growth rate to fill missing values in the series
# =============================================================================================================

import numpy as np


def apply_growth_rate_force(
    x,
    growth_rate,
    force_from_left=False,
    force_from_right=False
):
    # ----------------------------#
    # Validation
    # ----------------------------#

    if len(x) != len(growth_rate):
        raise ValueError("'x' and 'growth_rate' must have the same length.")

    if not isinstance(force_from_left, (bool, np.bool_)):
        raise ValueError("'force_from_left' must be True or False.")

    if not isinstance(force_from_right, (bool, np.bool_)):
        raise ValueError("'force_from_right' must be True or False.")

    if not force_from_left and not force_from_right:
        return x.copy()

    # ----------------------------#
    # Initialization
    # ----------------------------#

    x = np.array(x, dtype=float)
    growth_rate = np.array(growth_rate, dtype=float)

    original = ~np.isnan(x)

    left_fill = x.copy()
    right_fill = x.copy()

    n = len(x)

    # ----------------------------#
    # Force from Left
    # ----------------------------#

    if force_from_left:

        for i in range(n - 1):

            if not np.isnan(left_fill[i]):

                j = i + 1

                while j < n and not original[j]:

                    left_fill[j] = (
                        left_fill[j - 1]
                        * (1 + growth_rate[j])
                    )

                    j += 1

    # ----------------------------#
    # Force from Right
    # ----------------------------#

    if force_from_right:

        for i in range(n - 1, 0, -1):

            if not np.isnan(right_fill[i]):

                j = i - 1

                while j >= 0 and not original[j]:

                    right_fill[j] = (
                        right_fill[j + 1]
                        / (1 + growth_rate[j + 1])
                    )

                    j -= 1

    # ----------------------------#
    # Final Result
    # ----------------------------#

    x_new = x.copy()

    missing = np.where(~original)[0]

    for i in missing:

        if (
            force_from_left
            and force_from_right
            and not np.isnan(left_fill[i])
            and not np.isnan(right_fill[i])
        ):

            x_new[i] = np.mean(
                [left_fill[i], right_fill[i]]
            )

        elif (
            force_from_left
            and not np.isnan(left_fill[i])
        ):

            x_new[i] = left_fill[i]

        elif (
            force_from_right
            and not np.isnan(right_fill[i])
        ):

            x_new[i] = right_fill[i]

    # ----------------------------#
    # Preserve Original Values
    # ----------------------------#

    x_new[original] = x[original]

    return x_new

# -------------------------------------------------------------------------------------------------------------

# =============================================================================================================
#5. Apply growth rate to fill missing values in the tails of the series
# =============================================================================================================


import numpy as np


def apply_growth_rate_tail(
    x,
    growth_rate,
    left_tail=True,
    right_tail=True
):
    # ----------------------------#
    # Validation
    # ----------------------------#

    if len(x) != len(growth_rate):
        raise ValueError(
            "'x' and 'growth_rate' must have the same length."
        )

    if not left_tail and not right_tail:
        return np.array(x, dtype=float).copy()

    # ----------------------------#
    # Initialization
    # ----------------------------#

    x_new = np.array(x, dtype=float).copy()
    growth_rate = np.array(growth_rate, dtype=float)

    non_na = np.where(~np.isnan(x_new))[0]

    if len(non_na) == 0:
        raise ValueError("'x' contains only NA values.")

    # ----------------------------#
    # Left Tail
    # ----------------------------#

    if left_tail:

        first_non_na = np.min(non_na)

        if first_non_na > 0:

            for i in range(first_non_na - 1, -1, -1):

                x_new[i] = (
                    x_new[i + 1]
                    / (1 + growth_rate[i + 1])
                )

    # ----------------------------#
    # Right Tail
    # ----------------------------#

    if right_tail:

        last_non_na = np.max(non_na)

        if last_non_na < len(x_new) - 1:

            for i in range(last_non_na + 1, len(x_new)):

                x_new[i] = (
                    x_new[i - 1]
                    * (1 + growth_rate[i])
                )

    return x_new

# ---------------------------------------------------------------------------------------------------------------
