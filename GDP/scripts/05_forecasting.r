# Forecasting by using the spline filling inside and outside

gdp_data %<>%
  group_by(country_name, country_code) %>%
  arrange(year, .by_group = TRUE) %>%
  mutate(
    f_gdp = fill_spline_advance(gdp, back = T)
  ) %>%
  ungroup()
