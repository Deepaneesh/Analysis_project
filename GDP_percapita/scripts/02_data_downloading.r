# getting the gapminder data from gapminder package ----------------------

data <- gapminder

write_csv(data, save_with_date(path = "input", filename = "gapminder.csv"))

# Cleaning the Environment
rm(data)
