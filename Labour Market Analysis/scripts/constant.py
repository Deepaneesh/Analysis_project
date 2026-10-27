# Flags ================================================================
download_data = True
predict_year  = 2027
edition = 2026


# Loading the libraries ==================================================

import pandas as pd
import numpy as np
import os
import wbgapi as wb
from datetime import datetime
from pathlib import Path
import shutil
from scipy.interpolate import (
    CubicSpline,
    PchipInterpolator,
    Akima1DInterpolator
)

# Constants ============================================================

start_year = 1960
end_year   = predict_year
years = list(range(start_year,end_year+1,1))
