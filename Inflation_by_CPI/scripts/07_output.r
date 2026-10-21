# Saving the files in separate Excel files -------------------------------

original_cpi <- cpi_data %>%
  select(country_name, country_id, year, cpi) %>%
  pivot_wider(names_from = year, values_from = cpi, names_prefix = "Y")

write_csv(
  original_cpi,
  save_with_date(path = "output", filename = "Original_cpi.csv")
)

Estimated_cpi <- cpi_data %>%
  select(country_name, country_id, year, f_cpi) %>%
  pivot_wider(names_from = year, values_from = f_cpi, names_prefix = "Y")

write_csv(
  Estimated_cpi,
  save_with_date(path = "output", filename = "Estimated_cpi.csv")
)

# Cleaning the Environment
rm(original_cpi, Estimated_cpi)

original_inflation <- cpi_data %>%
  select(country_name, country_id, year, inflation) %>%
  pivot_wider(names_from = year, values_from = inflation, names_prefix = "Y")

write_csv(
  original_inflation,
  save_with_date(path = "output", filename = "Original_inflation.csv")
)

Estimated_inflation <- cpi_data %>%
  select(country_name, country_id, year, f_inflation) %>%
  pivot_wider(names_from = year, values_from = f_inflation, names_prefix = "Y")

write_csv(
  Estimated_inflation,
  save_with_date(path = "output", filename = "Estimated_inflation.csv")
)

# Cleaning the Environment
rm(original_inflation, Estimated_inflation)
