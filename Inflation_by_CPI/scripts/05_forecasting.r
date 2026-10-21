# Forecasting ------------------------------------------------------------

cpi_data %<>%
  group_by(country_name, country_id) %>%
  arrange(year, .by_group = TRUE) %>%
  mutate(
    f_cpi = cpi %>% log() %>% fill_spline_advance(back = T) %>% exp(),
    f_inflation = f_cpi %>% growth_rate(),
    f_inflation = f_inflation * 100
  ) %>%
  ungroup()
