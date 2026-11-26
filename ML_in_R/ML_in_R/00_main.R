
# Cleaning the Environment ------------------------------------------------
rm(list = ls());gc()
set.seed(123)
options(scipen = 999)


# Loading the Constants ---------------------------------------------------

source("scripts/01_constants.R")


# Download data -----------------------------------------------------------

if(download_data){
  source('scripts/02_download_data.R')
}


# Use new model -----------------------------------------------------------

if(use_new_model){
  
  # Input -------------------------------------------------------------------
   source('scripts/03_input.R')
  
  # Data manipulation -------------------------------------------------------
  source('scripts/04_data_manipulation.R')
  
  # Modelling ---------------------------------------------------------------
  source('scripts/05_modelling.R')
  
  
}

