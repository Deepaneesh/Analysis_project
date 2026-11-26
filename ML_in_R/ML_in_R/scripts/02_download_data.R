
data <- iris

data %>% write_csv(
  na= "",
  file = save_with_date(
    path = "input/",
    filename = "iris.csv"
  )
)

# Cleaning the Environment
rm(data)
