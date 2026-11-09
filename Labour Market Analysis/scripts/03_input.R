
# Input data --------------------------------------------------------------

# Labour data

labour_data <- get_latest_data(
                              path = paste0("input/",edition,"/labour_data")
                               ) %>% read.csv()

# Employed data
employed_data <- get_latest_data(
                               path = paste0("input/",edition,"/employed_data")
                                ) %>% read.csv()

# Unemployed data
unemployed_data <- get_latest_data(
                                 path = paste0("input/",edition,"/unemployed_data")
                                   ) %>% read.csv()
