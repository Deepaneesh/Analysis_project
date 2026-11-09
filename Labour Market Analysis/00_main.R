
# Cleaning the Environment ------------------------------------------------

rm(list = ls());gc()
set.seed(123)
options(scipen = 999)


# constants ---------------------------------------------------------------

source("scripts/01_constants.R")

# Downloading the data ---------------------------------------------------

if(download_data){
  source("scripts/02_download_data.R")
}


# Input -------------------------------------------------------------------

source("scripts/03_input.R")


# Data Manipulation -------------------------------------------------------

source("scripts/04_data_manipulation.R")


# Forecasting -------------------------------------------------------------

source("scripts/05_forecasting.R")


# Plot --------------------------------------------------------------------

source("scripts/06_plots.R")

# output ------------------------------------------------------------------

source("scripts/07_output.R")

## Cleaning the Environment ------------------------------------------------
delete_folder()
