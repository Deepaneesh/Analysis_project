# Cleaning the Environment ------------------------------------------------

rm(list = ls())
gc()
set.seed(123)
options(scipen = 999)


# constant ----------------------------------------------------------------

source("scripts/01_constants.R")


# Download data -----------------------------------------------------------

if (download_data) {
  source("scripts/02_data_download.R")
}


# Input -------------------------------------------------------------------

source("scripts/03_input.R")

# Data Manipulation -------------------------------------------------------

source("scripts/04_data_manipulation.R")


# Forecasting -------------------------------------------------------------

source("scripts/05_forecasting.R")


# plot --------------------------------------------------------------------

source("scripts/06_plot.R")


# output ------------------------------------------------------------------

source("scripts/07_output.R")
