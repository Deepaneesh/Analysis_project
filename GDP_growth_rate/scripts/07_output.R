# Making the Output

# For GDP

original_gdp <- data_w %>%
  select(country_name, country_id, country_code, year, gdp) %>%
  pivot_wider(names_from = year, values_from = gdp, names_prefix = "Y")

write_csv(
  original_gdp,
  save_with_date(path = "output", filename = "original_gdp.csv")
)

estimated_gdp <- data_w %>%
  select(country_name, country_id, country_code, year, f_gdp) %>%
  pivot_wider(names_from = year, values_from = f_gdp, names_prefix = "Y")

write_csv(
  estimated_gdp,
  save_with_date(path = "output", filename = "estimated_gdp.csv")
)

rm(original_gdp, estimated_gdp)


# For population

original_pop <- data_w %>%
  select(country_name, country_id, country_code, year, pop) %>%
  pivot_wider(names_from = year, values_from = pop, names_prefix = "Y")

write_csv(
  original_pop,
  save_with_date(path = "output", filename = "original_pop.csv")
)

estimated_pop <- data_w %>%
  select(country_name, country_id, country_code, year, f_pop) %>%
  pivot_wider(names_from = year, values_from = f_pop, names_prefix = "Y")

write_csv(
  estimated_pop,
  save_with_date(path = "output", filename = "estimated_pop.csv")
)

rm(original_pop, estimated_pop)


# For GDP percapita

original_gdp_percapita <- data_w %>%
  select(country_name, country_id, country_code, year, gdp_per_capita) %>%
  pivot_wider(
    names_from = year,
    values_from = gdp_per_capita,
    names_prefix = "Y"
  )

write_csv(
  original_gdp_percapita,
  save_with_date(path = "output", filename = "original_gdp_percapita.csv")
)

estimated_gdp_percapita <- data_w %>%
  select(country_name, country_id, country_code, year, f_gdp_per_capita) %>%
  pivot_wider(
    names_from = year,
    values_from = f_gdp_per_capita,
    names_prefix = "Y"
  )

write_csv(
  estimated_gdp_percapita,
  save_with_date(path = "output", filename = "estimated_gdp_percapita.csv")
)

rm(original_gdp_percapita, estimated_gdp_percapita)

# Growth rate

pop_gr <- data_w %>%
  select(country_name, country_id, country_code, year, f_pop_gr) %>%
  pivot_wider(names_from = year, values_from = f_pop_gr, names_prefix = "Y")

write_csv(
  pop_gr,
  save_with_date(path = "output", filename = "population_growth_rate.csv")
)

gdp_gr <- data_w %>%
  select(country_name, country_id, country_code, year, f_gdp_gr) %>%
  pivot_wider(names_from = year, values_from = f_gdp_gr, names_prefix = "Y")

write_csv(
  gdp_gr,
  save_with_date(path = "output", filename = "GDP_growth_rate.csv")
)

gdp_percapita_gr <- data_w %>%
  select(country_name, country_id, country_code, year, f_gdp_percap_gr) %>%
  pivot_wider(
    names_from = year,
    values_from = f_gdp_percap_gr,
    names_prefix = "Y"
  )

write_csv(
  gdp_percapita_gr,
  save_with_date(path = "output", filename = "GDP_percapita_growth_rate.csv")
)

rm(gdp_gr, gdp_percapita_gr, pop_gr)
