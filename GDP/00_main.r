# Cleaning the Environment -----------------------------------------------

rm(list = ls())
gc()
set.seed(123)
options(scipen = 999)

# Set_constant -----------------------------------------------------------

source("scripts/01_set_constant.r")


# data download ----------------------------------------------------------

if (download_data) {
  source("scripts/02_data_download.r")
}


# Input ------------------------------------------------------------------

source("scripts/03_input.r")


# Data Manipulation ------------------------------------------------------

source("scripts/04_data_manipulation.r")


# Forecasting ------------------------------------------------------------

source("scripts/05_forecasting.r")


# plots ------------------------------------------------------------------

source("scripts/06_plot.r")


# output -----------------------------------------------------------------

source("scripts/07_output.r")


# Deleting the tempory folders -------------------------------------------

delete_folder()
