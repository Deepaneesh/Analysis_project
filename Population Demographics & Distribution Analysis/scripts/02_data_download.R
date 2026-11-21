# Population Data ------------------------------------------------------------

# SP.POP.TOTL              -> Population, total
# SP.URB.TOTL              -> Urban population
# SP.RUR.TOTL              -> Rural population
# SP.URB.TOTL.IN.ZS        -> Urban population (% of total population)
# SP.RUR.TOTL.ZS           -> Rural population (% of total population)
# SP.POP.TOTL.MA.IN        -> Population, male
# SP.POP.TOTL.FE.IN        -> Population, female
# SP.POP.TOTL.MA.ZS        -> Population, male (% of total population)
# SP.POP.TOTL.FE.ZS        -> Population, female (% of total population)
# SP.RUR.TOTL.MA.ZS        -> Rural population, male (% of rural population)
# SP.RUR.TOTL.FE.ZS        -> Rural population, female (% of rural population)
# SP.URB.TOTL.MA.ZS        -> Urban population, male (% of urban population)
# SP.URB.TOTL.FE.ZS        -> Urban population, female (% of urban population)


# 1. Total population --------------------------------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Total population data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

total_population_data <- wb_data(
  indicator = "SP.POP.TOTL",
  start_date = start_year,
  end_date = end_year
)

total_population_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/total_population"),
      filename = "total_population_data.csv"
    )
  )

rm(total_population_data)


# 2. Urban population --------------------------------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Urban population data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

urban_population_data <- wb_data(
  indicator = "SP.URB.TOTL",
  start_date = start_year,
  end_date = end_year
)

urban_population_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/urban/urban_population"),
      filename = "urban_population_data.csv"
    )
  )

rm(urban_population_data)


# 3. Rural population --------------------------------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Rural population data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
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


# 4. Urban population (% of total population) --------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Urban population (% of total population) data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

urban_population_percentage_data <- wb_data(
  indicator = "SP.URB.TOTL.IN.ZS",
  start_date = start_year,
  end_date = end_year
)

urban_population_percentage_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/urban/urban_population_percentage"),
      filename = "urban_population_percentage_data.csv"
    )
  )

rm(urban_population_percentage_data)


# 5. Rural population (% of total population) --------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Rural population (% of total population) data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

rural_population_percentage_data <- wb_data(
  indicator = "SP.RUR.TOTL.ZS",
  start_date = start_year,
  end_date = end_year
)

rural_population_percentage_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/rural/rural_population_percentage"),
      filename = "rural_population_percentage_data.csv"
    )
  )

rm(rural_population_percentage_data)


# 6. Male population ---------------------------------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Male population data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

male_population_data <- wb_data(
  indicator = "SP.POP.TOTL.MA.IN",
  start_date = start_year,
  end_date = end_year
)

male_population_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/gender/male_population"),
      filename = "male_population_data.csv"
    )
  )

rm(male_population_data)


# 7. Female population -------------------------------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Female population data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

female_population_data <- wb_data(
  indicator = "SP.POP.TOTL.FE.IN",
  start_date = start_year,
  end_date = end_year
)

female_population_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/gender/female_population"),
      filename = "female_population_data.csv"
    )
  )

rm(female_population_data)


# 8. Male population (% of total population) ---------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Male population (% of total population) data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

male_population_percentage_data <- wb_data(
  indicator = "SP.POP.TOTL.MA.ZS",
  start_date = start_year,
  end_date = end_year
)

male_population_percentage_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/gender/male_population_percentage"),
      filename = "male_population_percentage_data.csv"
    )
  )

rm(male_population_percentage_data)


# 9. Female population (% of total population) --------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Female population (% of total population) data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

female_population_percentage_data <- wb_data(
  indicator = "SP.POP.TOTL.FE.ZS",
  start_date = start_year,
  end_date = end_year
)

female_population_percentage_data %>% 
  write_csv(
    save_with_date(
      path = paste0("input/", edition, "/gender/female_population_percentage"),
      filename = "female_population_percentage_data.csv"
    )
  )

rm(female_population_percentage_data)


# 10. Rural population, male (%) ---------------------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Rural population, male (%) data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

rural_male_population_percentage_data <- wb_data(
  indicator = "SP.RUR.TOTL.MA.ZS",
  start_date = start_year,
  end_date = end_year
)

rural_male_population_percentage_data %>% 
  write_csv(
    save_with_date(
      path = paste0(
        "input/", edition,
        "/rural/rural_male_population_percentage"
      ),
      filename = "rural_male_population_percentage_data.csv"
    )
  )

rm(rural_male_population_percentage_data)


# 11. Rural population, female (%) -------------------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Rural population, female (%) data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

rural_female_population_percentage_data <- wb_data(
  indicator = "SP.RUR.TOTL.FE.ZS",
  start_date = start_year,
  end_date = end_year
)

rural_female_population_percentage_data %>% 
  write_csv(
    save_with_date(
      path = paste0(
        "input/", edition,
        "/rural/rural_female_population_percentage"
      ),
      filename = "rural_female_population_percentage_data.csv"
    )
  )

rm(rural_female_population_percentage_data)


# 12. Urban population, male (%) ---------------------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Urban population, male (%) data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

urban_male_population_percentage_data <- wb_data(
  indicator = "SP.URB.TOTL.MA.ZS",
  start_date = start_year,
  end_date = end_year
)

urban_male_population_percentage_data %>% 
  write_csv(
    save_with_date(
      path = paste0(
        "input/", edition,
        "/urban/urban_male_population_percentage"
      ),
      filename = "urban_male_population_percentage_data.csv"
    )
  )

rm(urban_male_population_percentage_data)


# 13. Urban population, female (%) -------------------------------------------

print(
  paste0(
    paste0(rep("*",20), collapse = ""), " ",
    "Downloading Urban population, female (%) data from World Bank API", " ",
    paste0(rep("*",20), collapse = "")
  )
)

urban_female_population_percentage_data <- wb_data(
  indicator = "SP.URB.TOTL.FE.ZS",
  start_date = start_year,
  end_date = end_year
)

urban_female_population_percentage_data %>% 
  write_csv(
    save_with_date(
      path = paste0(
        "input/", edition,
        "/urban/urban_female_population_percentage"
      ),
      filename = "urban_female_population_percentage_data.csv"
    )
  )

rm(urban_female_population_percentage_data)