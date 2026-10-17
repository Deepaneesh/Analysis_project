# Selecting the required columns

gdp_data %<>% select(date, country_name, country_code, value)

# Renaming the column

gdp_data %<>% rename(year = date, gdp = value)

# Removing the country without country code

gdp_data %<>% filter(!(is.na(country_code) | country_code == ""))

# Completing the years

gdp_data %<>%
  group_by(country_name, country_code) %>%
  arrange(year, .by_group = TRUE) %>%
  complete(year = years) %>%
  ungroup()
