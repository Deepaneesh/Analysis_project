rm(list = ls());gc()
set.seed(123)
options(scipen = 999)


# Set constants -----------------------------------------------------------

source("scripts/01_constants.R")


# Data download -----------------------------------------------------------

if(download_data){
  source("scripts/02_data_download.R")
} else {
  print(
    paste0(
      paste0(rep("*",20),collapse = "")," ",
      "Data download is disabled. Skipping data download step."," ",
      paste0(rep("*",20),collapse = "")
    )
  )
}

# Input -------------------------------------------------------------------

source("scripts/03_input.R")

# Data Manipulation -------------------------------------------------------

source('scripts/04_data_manipulation.R')


# Forecasting -------------------------------------------------------------

source("scripts/05_forecasting.R")
