# Selecting the country names and ssorting in a order
countries <- gdp_data %>%
  pull(country_name) %>%
  unique() %>%
  sort()

# Creating the plots to view the bothe actual and estimated values in a pdf format

pdf(
  save_with_date(path = "plots", filename = "GDP.pdf"),
  width = 20,
  height = 12
)

# Looping over every country name

for (country in countries) {
  print(country)
  plot_data <- gdp_data %>%
    filter(country_name == country)

  # Filtering only the required countries

  country_plot <- plot_data %>%
    ggplot() +
    aes(x = year) +
    geom_line(aes(y = f_gdp, colour = "Esimated_value"), linewidth = 1.5) +
    geom_point(aes(y = gdp, colour = "Original_point"), size = 3) +
    labs(
      x = "Year",
      y = "GDP",
      title = paste0(country),
      colour = "Points type"
    ) +
    theme(
      legend.position = "bottom",
      plot.title = element_text(hjust = 0.5, size = 15, face = "bold")
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 10)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c("Original_point" = "#2574a9", "Esimated_value" = "#20fb08")
    )

  print(country_plot)
}
dev.off()

# Cleaning the Environment
rm(plot_data, countries, country, country_plot)
