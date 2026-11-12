# SP.POP.TOTL              -> Population, total
# SP.URB.TOTL              -> Urban population
# SP.RUR.TOTL              -> Rural population
# SP.URB.TOTL.IN.ZS        -> Urban population (% of total population)
# SP.RUR.TOTL.ZS           -> Rural population (% of total population)
# SP.POP.TOTL.MA.IN        -> Population, male
# SP.POP.TOTL.FE.IN        -> Population, female
# SP.POP.TOTL.MA.ZS        -> Population, male (% of total population)
# SP.POP.TOTL.FE.ZS        -> Population, female (% of total population)
# SP.RUR.TOTL.MA.ZS        -> Rural population, male (% of total population)
# SP.RUR.TOTL.FE.ZS        -> Rural population, female (% of total population)
# SP.URB.TOTL.MA.ZS        -> Urban population, male (% of total population)
# SP.URB.TOTL.FE.ZS        -> Urban population, female (% of total population)


# Total population --------------------------------------------------------

print(
  paste0(
    paste0(rep("*",20),collapse = "")," ",
    "Downloading Total population data from World Bank API"," ",
    paste0(rep("*",20),collapse = "")
  )
)

total_population_data <- wb_data(
  indicator = "SP.POP.TOTL",
  start_date = start_year,
  end_date = end_year)

total_population_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/total_population"),
      filename = "total_population_data.csv"
    )
  )

rm(total_population_data)

#  Rural population --------------------------------------------------


print(
  paste0(
    paste0(rep("*",20),collapse = "")," ",
    "Downloading Rural population data from World Bank API"," ",
    paste0(rep("*",20),collapse = "")
  )
)

rural_population_data <- wb_data(
  indicator = "SP.RUR.TOTL",
  start_date = start_year,
  end_date = end_year
)

rural_population_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/rural/rural_population"),
      filename = "rural_population_data.csv"
    )
  )

rm(rural_population_data)

