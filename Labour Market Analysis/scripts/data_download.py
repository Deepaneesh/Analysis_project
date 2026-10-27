import wbgapi as wb
import pandas as pd
import numpy as np

from scripts.function import *

def wb_data_download(start_year, end_year, edition):
    """
    Download labour market data from the World Bank.

    Parameters
    ----------
    start_year : int
        First year of the data.
    end_year : int
        Last year of the data.
    edition : str
        Data edition used for the project.
    """

    # Downloading the labour force data
    labour_force_data = wb.data.DataFrame(
        "SL.TLF.TOTL.IN",
        time=range(start_year, end_year + 1),
        labels=True
    )

    labour_force_data.to_csv(
        save_with_date(
            path=f"input/{edition}/Labour_force",
            filename="labour_force_data.csv"
        )
    )

    del labour_force_data

    # Downloading the employment-to-population ratio data
    employed_data = wb.data.DataFrame(
        "SL.EMP.TOTL.SP.ZS",
        time=range(start_year, end_year + 1),
        labels=True
    )

    employed_data.to_csv(
        save_with_date(
            path=f"input/{edition}/employed",
            filename="employed_data.csv"
        )
    )

    del employed_data

    # Downloading the unemployment rate data
    unemployed_data = wb.data.DataFrame(
        "SL.UEM.TOTL.ZS",
        time=range(start_year, end_year + 1),
        labels=True
    )

    unemployed_data.to_csv(
        save_with_date(
            path=f"input/{edition}/unemployed",
            filename="unemployed_data.csv"
        )
    )

    del unemployed_data