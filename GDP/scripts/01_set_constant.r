# Flags ------------------------------------------------------------------
edition <- 2026
download_data <- FALSE
predict_year <- 2027

# Loading the Libraries --------------------------------------------------

library(tidyverse)
library(RVD)
library(magrittr)
library(janitor)
library(skimr)
library(scales)
library(dlookr)
library(worldbank)
library(rvest)

# Creating the project folders
create_project_folders(c(
  "input",
  "output",
  "scripts",
  "plots"
))


# Constants --------------------------------------------------------------

start_year <- 1970
end_year <- predict_year
years <- start_year:end_year

## World bank -------------------------------------------------------------

wb_start_year <- 1970
wb_end_year <- 2025
