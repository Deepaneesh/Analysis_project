
# Flags -------------------------------------------------------------------

download_data <- FALSE
edition <- 2026


# Libraries ---------------------------------------------------------------

if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}

# Loading libraries

pacman::p_load(
  tidyverse,
  RVD,
  magrittr,
  skimr,
  dlookr,
  janitor,
  scales,
  worldbank,
  patchwork,
  econoR
)

# Creating the project folders

create_project_folders(c("input",
                         paste0("input/",edition,"/labour_data"),
                         paste0("input/",edition,"/employed_data"),
                         paste0("input/",edition,"/unemployed_data"),
                         "output",
                         paste0("output/",edition),
                         "scripts",
                         "plot",
                         paste0("plot/",edition)))

# Years
start_year <- 1990
end_year   <- 2025
predict_year <- 2027
years <- start_year:predict_year
y_years <- paste0("Y",years)
