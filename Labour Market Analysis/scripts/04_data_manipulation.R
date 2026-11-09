
# Renaming the column name and selecting the required columns for each dataset

employed_data %<>% rename(year = date,
                          employed_percent = value) %>%
                   select(year, country_id,
                        country_name,country_code, 
                        employed_percent) %>%
                   mutate(year = as.numeric(year)) %>% 
                   filter(!is.na(country_id) & country_id != "" & 
                         !is.na(country_name) & country_name != "" &
                         !is.na(country_code) & country_code != "") 

unemployed_data %<>% rename(year = date,
                            unemployed_percent = value) %>%
                     select(year, country_id,
                            country_name,country_code, 
                            unemployed_percent) %>%
                     mutate(year = as.numeric(year)) %>% 
                     filter(!is.na(country_id) & country_id != "" & 
                            !is.na(country_name) & country_name != "" &
                            !is.na(country_code) & country_code != "")

labour_data %<>% rename(year = date,
                        labour_count = value) %>%
                 select(year, country_id,
                        country_name,country_code, 
                        labour_count) %>%
                 mutate(year = as.numeric(year)) %>% 
                 filter(!is.na(country_id) & country_id != "" & 
                        !is.na(country_name) & country_name != "" &
                        !is.na(country_code) & country_code != "")

# joining the dat by suing countryname, country id an year

data_w <- labour_data %>% 
              left_join(employed_data, 
                        by = c("country_id", "country_name", "country_code", "year")) %>%
              left_join(unemployed_data, 
                        by = c("country_id", "country_name","country_code", "year"))

# Cleaning the Environment
rm(employed_data,unemployed_data,labour_data)

# Completing the years
data_w %<>% 
  group_by(country_id, country_name, country_code) %>%
  complete(year = years) %>%
  ungroup()

# Calculating the others percentage
# calculate the employed count, unemployed count and others count

data_w %<>% 
    mutate(others_percent = 100 - (employed_percent + unemployed_percent),
           employed_count = labour_count * employed_percent,
           unemployed_count = labour_count * unemployed_percent,
           others_count = labour_count * others_percent)

