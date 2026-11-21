
# 1. Total population --------------------------------------------------------

total_population_data %<>%
  rename(
    year = date,
    total_population = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    total_population
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 2. Rural population --------------------------------------------------------

rural_population_data %<>%
  rename(
    year = date,
    rural_population = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    rural_population
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 3. Rural population percentage ---------------------------------------------

rural_population_percentage_data %<>%
  rename(
    year = date,
    rural_population_percentage = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    rural_population_percentage
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 4. Rural male population percentage ----------------------------------------

rural_male_population_percentage_data %<>%
  rename(
    year = date,
    rural_male_population_percentage = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    rural_male_population_percentage
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 5. Rural female population percentage --------------------------------------

rural_female_population_percentage_data %<>%
  rename(
    year = date,
    rural_female_population_percentage = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    rural_female_population_percentage
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 6. Urban population --------------------------------------------------------

urban_population_data %<>%
  rename(
    year = date,
    urban_population = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    urban_population
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 7. Urban population percentage ---------------------------------------------

urban_population_percentage_data %<>%
  rename(
    year = date,
    urban_population_percentage = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    urban_population_percentage
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 8. Urban male population percentage ----------------------------------------

urban_male_population_percentage_data %<>%
  rename(
    year = date,
    urban_male_population_percentage = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    urban_male_population_percentage
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 9. Urban female population percentage --------------------------------------

urban_female_population_percentage_data %<>%
  rename(
    year = date,
    urban_female_population_percentage = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    urban_female_population_percentage
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 10. Male population --------------------------------------------------------

male_population_data %<>%
  rename(
    year = date,
    male_population = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    male_population
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 11. Female population ------------------------------------------------------

female_population_data %<>%
  rename(
    year = date,
    female_population = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    female_population
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 12. Male population percentage ---------------------------------------------

male_population_percentage_data %<>%
  rename(
    year = date,
    male_population_percentage = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    male_population_percentage
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))


# 13. Female population percentage -------------------------------------------

female_population_percentage_data %<>%
  rename(
    year = date,
    female_population_percentage = value
  ) %>%
  select(
    country_name,
    country_code,
    year,
    female_population_percentage
  ) %>%
  filter(!(is.na(country_code) | country_code == ""))

# Joining the data -----------------------------------------------------------

data_w <- total_population_data %>%
  full_join(
    rural_population_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    rural_population_percentage_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    rural_male_population_percentage_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    rural_female_population_percentage_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    urban_population_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    urban_population_percentage_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    urban_male_population_percentage_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    urban_female_population_percentage_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    male_population_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    female_population_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    male_population_percentage_data,
    by = c("country_name", "country_code", "year")
  ) %>%
  full_join(
    female_population_percentage_data,
    by = c("country_name", "country_code", "year")
  )

# Cleaning the Environment
rm(
  total_population_data,
  rural_population_data,
  rural_population_percentage_data,
  rural_male_population_percentage_data,
  rural_female_population_percentage_data,
  urban_population_data,
  urban_population_percentage_data,
  urban_male_population_percentage_data,
  urban_female_population_percentage_data,
  male_population_data,
  female_population_data,
  male_population_percentage_data,
  female_population_percentage_data
)

# Adjusting the values ----------------------------------------------------

data_w %<>% data.table()

# for population data, if any of the three values (total, rural, urban) is missing, we can calculate it from the other two
data_w[is.na(total_population) | total_population == "", total_population := rural_population+urban_population]
data_w[is.na(rural_population) | rural_population == "", rural_population := total_population-urban_population]
data_w[is.na(urban_population) | urban_population == "", urban_population := total_population-rural_population]

# Value adjusting
data_w[
  !is.na(total_population) &
    !is.na(rural_population) &
    !is.na(urban_population) &
    (rural_population + urban_population != total_population),
  
  `:=`(
    rural_population = total_population *
      (rural_population / (rural_population + urban_population)),
    
    urban_population = total_population *
      (urban_population / (rural_population + urban_population))
  )
]

# total population among male and female from total
data_w[is.na(total_population) | total_population == "", total_population := male_population+female_population]
data_w[is.na(male_population) | male_population == "", male_population := total_population-female_population]
data_w[is.na(female_population) | female_population == "", female_population:= total_population-male_population]

# value adjusting
data_w[
  !is.na(total_population) &
    !is.na(male_population) &
    !is.na(female_population) &
    (male_population + female_population != total_population) &
    (male_population + female_population > 0),
  
  `:=`(
    male_population = total_population *
      (male_population / (male_population + female_population)),
    
    female_population = total_population *
      (female_population / (male_population + female_population))
  )
]

# Rural + Urban population percentage ----------------------------------------

# Fill missing values ---------------------------------------------------------

data_w[
  is.na(rural_population_percentage) |
    rural_population_percentage == "",
  rural_population_percentage := 100 - urban_population_percentage
]

data_w[
  is.na(urban_population_percentage) |
    urban_population_percentage == "",
  urban_population_percentage := 100 - rural_population_percentage
]


# Redistribute when total is not 100 -----------------------------------------

data_w[
  !is.na(rural_population_percentage) &
    !is.na(urban_population_percentage) &
    (rural_population_percentage + urban_population_percentage != 100) &
    (rural_population_percentage + urban_population_percentage > 0),
  
  `:=`(
    rural_population_percentage =
      100 * (
        rural_population_percentage /
          (rural_population_percentage + urban_population_percentage)
      ),
    
    urban_population_percentage =
      100 * (
        urban_population_percentage /
          (rural_population_percentage + urban_population_percentage)
      )
  )
]

# Male + Female population percentage ----------------------------------------


# Fill missing values ---------------------------------------------------------

data_w[
  is.na(male_population_percentage) |
    male_population_percentage == "",
  male_population_percentage := 100 - female_population_percentage
]

data_w[
  is.na(female_population_percentage) |
    female_population_percentage == "",
  female_population_percentage := 100 - male_population_percentage
]


# Redistribute when total is not 100 -----------------------------------------

data_w[
  !is.na(male_population_percentage) &
    !is.na(female_population_percentage) &
    (male_population_percentage + female_population_percentage != 100) &
    (male_population_percentage + female_population_percentage > 0),
  
  `:=`(
    male_population_percentage =
      100 * (
        male_population_percentage /
          (male_population_percentage + female_population_percentage)
      ),
    
    female_population_percentage =
      100 * (
        female_population_percentage /
          (male_population_percentage + female_population_percentage)
      )
  )
]

# Rural male + female population percentage ----------------------------------------

# Fill missing values -------------------------------------------------------

data_w[
  is.na(rural_male_population_percentage) |
    rural_male_population_percentage == "",
  rural_male_population_percentage :=
    rural_population_percentage - rural_female_population_percentage
]

data_w[
  is.na(rural_female_population_percentage) |
    rural_female_population_percentage == "",
  rural_female_population_percentage :=
    rural_population_percentage - rural_male_population_percentage
]

# Redistribute when total is not equal to rural population percentage -------

data_w[
  !is.na(rural_population_percentage) &
    !is.na(rural_male_population_percentage) &
    !is.na(rural_female_population_percentage) &
    (
      rural_male_population_percentage +
        rural_female_population_percentage !=
        rural_population_percentage
    ) &
    (
      rural_male_population_percentage +
        rural_female_population_percentage > 0
    ),
  
  `:=`(
    rural_male_population_percentage =
      rural_population_percentage *
      (
        rural_male_population_percentage /
          (
            rural_male_population_percentage +
              rural_female_population_percentage
          )
      ),
    
    rural_female_population_percentage =
      rural_population_percentage *
      (
        rural_female_population_percentage /
          (
            rural_male_population_percentage +
              rural_female_population_percentage
          )
      )
  )
]

# Urban male + female population percentage ----------------------------------------

# Fill missing values -------------------------------------------------------

data_w[
  is.na(urban_male_population_percentage) |
    urban_male_population_percentage == "",
  urban_male_population_percentage :=
    urban_population_percentage - urban_female_population_percentage
]

data_w[
  is.na(urban_female_population_percentage) |
    urban_female_population_percentage == "",
  urban_female_population_percentage :=
    urban_population_percentage - urban_male_population_percentage
]

# Redistribute when total is not equal to urban population percentage -------

data_w[
  !is.na(urban_population_percentage) &
    !is.na(urban_male_population_percentage) &
    !is.na(urban_female_population_percentage) &
    (
      urban_male_population_percentage +
        urban_female_population_percentage !=
        urban_population_percentage
    ) &
    (
      urban_male_population_percentage +
        urban_female_population_percentage > 0
    ),
  
  `:=`(
    urban_male_population_percentage =
      urban_population_percentage *
      (
        urban_male_population_percentage /
          (
            urban_male_population_percentage +
              urban_female_population_percentage
          )
      ),
    
    urban_female_population_percentage =
      urban_population_percentage *
      (
        urban_female_population_percentage /
          (
            urban_male_population_percentage +
              urban_female_population_percentage
          )
      )
  )
]


# Completing the data -----------------------------------------------------

data_w %<>% group_by(country_name, country_code) %>%
  complete(year = years) %>%
  ungroup() %>%
  arrange(country_name, country_code, year)




# Filter only the available countries -------------------------------------


list_of_countries <- data_w %>% group_by(country_name) %>% 
  summarise(count = n(), 
            non_na_pop_count = sum(!is.na(total_population))) %>% 
  filter(non_na_pop_count >1) %>% 
  pull(country_name)

data_w %<>% filter(country_name %in% list_of_countries)
rm(list_of_countries)
