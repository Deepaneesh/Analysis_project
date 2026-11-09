# Labour count ====================================================================================================================

data_for_database <- data.frame()

original_labour_data <- data_w %>% 
                              select(country_id,country_name,country_code,labour_count,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = labour_count,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Labour Count",
                                     product_id   = 1)

estimated_labour_data <- data_w %>% 
                              select(country_id,country_name,country_code,f_labour_count,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = f_labour_count,
                                          names_prefix = "Y") %>% 
                             mutate(product_name = "Labour Count",
                                    product_id   = 1)

labour_data_with_status <- add_status(original_data = original_labour_data,
                                      estimated_data = estimated_labour_data,
                                      id_cols = c("country_id","country_name","country_code","product_name","product_id"),
                                      value_cols = y_years)

# Selecting in the order
labour_data_with_status %<>% 
  select(product_id,product_name,country_id,country_name,country_code,!!y_years,status)

# adding to the data for database
data_for_database %<>% 
  bind_rows(labour_data_with_status)

# Cleaning the Environment
rm(original_labour_data,estimated_labour_data,labour_data_with_status)

# Employed count ===================================================================================================================

original_employed_count_data <- data_w %>% 
                              select(country_id,country_name,country_code,employed_count,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = employed_count,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Employed Count",
                                     product_id   = 2)

estimated_employed_count_data <- data_w %>% 
                              select(country_id,country_name,country_code,f_employed_count,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = f_employed_count,
                                          names_prefix = "Y") %>% 
                             mutate(product_name = "Employed Count",
                                    product_id   = 2)

employed_count_data_with_status <- add_status(original_data = original_employed_count_data,
                                      estimated_data = estimated_employed_count_data,
                                      id_cols = c("country_id","country_name","country_code","product_name","product_id"),
                                      value_cols = y_years)

# Selecting in the order
employed_count_data_with_status %<>% 
  select(product_id,product_name,country_id,country_name,country_code,!!y_years,status)

# saving the data to the final data frame

data_for_database %<>% 
  bind_rows(employed_count_data_with_status) 

# Cleaning the Environment

rm(original_employed_count_data,estimated_employed_count_data,employed_count_data_with_status)


# Unemployed data ---------------------------------------------------------

original_unemployed_count_data <- data_w %>% 
                              select(country_id,country_name,country_code,unemployed_count,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = unemployed_count,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Unemployed Count",
                                     product_id   = 3)

estimated_unemployed_count_data <- data_w %>% 
                              select(country_id,country_name,country_code,f_unemployed_count,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = f_unemployed_count,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Unemployed Count",
                                     product_id   = 3)

# adding the status column to the data frame
unemployed_count_data_with_status <- add_status(original_data = original_unemployed_count_data,
                                      estimated_data = estimated_unemployed_count_data,
                                      id_cols = c("country_id","country_name","country_code","product_name","product_id"),
                                      value_cols = y_years)

# Selecting in the order
unemployed_count_data_with_status %<>% 
  select(product_id,product_name,country_id,country_name,country_code,!!y_years,status)

# adding the data to the final data frame
data_for_database %<>% 
  bind_rows(unemployed_count_data_with_status)

# Cleaning the Environment
rm(original_unemployed_count_data,estimated_unemployed_count_data,unemployed_count_data_with_status)

# others count data ---------------------------------------------------------

original_others_count_data <- data_w %>% 
                              select(country_id,country_name,country_code,others_count,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = others_count,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Others Count",
                                     product_id   = 4)

estimated_others_count_data <- data_w %>% 
                              select(country_id,country_name,country_code,f_others_count,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = f_others_count,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Others Count",
                                     product_id   = 4)

others_count_data_with_status <- add_status(original_data = original_others_count_data,
                                      estimated_data = estimated_others_count_data,
                                      id_cols = c("country_id","country_name","country_code","product_name","product_id"),
                                      value_cols = y_years)

