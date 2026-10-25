# Ploting the data in countrywise in the pdf

countries <- data_w %>% pull(country_name) %>% unique() %>% sort()

pdf(
  save_with_date(path = "plot", filename = "GDP_growth_rate.pdf"),
  width = 14,
  height = 10
)


for (country in countries) {
  print(country)
  country_data <- data_w %>% filter(country_name == country)

  # GDP percapita plot

  gdp_percapita_plot <- country_data %>%
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(y = f_gdp_per_capita, colour = "Estimated GDP percapita"),
      linewidth = 1.2
    ) +
    geom_point(
      aes(y = gdp_per_capita, colour = "Actual GDP percapita"),
      size = 2.8
    ) +
    labs(
      x = "year",
      y = "GDP percapita",
      colour = "",
      title = "GDP PER CAPITA"
    ) +
    theme(
      plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 5)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c(
        "Estimated GDP percapita" = "#7CFC7E",
        "Actual GDP percapita" = "#03A609"
      )
    )

  # GDP plot

  gdp_plot <- country_data %>%
    ggplot() +
    aes(x = year) +
    geom_line(aes(y = f_gdp, colour = "Estimated GDP"), linewidth = 1.2) +
    geom_point(aes(y = gdp, colour = "Actual GDP"), size = 2.8) +
    labs(x = "year", y = "GDP", colour = "", title = "GDP") +
    theme(
      plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 5)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c("Estimated GDP" = "#FFBA59", "Actual GDP" = "#C47302")
    )

  # population plot

  pop_plot <- country_data %>%
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(y = f_pop, colour = "Estimated population"),
      linewidth = 1.2
    ) +
    geom_point(aes(y = pop, colour = "Actual population"), size = 2.8) +
    labs(x = "year", y = "population", colour = "", title = "POPULATION") +
    theme(
      plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 5)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c(
        "Estimated population" = "#F09CFF",
        "Actual population" = "#9709AD"
      )
    )

  # GDP growth rate and GDP percapita growth rate plot

  gr_plot <- country_data %>%
    ggplot() +
    aes(x = year) +
    geom_line(aes(y = f_gdp_gr, colour = "GDP growth rate"), linewidth = 1.2) +
    geom_line(
      aes(y = f_gdp_percap_gr, colour = "GDP percapita growth rate"),
      linewidth = 1.2
    ) +
    labs(
      x = "year",
      y = "Growth rate",
      colour = "",
      title = "GDP GROWTH RATE VS GDP PERCAPITA GROWTH RATE"
    ) +
    theme(
      plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, end_year),
      breaks = seq(start_year, end_year, 5)
    ) +
    scale_y_continuous(breaks = pretty_breaks(n = 7)) +
    scale_colour_manual(
      values = c(
        "GDP growth rate" = "#3A03FF",
        "GDP percapita growth rate" = "#FF9203"
      )
    )

  combined_plot <- wrap_plots(
    gdp_percapita_plot,
    gr_plot,
    gdp_plot,
    pop_plot,
    nrow = 2
  ) +
    plot_annotation(
      title = country,
      theme = theme(
        plot.title = element_text(
          size = 20,
          face = "bold",
          hjust = 0.5
        )
      )
    )

  print(combined_plot)
}

dev.off()
# Cleaning the Environment
rm(
  countries,
  country,
  country_data,
  combined_plot,
  gdp_percapita_plot,
  gdp_plot,
  pop_plot,
  gr_plot
)
