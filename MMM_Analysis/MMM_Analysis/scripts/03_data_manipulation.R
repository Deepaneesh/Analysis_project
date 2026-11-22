
# Checking the summary of the data -----------------------------------------

mmm_data %>% summary()

sales_data <- mmm_data %>% select(week,sales)

sales_data %<>% 
  mutate(year = year(week),
         month = month(week)) %>% 
  group_by(year,month) %>% 
  summarise(sales = mean(sales)) %>% 
  ungroup()

sales_ts <- ts(sales_data$sales,start = c(2023,1),frequency = 12)

decomposed_data <- sales_ts %>% decompose(type = "additive")

sales_data$trend <- decomposed_data$trend %>% fill_spline(back = T)

sales_data$seasonal <- decomposed_data$seasonal

mmm_data %<>% 
  mutate(month = month(week),
         year = year(week)) %>% 
  left_join(sales_data %>% select(month,year,trend,seasonal),
            by = c("month","year")) %>% 
  select(-c(month,year))


# Cleaning the Environment
rm(decomposed_data,sales_data,sales_ts)

mmm_data %>% select(-week) %>% cor()


# Data transformation -----------------------------------------------------

mmm_data %<>% 
  mutate( # Adstock
         tv_ad = geometric_adstock(tv_spend,theta = theta$tv),
         google_ad = geometric_adstock(google_spend,theta = theta$google),
         meta_ad = geometric_adstock(meta_spend,theta = theta$meta),
         youtube_ad = geometric_adstock(youtube_spend,theta = theta$youtube),
         radio_ad = geometric_adstock(radio_spend,theta = theta$radio),
         # Saturation 
         tv_sat = hill_saturation(tv_ad,k = k$tv,s = shape$tv),
         google_sat = hill_saturation(google_ad, k = k$google, s = shape$google),
         meta_sat = hill_saturation(meta_ad , k = k$meta,s = shape$meta),
         youtube_sat = hill_saturation(youtube_ad , k = k$youtube, s = shape$youtube),
         radio_sat = hill_saturation(radio_ad , k = k$radio, s = shape$radio)
         )

# Cleaning the Environment

rm(shape,k,theta)


t_mmm_data <- mmm_data %>% select(sales,
                                  tv_sat,google_sat,meta_sat,youtube_sat,radio_sat,
                                  price,promotion,distribution,competitor_price,holiday,campaign,
                                  trend,seasonal)

t_mmm_data %>% cor()

