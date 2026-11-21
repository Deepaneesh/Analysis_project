
data_w %<>%
  filter(!country_name %in% avoiding_countries) %>%
  arrange(country_name, year) %>%
  group_by(country_name) %>%
  group_modify(~ {
    
    country <- unique(.y$country_name)
    start_time <- Sys.time()
    
    message(
      "Processing: ", country,
      " | Started: ", format(start_time, "%H:%M:%S")
    )
    
    result <- .x %>%
      mutate(
        
        # ---------------------------------------------------------------------
        # Total population
        # ---------------------------------------------------------------------
        
        f_total_population = total_population %>% 
          log() %>% 
          fill_spline_mask(back = TRUE) %>% 
          exp(),
        
        
        # ---------------------------------------------------------------------
        # Rural and urban population percentage
        # ---------------------------------------------------------------------
        
        f_rural_population_percentage = rural_population_percentage %>% 
          log() %>% 
          fill_spline_mask(back = TRUE) %>% 
          exp(),
        
        f_urban_population_percentage = urban_population_percentage %>% 
          log() %>% 
          fill_spline_mask(back = TRUE) %>% 
          exp(),
        
        # Temporary adjustment variable
        f_ur_pop_percent_total =
          f_rural_population_percentage +
          f_urban_population_percentage,
        
        f_rural_population_percentage =
          100 * f_rural_population_percentage /
          f_ur_pop_percent_total,
        
        f_urban_population_percentage =
          100 * f_urban_population_percentage /
          f_ur_pop_percent_total,
        
        
        # ---------------------------------------------------------------------
        # Rural and urban population
        # ---------------------------------------------------------------------
        
        f_rural_population =
          f_total_population *
          f_rural_population_percentage / 100,
        
        f_urban_population =
          f_total_population *
          f_urban_population_percentage / 100,
        
        
        # ---------------------------------------------------------------------
        # Total male and female population percentage
        # ---------------------------------------------------------------------
        
        f_female_population_percentage =
          female_population_percentage %>%
          log() %>%
          fill_spline_mask(back = TRUE) %>%
          exp(),
        
        f_male_population_percentage =
          male_population_percentage %>%
          log() %>%
          fill_spline_mask(back = TRUE) %>%
          exp(),
        
        # Temporary adjustment variable
        f_fm_pop_per_total =
          f_female_population_percentage +
          f_male_population_percentage,
        
        f_female_population_percentage =
          100 * f_female_population_percentage /
          f_fm_pop_per_total,
        
        f_male_population_percentage =
          100 * f_male_population_percentage /
          f_fm_pop_per_total,
        
        
        # ---------------------------------------------------------------------
        # Total male and female population
        # ---------------------------------------------------------------------
        
        f_female_population =
          f_total_population *
          f_female_population_percentage / 100,
        
        f_male_population =
          f_total_population *
          f_male_population_percentage / 100,
        
        
        # ---------------------------------------------------------------------
        # Rural gender allocation percentage
        # ---------------------------------------------------------------------
        
        f_rural_female_population_percentage =
          rural_female_population_percentage %>%
          log() %>%
          fill_spline_mask(back = TRUE) %>%
          exp(),
        
        f_rural_male_population_percentage =
          rural_male_population_percentage %>%
          log() %>%
          fill_spline_mask(back = TRUE) %>%
          exp(),
        
        # Temporary adjustment variable
        f_rural_per_total =
          f_rural_female_population_percentage +
          f_rural_male_population_percentage,
        
        f_rural_female_population_percentage =
          f_rural_population_percentage *
          f_rural_female_population_percentage /
          f_rural_per_total,
        
        f_rural_male_population_percentage =
          f_rural_population_percentage *
          f_rural_male_population_percentage /
          f_rural_per_total,
        
        
        # ---------------------------------------------------------------------
        # Rural male and female population
        # ---------------------------------------------------------------------
        
        f_rural_female_population =
          f_rural_population *
          f_rural_female_population_percentage /
          f_rural_population_percentage,
        
        f_rural_male_population =
          f_rural_population *
          f_rural_male_population_percentage /
          f_rural_population_percentage,
        
        
        # ---------------------------------------------------------------------
        # Urban gender allocation percentage
        # ---------------------------------------------------------------------
        
        f_urban_female_population_percentage =
          urban_female_population_percentage %>%
          log() %>%
          fill_spline_mask(back = TRUE) %>%
          exp(),
        
        f_urban_male_population_percentage =
          urban_male_population_percentage %>%
          log() %>%
          fill_spline_mask(back = TRUE) %>%
          exp(),
        
        # Temporary adjustment variable
        f_urban_per_total =
          f_urban_female_population_percentage +
          f_urban_male_population_percentage,
        
        f_urban_female_population_percentage =
          f_urban_population_percentage *
          f_urban_female_population_percentage /
          f_urban_per_total,
        
        f_urban_male_population_percentage =
          f_urban_population_percentage *
          f_urban_male_population_percentage /
          f_urban_per_total,
        
        
        # ---------------------------------------------------------------------
        # Urban male and female population
        # ---------------------------------------------------------------------
        
        f_urban_female_population =
          f_urban_population *
          f_urban_female_population_percentage /
          f_urban_population_percentage,
        
        f_urban_male_population =
          f_urban_population *
          f_urban_male_population_percentage /
          f_urban_population_percentage
      ) %>%
      
      # -----------------------------------------------------------------------
    # Remove temporary adjustment variables
    # -----------------------------------------------------------------------
    
    select(
      -f_ur_pop_percent_total,
      -f_fm_pop_per_total,
      -f_rural_per_total,
      -f_urban_per_total
    )
    
    end_time <- Sys.time()
    
    elapsed <- as.numeric(
      difftime(end_time, start_time, units = "secs")
    )
    
    message(
      "Completed: ", country,
      " | Time: ", round(elapsed, 3), " sec"
    )
    
    result
  }) %>%
  ungroup()


# Selecting only the necessary data

data_w %<>% select(country_name,country_code,year,
                  total_population,f_total_population,
                  rural_population_percentage,urban_population_percentage,
                  f_rural_population_percentage,f_urban_population_percentage,
                  rural_population,urban_population,
                  f_rural_population,f_urban_population,
                  male_population_percentage,female_population_percentage,
                  f_male_population_percentage,f_female_population_percentage,
                  male_population,female_population,
                  f_male_population,f_female_population)
