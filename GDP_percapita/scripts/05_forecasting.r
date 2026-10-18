# Forecasting ------------------------------------------------------------

## Predicting the missing values by using interpolation and extrapolation method

data %<>%
  group_by(country, continent) %>%
  arrange(year, .by_group = TRUE) %>%
  mutate(
    f_life_exp = fill_spline(life_exp, back = TRUE),
    f_pop = fill_spline(pop, back = TRUE),
    f_gdp = fill_spline(gdp, back = TRUE),
    f_gdp_percap = f_gdp / f_pop
  ) %>%
  ungroup()
