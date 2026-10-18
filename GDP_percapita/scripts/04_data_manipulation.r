# Data manipulation ------------------------------------------------------

# Cleaning the column names
data %<>% clean_names()

# Completing the years

data %<>%
  group_by(country, continent) %>%
  arrange(year, .by_group = TRUE) %>%
  complete(year = years) %>%
  ungroup()

# Caclulating the GDP

data %<>% mutate(gdp = gdp_percap * pop, year = as.numeric(year))
