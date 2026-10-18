# Cleaning the Environment -----------------------------------------------

rm(list = ls())
gc()
set.seed(123)
options(scipen = 999)

# Set constant -----------------------------------------------------------

source("scripts/01_set_constant.r")

# Data download ----------------------------------------------------------

if (download_data) {
  source("scripts/02_data_downloading.r")
}

# Input ------------------------------------------------------------------

source("scripts/03_input.r")

# Data manipulation ------------------------------------------------------

source("scripts/04_data_manipulation.r")


# forecasting ------------------------------------------------------------

source("scripts/05_forecasting.r")


# Plot -------------------------------------------------------------------

source("scripts/06_plot.r")


# Output -----------------------------------------------------------------

source("scripts/07_output.r")


# Removing the temporary folders  ----------------------------------------

delete_folder()
