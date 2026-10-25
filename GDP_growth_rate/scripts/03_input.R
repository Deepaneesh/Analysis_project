# Reading the input files -------------------------------------------------

# GDP file
gdp_data <- read_csv(
  get_latest_data(
    path = paste0("input/", edition, "/GDP")
  )
)

# population data
pop_data <- read_csv(
  get_latest_data(
    path = paste0("input/", edition, "/population")
  )
)
