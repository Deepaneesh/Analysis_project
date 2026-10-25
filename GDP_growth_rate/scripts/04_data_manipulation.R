# Data Manipulation -------------------------------------------------------

gdp_data %<>%
  select(date, country_id, country_name, country_code, value) %>%
  rename(year = date, gdp = value) %>%
  filter(
    (!is.na(country_code) & country_code != "") |
      (!is.na(country_id) & country_id != "")
  )

pop_data %<>%
  select(date, country_name, country_id, country_code, value) %>%
  rename(year = date, pop = value) %>%
  filter(
    (!is.na(country_code) & country_code != "") |
      (!is.na(country_id) & country_id != "")
  )


# Trimming the data -------------------------------------------------------

gdp_data %<>% trimed_data()
pop_data %<>% trimed_data()


# Completing the years ----------------------------------------------------

gdp_data %<>%
  group_by(country_name, country_id, country_code) %>%
  complete(year = years) %>%
  ungroup()

pop_data %<>%
  group_by(country_name, country_id, country_code) %>%
  complete(year = years) %>%
  ungroup()


# Joining the gdp and population data

data_w <- gdp_data %>%
  left_join(
    pop_data,
    by = c("year", "country_name", "country_id", "country_code")
  )

# Cleaning the Environment
rm(gdp_data, pop_data)

# Calculating the GDP per capita

data_w %<>%
  mutate(gdp_per_capita = gdp / pop)
