# Downloading the CPI data from world bank -------------------------------

cpi_data <- wb_data(
  indicator = "FP.CPI.TOTL",
  start_date = start_year,
  end_date = end_year
)

# Saving the Downloaded data

write_csv(
  cpi_data,
  na = "",
  save_with_date(path = "input", filename = "cpi_data.csv")
)

# Cleaning the Environment
rm(cpi_data)
