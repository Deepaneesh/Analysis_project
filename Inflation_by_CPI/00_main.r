# Cleaning the Environment -----------------------------------------------

rm(list = ls())
gc()
set.seed(123)
options(scipen = 999)


# Constants --------------------------------------------------------------

source("scripts/01_set_constants.r")


# Data Download ----------------------------------------------------------

if (download_data) {
  source("scripts/02_data_download.r")
}


# Input ------------------------------------------------------------------

source("scripts/03_input.r")


# Data Manipulation -----------------------------------------------------

source("scripts/04_data_manipulation.r")

# Forecasting -----------------------------------------------------------

source("scripts/05_forecasting.r")

# Plots ----------------------------------------------------------------

source("scripts/06_plot.r")

# Output ---------------------------------------------------------------

source("scripts/07_output.r")

# Clearing the unnessary files and folders

delete_folder()

keep_latest_files("input", n = 3)
keep_latest_files("plots", n = 3)
keep_latest_files("output", n = 3)
