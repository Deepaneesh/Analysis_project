
# Loading Libraries -------------------------------------------------------

## Downloading the pacman package if it is not installed
if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}

pacman::p_load(
  tidyverse,
  janitor,
  lmtest,
  caret,
  RVD,
  magrittr,
  car,
  leaps,
  dlookr,
  forecast,
  tseries,
  relaimpo, # shapley
  rwa
)

# Loading the functions --------------------------------------------------

source("scripts/00_functions.R")

# Resolving the conflict
select <- dplyr::select

# Creating the project folders --------------------------------------------

create_project_folders(c("input","plot","output","scripts"))


# Transformations parameters ----------------------------------------------

theta <- list(
  tv = 0.65,
  google = 0.30,
  meta = 0.45,
  youtube = 0.50,
  radio = 0.60
)

k <- list(
  tv = 95000,
  google = 38000,
  meta = 30000,
  youtube = 23000,
  radio = 21000
)

shape <- list(
  tv = 1.50,
  google = 1.20,
  meta = 1.35,
  youtube = 1.15,
  radio = 1.40
)
