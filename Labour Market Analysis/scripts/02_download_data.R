# ===========================Indicators ===========================================
# 1. SL.TLF.TOTL.IN       -> Labour force, total
# 2. SL.EMP.TOTL.SP.ZS    -> Employment to population ratio (%)
# 3. SL.UEM.TOTL.ZS       -> Unemployment rate (%)
#=================================================================================

# Downloading the Labour data
print(
    paste0(
       paste0(rep("*",20),collapse = "")," ",
       "Downloading Labour data from World Bank API"," ",
       paste0(rep("*",20),collapse = "")
       )
)

labour_data <- wb_data(
  indicator = "SL.TLF.TOTL.IN",
  start_date = start_year,
  end_date = end_year)

labour_data %>% write_csv(na = "",
                          save_with_date(
                             path = paste0("input/",edition,"/labour_data/"),
                             filename = "labour_data.csv"))

rm(labour_data)

# Downloading the Employed data

print(
  paste0(
    paste0(rep("*",20),collapse = "")," ",
    "Downloading Employed data from World Bank API"," ",
    paste0(rep("*",20),collapse = "")
  )
)

employed_data <- wb_data(
  indicator = "SL.EMP.TOTL.SP.ZS",
  start_date = start_year,
  end_date = end_year)

employed_data %>% write_csv(na = "",
                          save_with_date(
                             path = paste0("input/",edition,"/employed_data/"),
                             filename = "employed_data.csv"))

rm(employed_data)

# unemployed data

print(
  paste0(
    paste0(rep("*",20),collapse = "")," ",
    "Downloading UnEmployed data from World Bank API"," ",
    paste0(rep("*",20),collapse = "")
  )
)

unemployed_data <- wb_data(
  indicator = "SL.UEM.TOTL.ZS",
  start_date = start_year,
  end_date = end_year)

unemployed_data %>% write_csv(na = "",
                            save_with_date(
                              path = paste0("input/",edition,"/unemployed_data/"),
                              filename = "unemployed_data.csv"))

rm(unemployed_data)
