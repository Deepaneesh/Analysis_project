# Reading the Input data -------------------------------------------------

cpi_data <- read_csv(
  get_latest_data(
    path = "input",
    name = "cpi_data"
  )
) %>%
  data.table()
