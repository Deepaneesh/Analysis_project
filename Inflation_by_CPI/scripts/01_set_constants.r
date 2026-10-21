# Flags -----------------------------------------------------------------

download_data <- FALSE
predict_year <- 2027

# Loading the Library ----------------------------------------------------

## Downloading the pacman package if it is not installed
if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}

# Loading all required packages
pacman::p_load(
  tidyverse,
  RVD,
  data.table,
  worldbank,
  scales,
  janitor,
  magrittr,
  patchwork
)


# Create Project folders -------------------------------------------------

create_project_folders(c(
  "input",
  "output",
  "scripts",
  "plots"
))

# Constants --------------------------------------------------------------
start_year <- 1960
end_year <- predict_year
years <- start_year:end_year
