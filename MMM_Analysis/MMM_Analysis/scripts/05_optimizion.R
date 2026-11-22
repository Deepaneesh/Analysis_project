lm_coeff <- lm_summary$coefficients

lm_coeff$variable <- rownames(lm_coeff)
rownames(lm_coeff) <- NULL
lm_coeff %<>% select(variable,Estimate)


spend_data <- t_mmm_data %>% 
  summarise(tv_sat = sum(tv_sat),
         google_sat = sum(google_sat),
         youtube_sat = sum(youtube_sat),
         radio_sat = sum(radio_sat)) %>% 
  pivot_longer(cols = c(tv_sat,google_sat,youtube_sat,radio_sat),
               names_to = "sum_var",
               values_to = 'sum_val') %>% as.data.frame()

media_spend <- mmm_data %>% 
                  summarise(tv_sat = sum(tv_spend),
                            google_sat = sum(google_spend),
                            youtube_sat = sum(youtube_spend),
                            radio_sat = sum(radio_spend)) %>% 
                   pivot_longer(cols = c(tv_sat,google_sat,youtube_sat,radio_sat),
                            names_to = "sum_var",
                            values_to = 'media_spend') %>% as.data.frame()

opt_data <- spend_data %>% left_join(lm_coeff,
                         by = c('sum_var' = 'variable'))
opt_data$sales = t_mmm_data %>% pull(sales) %>% sum()

opt_data %<>% 
  left_join(media_spend, by = "sum_var") 

margin <- 0.40

opt_data %>%
  mutate(
    incremental_sales = sum_val * Estimate,
    ROAS = incremental_sales / media_spend,
    ROI =  100*ROAS/sum(ROAS)
  )
margin <- 0.4

opt_data %>%
  mutate(
    incremental_sales = sum_val * Estimate,
    
    incremental_profit =
      incremental_sales * margin - media_spend,
    
    ROAS =
      incremental_sales / media_spend,
    
    profit_ROI =
      incremental_profit / media_spend,
    
    profit_ROI_pct =
      100 * profit_ROI
  )