# Selecting in the order
others_count_data_with_status %<>% 
  select(product_id,product_name,country_id,country_name,country_code,!!y_years,status)

# adding the data to the final data frame
data_for_database %<>% 
  bind_rows(others_count_data_with_status)

# Cleaning the Environment
rm(original_others_count_data,estimated_others_count_data,others_count_data_with_status)

# Employed percentage data ---------------------------------------------------------

original_employed_percentage_data <- data_w %>% 
                              select(country_id,country_name,country_code,employed_percent,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = employed_percent,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Employed Percentage",
                                     product_id   = 5)

estimated_employed_percentage_data <- data_w %>% 
                              select(country_id,country_name,country_code,f_employed_percent,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = f_employed_percent,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Employed Percentage",
                                     product_id   = 5)

employed_percentage_data_with_status <- add_status(original_data = original_employed_percentage_data,
                                      estimated_data = estimated_employed_percentage_data,
                                      id_cols = c("country_id","country_name","country_code","product_name","product_id"),
                                      value_cols = y_years)

# Selecting in the order
employed_percentage_data_with_status %<>% 
  select(product_id,product_name,country_id,country_name,country_code,!!y_years,status)

# adding the data to the final data frame
data_for_database %<>%
  bind_rows(employed_percentage_data_with_status)

# Cleaning the Environment
rm(original_employed_percentage_data,
   estimated_employed_percentage_data,
   employed_percentage_data_with_status)


# Unemployed percentage ---------------------------------------------------

original_unemployed_percentage_data <- data_w %>% 
                              select(country_id,country_name,country_code,unemployed_percent,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = unemployed_percent,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Unemployed Percentage",
                                     product_id   = 6)

estimated_unemployed_percentage_data <- data_w %>% 
                              select(country_id,country_name,country_code,f_unemployed_percent,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = f_unemployed_percent,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Unemployed Percentage",
                                     product_id   = 6)

unemployed_percentage_data_with_status <- add_status(original_data = original_unemployed_percentage_data,
                                      estimated_data = estimated_unemployed_percentage_data,
                                      id_cols = c("country_id","country_name","country_code","product_name","product_id"),
                                      value_cols = y_years)

# Selecting in the order
unemployed_percentage_data_with_status %<>% 
  select(product_id,product_name,country_id,country_name,country_code,!!y_years,status)

# adding the data to the final data frame
data_for_database %<>% 
  bind_rows(unemployed_percentage_data_with_status)  

# Cleaning the Environment
rm(original_unemployed_percentage_data,
   estimated_unemployed_percentage_data,
   unemployed_percentage_data_with_status)



# Others percentage -------------------------------------------------------

original_others_percentage_data <- data_w %>% 
                              select(country_id,country_name,country_code,others_percent,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = others_percent,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Others Percentage",
                                     product_id   = 7)

estimated_others_percentage_data <- data_w %>% 
                              select(country_id,country_name,country_code,f_others_percent,year) %>% 
                              pivot_wider(names_from = year,
                                          values_from = f_others_percent,
                                          names_prefix = "Y") %>% 
                              mutate(product_name = "Others Percentage",
                                     product_id   = 7)

others_percentage_data_with_status <- add_status(original_data = original_others_percentage_data,
                                      estimated_data = estimated_others_percentage_data,
                                      id_cols = c("country_id","country_name","country_code","product_name","product_id"),
                                      value_cols = y_years)

# Selecting in the order
others_percentage_data_with_status %<>%
  select(product_id,product_name,country_id,country_name,country_code,!!y_years,status)

# adding the data to the final data frame
data_for_database %<>% 
  bind_rows(others_percentage_data_with_status)

# Cleaning the Environment
rm(original_others_percentage_data,
   estimated_others_percentage_data,
   others_percentage_data_with_status)



# Saving the data ---------------------------------------------------------

data_for_database %>% 
  write_csv(na = "",
            file = save_with_date(path = paste0("output/",edition),
                                  filename = "labour_data.csv"))

rm(data_for_database)
