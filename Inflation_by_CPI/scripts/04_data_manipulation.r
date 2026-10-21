# Data Manipulation ------------------------------------------------------

# Selecting only the required column and renaming into standard way
cpi_data %<>%
  select(date, country_name, country_id, value) %>%
  rename(year = date, cpi = value)

# Completing the years for every country

cpi_data %<>%
  group_by(country_name, country_id) %>%
  arrange(year, .by_group = TRUE) %>%
  complete(year = years) %>%
  ungroup()

# Calculating the Inflation rate

cpi_data %<>%
  group_by(country_name, country_id) %>%
  arrange(year, .by_group = TRUE) %>%
  mutate(inflation = growth_rate(cpi), inflation = inflation * 100) %>%
  ungroup()
