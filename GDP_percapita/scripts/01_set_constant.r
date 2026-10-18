# Flags

download_data <- TRUE

# Loading the Libraries --------------------------------------------------

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
  patchwork
)

# Creating project folders -----------------------------------------------

create_project_folders(c(
  "input",
  "scripts",
  "plots",
  "output"
))


# Constants --------------------------------------------------------------

start_year <- 1950
end_year <- 2010
years <- start_year:end_year
