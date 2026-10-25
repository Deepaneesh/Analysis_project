# Forecasting -------------------------------------------------------------

data_w %<>%
       group_by(country_name) %>%
       arrange(year, .by_group = TRUE) %>%
       mutate(
              f_gdp = gdp %>%
                     log() %>%
                     fill_spline_advance(back = F, outside = F, n = 5) %>%
                     exp(),
              f_pop = pop %>%
                     log() %>%
                     fill_spline_advance(back = T, n = 5) %>%
                     exp(),
              f_pop_gr = growth_rate(f_pop),
              f_gdp = apply_growth_rate_tail(
                     f_gdp,
                     f_pop_gr,
                     left_tail = T,
                     right_tail = F
              ),
              f_gdp_gr = growth_rate(f_gdp),
              f_gdp_gr = f_gdp_gr %>% fill_spline_advance(n = 5),
              f_gdp = apply_growth_rate_tail(
                     f_gdp,
                     f_gdp_gr,
                     left_tail = F,
                     right_tail = T
              ),
              f_gdp_per_capita = f_gdp / f_pop,
              f_gdp_percap_gr = growth_rate(f_gdp_per_capita)
       ) %>%
       ungroup()
