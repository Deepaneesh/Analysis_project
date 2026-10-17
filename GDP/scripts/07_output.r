# original points

original_points <- gdp_data %>%
  select(country_name, country_code, year, gdp) %>%
  pivot_wider(names_from = year, values_from = gdp)

# Values with Estimated points

predicted_value <- gdp_data %>%
  select(country_name, country_code, year, f_gdp) %>%
  pivot_wider(names_from = year, values_from = f_gdp)

# Saving the files

write_csv(
  original_points,
  na = "",
  save_with_date(path = "output", filename = "gdp_original_points.csv")
)

write_csv(
  predicted_value,
  na = "",
  save_with_date(path = "output", filename = "gdp_predicted_values.csv")
)

# Cleaning the Environment
rm(original_points, predicted_value)
