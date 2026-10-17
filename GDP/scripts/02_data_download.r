# World bank data downloading

print(
  paste0(
    paste(rep("*", 20), collapse = ""),
    " downloading the GDP data from worldbank ",
    paste(rep("*", 20), collapse = "")
  )
)

wb_gdp <- wb_data(
  indicator = "NY.GDP.PCAP.CD",
  start_date = wb_start_year,
  end_date = wb_end_year
)

print(
  paste0(
    paste0(rep("*", 20), collapse = ""),
    " GDP data from Worldbank is downloaded ",
    paste0(rep("*", 20), collapse = "")
  )
)

# Saving the downloaded data in local

write_csv(
  wb_gdp,
  na = "",
  save_with_date(
    path = paste0("input", "/"),
    filename = "wb_gdp.csv"
  )
)

# Cleaning the Environment
rm(wb_gdp)
