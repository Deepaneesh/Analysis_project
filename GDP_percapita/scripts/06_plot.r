# plot -------------------------------------------------------------------

## Countries

countries <- data %>% pull(country) %>% unique() %>% sort()

pdf(
  save_with_date(path = "plots", filename = "gapminderplot.pdf"),
  width = 14,
  height = 10
)

for (country_for_plot in countries) {
  print(country_for_plot)

  country_data <- data %>% filter(country == country_for_plot)

  # population plot
  pop_plot <- country_data %>%
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(y = f_pop, colour = "Estimated population"),
      linewidth = 1.2
    ) +
    geom_point(aes(y = pop, colour = "Actual population"), size = 2.8) +
    labs(
      x = "YEAR",
      y = "population",
      title = "POPULATION",
      colour = ""
    ) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 10)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c(
        "Estimated population" = "#f6cb0d",
        "Actual population" = "#6d4900"
      )
    )

  # Life Expectation plot

  life_exp_plot <- country_data %>%
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(y = f_life_exp, colour = "Estimated life Expectation"),
      linewidth = 1.2
    ) +
    geom_point(
      aes(y = life_exp, colour = "Actual life Expectation"),
      size = 2.8
    ) +
    labs(
      x = "YEAR",
      y = "life Expectations",
      title = "LIFE EXPECTATIONS",
      colour = ""
    ) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 10)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c(
        "Estimated life Expectation" = "#82fa8e",
        "Actual life Expectation" = "#0a6a11"
      )
    )

  # GDP

  gdp_plot <- country_data %>%
    ggplot() +
    aes(x = year) +
    geom_line(aes(y = f_gdp, colour = "Estimated GDP"), linewidth = 1.2) +
    geom_point(aes(y = gdp, colour = "Actual GDP"), size = 2.8) +
    labs(
      x = "YEAR",
      y = "GDP",
      title = "GDP",
      colour = ""
    ) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 10)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c(
        "Estimated GDP" = "#6bc8fe",
        "Actual GDP" = "#044b75"
      )
    )

  # GDP per capita

  gdp_percap_plot <- country_data %>%
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(y = f_gdp_percap, colour = "Estimated GDP percapita"),
      linewidth = 1.2
    ) +
    geom_point(
      aes(y = gdp_percap, colour = "Actual GDP percapita"),
      size = 2.8
    ) +
    labs(
      x = "YEAR",
      y = "GDP percapita",
      title = "GDP PERCAPITA",
      colour = ""
    ) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 10)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c(
        "Estimated GDP percapita" = "#f884d1",
        "Actual GDP percapita" = "#750448"
      )
    )

  combined_plot <- wrap_plots(
    gdp_percap_plot,
    life_exp_plot,
    pop_plot,
    gdp_plot,
    nrow = 2
  ) +
    plot_annotation(
      title = country_for_plot,
      theme = theme(
        plot.title = element_text(
          size = 18,
          face = "bold",
          hjust = 0.5
        )
      )
    )

  print(combined_plot)
}

dev.off()

# Cleaning the environment
rm(
  countries,
  country_for_plot,
  country_data,
  gdp_plot,
  gdp_percap_plot,
  life_exp_plot,
  pop_plot,
  combined_plot
)
