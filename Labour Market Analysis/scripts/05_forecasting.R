
# Forcasting --------------------------------------------------------------


data_w %<>% 
  group_by(country_name) %>% 
  arrange(year) %>% 
  mutate( # filling the missing values using spline interpolation & log and exp to get positive values
         f_employed_percent = employed_percent %>% log() %>% fill_spline(back = T) %>% exp(),
         f_unemployed_percent = unemployed_percent %>% log() %>% fill_spline(back = T) %>% exp(),
         f_others_percent = others_percent %>% log() %>% fill_spline(back = T) %>% exp(),
          # filling the missing values using spline interpolation
         f_labour_count  = labour_count %>% fill_spline(back = T),
          # calculating the total percentage and normalizing the percentages to sum to 100
         f_total = f_employed_percent + f_unemployed_percent + f_others_percent,
         f_employed_percent = 100*f_employed_percent/f_total,
         f_unemployed_percent = 100*f_unemployed_percent/f_total,
         f_others_percent = 100*f_others_percent/f_total,
         # calculating the total percentage to check if the percentages sum to 100
         f_total = f_employed_percent + f_unemployed_percent + f_others_percent,
         # calculating the employed count, unemployed count and others count
         f_employed_count = f_labour_count * f_employed_percent,
         f_unemployed_count = f_labour_count * f_unemployed_percent,
         f_others_count = f_labour_count * f_others_percent
         ) %>% 
  ungroup()
