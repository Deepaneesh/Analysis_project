# All countries

countries <- cpi_data %>% pull(country_name) %>% unique()

# Saving the plots in the PDF format
pdf(
  save_with_date(path = "plots", filename = "cpi_and_inflation.pdf"),
  width = 14,
  height = 10
)

# Looping over country name to generate the plots for each country

for (country in countries) {
  print(country)

  country_data <- cpi_data %>% filter(country_name == country)

  cpi_plot <- country_data %>%
    ggplot(aes(x = year)) +
    geom_line(aes(y = f_cpi, colour = "Estimated_CPI"), linewidth = 1.2) +
    geom_point(aes(y = cpi, colour = "Actual_CPI"), size = 2.5) +
    labs(x = "Year", y = "CPI", title = "Consumer Price Index", colour = "") +
    theme(
      legend.position = "bottom",
      plot.title = element_text(face = "bold", hjust = 0.5, size = 16)
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 10)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c("Estimated_CPI" = "#82b2f5", "Actual_CPI" = "#004872")
    )

  inflation_plot <- country_data %>%
    ggplot(aes(x = year)) +
    geom_line(
      aes(y = f_inflation, colour = "Estimated_inflation"),
      linewidth = 1.2
    ) +
    geom_point(aes(y = inflation, colour = "Actual_inflation"), size = 2.5) +
    labs(x = "Year", y = "INFLATION", title = "INFLATION", colour = "") +
    theme(
      legend.position = "bottom",
      plot.title = element_text(face = "bold", hjust = 0.5, size = 16)
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 10)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c(
        "Estimated_inflation" = "#75f8b7",
        "Actual_inflation" = "#025234"
      )
    )

  combained_plot <- wrap_plots(
    cpi_plot,
    inflation_plot,
    nrow = 2
  ) +
    plot_annotation(
      title = country,
      theme = theme(
        plot.title = element_text(
          size = 18,
          face = "bold",
          hjust = 0.5
        )
      )
    )

  print(combained_plot)
}

dev.off()

rm(countries, country, country_data, cpi_plot, inflation_plot, combained_plot)
