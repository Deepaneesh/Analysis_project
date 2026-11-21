# Final data --------------------------------------------------------------

final_data <- data.frame()


# Total population --------------------------------------------------------

actual_total_population <- data_w %>% 
  select(country_name, country_code, year, total_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = total_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Total Population")

estimated_total_population <- data_w %>% 
  select(country_name, country_code, year, f_total_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = f_total_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Total Population")

total_population_with_status <- actual_total_population %>% 
  add_status(
    estimated_data = estimated_total_population,
    id_cols = c("country_name", "country_code", "data"),
    value_cols = y_years
  )

final_data %<>% bind_rows(total_population_with_status)

rm(
  actual_total_population,
  estimated_total_population,
  total_population_with_status
)


# Male population ---------------------------------------------------------

actual_male_population <- data_w %>% 
  select(country_name, country_code, year, male_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = male_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Male Population")

estimated_male_population <- data_w %>% 
  select(country_name, country_code, year, f_male_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = f_male_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Male Population")

male_population_with_status <- actual_male_population %>% 
  add_status(
    estimated_data = estimated_male_population,
    id_cols = c("country_name", "country_code", "data"),
    value_cols = y_years
  )

final_data %<>% bind_rows(male_population_with_status)

rm(
  actual_male_population,
  estimated_male_population,
  male_population_with_status
)


# Female population -------------------------------------------------------

actual_female_population <- data_w %>% 
  select(country_name, country_code, year, female_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = female_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Female Population")

estimated_female_population <- data_w %>% 
  select(country_name, country_code, year, f_female_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = f_female_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Female Population")

female_population_with_status <- actual_female_population %>% 
  add_status(
    estimated_data = estimated_female_population,
    id_cols = c("country_name", "country_code", "data"),
    value_cols = y_years
  )

final_data %<>% bind_rows(female_population_with_status)

rm(
  actual_female_population,
  estimated_female_population,
  female_population_with_status
)


# Male population percentage ----------------------------------------------

actual_male_population_percentage <- data_w %>% 
  select(country_name, country_code, year, male_population_percentage) %>% 
  pivot_wider(
    names_from = year,
    values_from = male_population_percentage,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Male Population Percentage")

estimated_male_population_percentage <- data_w %>% 
  select(
    country_name,
    country_code,
    year,
    f_male_population_percentage
  ) %>% 
  pivot_wider(
    names_from = year,
    values_from = f_male_population_percentage,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Male Population Percentage")

male_population_percentage_with_status <- actual_male_population_percentage %>% 
  add_status(
    estimated_data = estimated_male_population_percentage,
    id_cols = c("country_name", "country_code", "data"),
    value_cols = y_years
  )

final_data %<>% bind_rows(male_population_percentage_with_status)

rm(
  actual_male_population_percentage,
  estimated_male_population_percentage,
  male_population_percentage_with_status
)


# Female population percentage --------------------------------------------

actual_female_population_percentage <- data_w %>% 
  select(country_name, country_code, year, female_population_percentage) %>% 
  pivot_wider(
    names_from = year,
    values_from = female_population_percentage,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Female Population Percentage")

estimated_female_population_percentage <- data_w %>% 
  select(
    country_name,
    country_code,
    year,
    f_female_population_percentage
  ) %>% 
  pivot_wider(
    names_from = year,
    values_from = f_female_population_percentage,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Female Population Percentage")

female_population_percentage_with_status <- actual_female_population_percentage %>% 
  add_status(
    estimated_data = estimated_female_population_percentage,
    id_cols = c("country_name", "country_code", "data"),
    value_cols = y_years
  )

final_data %<>% bind_rows(female_population_percentage_with_status)

rm(
  actual_female_population_percentage,
  estimated_female_population_percentage,
  female_population_percentage_with_status
)


# Rural population --------------------------------------------------------

actual_rural_population <- data_w %>% 
  select(country_name, country_code, year, rural_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = rural_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Rural Population")

estimated_rural_population <- data_w %>% 
  select(country_name, country_code, year, f_rural_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = f_rural_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Rural Population")

rural_population_with_status <- actual_rural_population %>% 
  add_status(
    estimated_data = estimated_rural_population,
    id_cols = c("country_name", "country_code", "data"),
    value_cols = y_years
  )

final_data %<>% bind_rows(rural_population_with_status)

rm(
  actual_rural_population,
  estimated_rural_population,
  rural_population_with_status
)


# Urban population --------------------------------------------------------

actual_urban_population <- data_w %>% 
  select(country_name, country_code, year, urban_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = urban_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Urban Population")

estimated_urban_population <- data_w %>% 
  select(country_name, country_code, year, f_urban_population) %>% 
  pivot_wider(
    names_from = year,
    values_from = f_urban_population,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Urban Population")

urban_population_with_status <- actual_urban_population %>% 
  add_status(
    estimated_data = estimated_urban_population,
    id_cols = c("country_name", "country_code", "data"),
    value_cols = y_years
  )

final_data %<>% bind_rows(urban_population_with_status)

rm(
  actual_urban_population,
  estimated_urban_population,
  urban_population_with_status
)


# Rural population percentage ---------------------------------------------

actual_rural_population_percentage <- data_w %>% 
  select(
    country_name,
    country_code,
    year,
    rural_population_percentage
  ) %>% 
  pivot_wider(
    names_from = year,
    values_from = rural_population_percentage,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Rural Population Percentage")

estimated_rural_population_percentage <- data_w %>% 
  select(
    country_name,
    country_code,
    year,
    f_rural_population_percentage
  ) %>% 
  pivot_wider(
    names_from = year,
    values_from = f_rural_population_percentage,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Rural Population Percentage")

rural_population_percentage_with_status <- actual_rural_population_percentage %>% 
  add_status(
    estimated_data = estimated_rural_population_percentage,
    id_cols = c("country_name", "country_code", "data"),
    value_cols = y_years
  )

final_data %<>% bind_rows(rural_population_percentage_with_status)

rm(
  actual_rural_population_percentage,
  estimated_rural_population_percentage,
  rural_population_percentage_with_status
)


# Urban population percentage ---------------------------------------------

actual_urban_population_percentage <- data_w %>% 
  select(
    country_name,
    country_code,
    year,
    urban_population_percentage
  ) %>% 
  pivot_wider(
    names_from = year,
    values_from = urban_population_percentage,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Urban Population Percentage")

estimated_urban_population_percentage <- data_w %>% 
  select(
    country_name,
    country_code,
    year,
    f_urban_population_percentage
  ) %>% 
  pivot_wider(
    names_from = year,
    values_from = f_urban_population_percentage,
    names_prefix = "Y"
  ) %>% 
  mutate(data = "Urban Population Percentage")

urban_population_percentage_with_status <- actual_urban_population_percentage %>% 
  add_status(
    estimated_data = estimated_urban_population_percentage,
    id_cols = c("country_name", "country_code", "data"),
    value_cols = y_years
  )

final_data %<>% bind_rows(urban_population_percentage_with_status)

rm(
  actual_urban_population_percentage,
  estimated_urban_population_percentage,
  urban_population_percentage_with_status
)


# Saving the final data ---------------------------------------------------

final_data %>% write_csv(na ="",
                         save_with_date(path = 'output',
                                        filename = "population_distribution_data.csv"))

rm(final_data)
