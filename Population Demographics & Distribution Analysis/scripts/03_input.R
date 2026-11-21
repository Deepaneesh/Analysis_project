# 1. Total population --------------------------------------------------------

total_population_data <- get_latest_data(
  path = paste0("input/", edition, "/total_population")
) %>% 
  read_csv()


# 2. Rural population --------------------------------------------------------

rural_population_data <- get_latest_data(
  path = paste0("input/", edition, "/rural/rural_population")
) %>% 
  read_csv()


# 3. Rural population percentage ---------------------------------------------

rural_population_percentage_data <- get_latest_data(
  path = paste0("input/", edition, "/rural/rural_population_percentage")
) %>% 
  read_csv()


# 4. Rural male population percentage ----------------------------------------

rural_male_population_percentage_data <- get_latest_data(
  path = paste0(
    "input/", edition,
    "/rural/rural_male_population_percentage"
  )
) %>% 
  read_csv()


# 5. Rural female population percentage --------------------------------------

rural_female_population_percentage_data <- get_latest_data(
  path = paste0(
    "input/", edition,
    "/rural/rural_female_population_percentage"
  )
) %>% 
  read_csv()


# 6. Urban population --------------------------------------------------------

urban_population_data <- get_latest_data(
  path = paste0("input/", edition, "/urban/urban_population")
) %>% 
  read_csv()


# 7. Urban population percentage ---------------------------------------------

urban_population_percentage_data <- get_latest_data(
  path = paste0(
    "input/", edition,
    "/urban/urban_population_percentage"
  )
) %>% 
  read_csv()


# 8. Urban male population percentage ----------------------------------------

urban_male_population_percentage_data <- get_latest_data(
  path = paste0(
    "input/", edition,
    "/urban/urban_male_population_percentage"
  )
) %>% 
  read_csv()


# 9. Urban female population percentage --------------------------------------

urban_female_population_percentage_data <- get_latest_data(
  path = paste0(
    "input/", edition,
    "/urban/urban_female_population_percentage"
  )
) %>% 
  read_csv()


# 10. Male population --------------------------------------------------------

male_population_data <- get_latest_data(
  path = paste0("input/", edition, "/gender/male_population")
) %>% 
  read_csv()


# 11. Female population ------------------------------------------------------

female_population_data <- get_latest_data(
  path = paste0("input/", edition, "/gender/female_population")
) %>% 
  read_csv()


# 12. Male population percentage ---------------------------------------------

male_population_percentage_data <- get_latest_data(
  path = paste0(
    "input/", edition,
    "/gender/male_population_percentage"
  )
) %>% 
  read_csv()


# 13. Female population percentage -------------------------------------------

female_population_percentage_data <- get_latest_data(
  path = paste0(
    "input/", edition,
    "/gender/female_population_percentage"
  )
) %>% 
  read_csv()
