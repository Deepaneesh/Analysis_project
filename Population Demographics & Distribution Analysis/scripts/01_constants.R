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

# Creating Project folders ------------------------------------------------

create_project_folders(
  c(
    "input",
    
    # Total population
    paste0("input/", edition, "/total_population"),
    
    # Rural
    paste0("input/", edition, "/rural"),
    paste0("input/", edition, "/rural/rural_population"),
    paste0("input/", edition, "/rural/rural_population_percentage"),
    paste0("input/", edition, "/rural/rural_male_population_percentage"),
    paste0("input/", edition, "/rural/rural_female_population_percentage"),
    
    # Urban
    paste0("input/", edition, "/urban"),
    paste0("input/", edition, "/urban/urban_population"),
    paste0("input/", edition, "/urban/urban_population_percentage"),
    paste0("input/", edition, "/urban/urban_male_population_percentage"),
    paste0("input/", edition, "/urban/urban_female_population_percentage"),
    
    # Gender
    paste0("input/", edition, "/gender"),
    paste0("input/", edition, "/gender/male_population"),
    paste0("input/", edition, "/gender/female_population"),
    paste0("input/", edition, "/gender/male_population_percentage"),
    paste0("input/", edition, "/gender/female_population_percentage"),
    
    # Other folders
    "output",
    "plot",
    "scripts"
  )
)

# Constants ---------------------------------------------------------------

# Years
start_year <- 1990
end_year   <- 2025
predict_year <- 2027
years <- start_year:predict_year
y_years <- paste0("Y",years)
