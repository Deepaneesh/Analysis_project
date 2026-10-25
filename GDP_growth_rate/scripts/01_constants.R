# Flags -------------------------------------------------------------------

download_data <- FALSE
predict_year <- 2027
edition <- 2025


# Libraries ---------------------------------------------------------------

## Downloading the pacman package if it is not installed
if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}

# Loading all required packages
pacman::p_load(
  tidyverse,
  RVD,
  data.table,
  gapminder,
  scales,
  janitor,
  magrittr,
  patchwork,
  worldbank
)


# Creating the Project folders --------------------------------------------

RVD::create_project_folders(c(
  "input",
  paste0("input/", edition, "/", "GDP"),
  paste0("input/", edition, "/", "population"),
  "output",
  "plot",
  "scripts"
))

# Constants ---------------------------------------------------------------

start_year <- 1960
end_year <- predict_year
years <- start_year:end_year
