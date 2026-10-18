# Saving the data in a separate file

# For Life Expectation
life_exp_original_data <- data %>%
  select(country, continent, year, life_exp) %>%
  pivot_wider(names_from = year, values_from = life_exp)

write_csv(
  life_exp_original_data,
  na = "",
  save_with_date(
    path = "output",
    filename = "original_life_expecation.csv"
  )
)

life_exp_estimated_data <- data %>%
  select(country, continent, year, f_life_exp) %>%
  pivot_wider(names_from = year, values_from = f_life_exp)

write_csv(
  life_exp_estimated_data,
  na = "",
  save_with_date(
    path = "output",
    filename = "Estimated_life_expecation.csv"
  )
)

# Cleaning the Environment
rm(life_exp_original_data, life_exp_estimated_data)

# For population

org_pop <- data %>%
  select(country, continent, year, pop) %>%
  pivot_wider(names_from = year, values_from = pop)

write_csv(
  org_pop,
  na = "",
  save_with_date(
    path = "output",
    filename = "Original_population.csv"
  )
)

estimated_pop <- data %>%
  select(country, continent, year, f_pop) %>%
  pivot_wider(names_from = year, values_from = f_pop)

write_csv(
  estimated_pop,
  na = "",
  save_with_date(
    path = "output",
    filename = "Estimated_population.csv"
  )
)

# Cleaning the Environment
rm(org_pop, estimated_pop)

# For GDP

org_gdp <- data %>%
  select(country, continent, year, gdp) %>%
  pivot_wider(names_from = year, values_from = gdp)

write_csv(
  org_gdp,
  na = "",
  save_with_date(
    path = "output",
    filename = "Original_gdp.csv"
  )
)

est_gdp <- data %>%
  select(country, continent, year, f_gdp) %>%
  pivot_wider(names_from = year, values_from = f_gdp)

write_csv(
  est_gdp,
  na = "",
  save_with_date(
    path = "output",
    filename = "Estimated_gdp.csv"
  )
)

# Cleaning the Environment
rm(org_gdp, est_gdp)

# For GDP percapita

org_gdp_percap <- data %>%
  select(country, continent, year, gdp_percap) %>%
  pivot_wider(names_from = year, values_from = gdp_percap)

write_csv(
  org_gdp_percap,
  na = "",
  save_with_date(
    path = "output",
    filename = "Original_gdp_percapita.csv"
  )
)

est_gdp_percap <- data %>%
  select(country, continent, year, f_gdp_percap) %>%
  pivot_wider(names_from = year, values_from = f_gdp_percap)

write_csv(
  est_gdp_percap,
  na = "",
  save_with_date(
    path = "output",
    filename = "Estimated_gdp_percapita.csv"
  )
)

# Cleaning the Environment
rm(org_gdp_percap, est_gdp_percap)
