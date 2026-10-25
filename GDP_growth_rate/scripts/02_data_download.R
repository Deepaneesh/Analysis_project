# Downloading the GDP data from World bank --------------------------------

print(paste0(
  paste0(rep("*", 20), collapse = ""),
  " Downloading the gdp data from world bank ",
  paste0(rep("*", 20), collapse = "")
))

gdp_data <- wb_data(
  indicator = "NY.GDP.MKTP.CD",
  start_date = start_year,
  end_date = end_year
)

write_csv(
  gdp_data,
  na = "",
  save_with_date(
    path = paste0("input/", edition, "/GDP"),
    filename = "gdp_data.csv"
  )
)

print(paste0(
  paste0(rep("*", 20), collapse = ""),
  " gdp data downloaded from the world bank and saved in the local ",
  paste0(rep("*", 20), collapse = "")
))
# Cleaning the Environment
rm(gdp_data)


# Downloading the population data from the world bank ---------------------

print(paste0(
  paste0(rep("*", 20), collapse = ""),
  " Downloading the population data from world bank ",
  paste0(rep("*", 20), collapse = "")
))

pop_data <- wb_data(
  indicator = "SP.POP.TOTL",
  start_date = start_year,
  end_date = end_year
)

write_csv(
  pop_data,
  na = "",
  save_with_date(
    path = paste0("input/", edition, "/population"),
    filename = "pop_data.csv"
  )
)

print(paste0(
  paste0(rep("*", 20), collapse = ""),
  " population data downloaded from the world bank and saved in the local ",
  paste0(rep("*", 20), collapse = "")
))
rm(pop_data)
