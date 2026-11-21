countries <- data_w %>%
  pull(country_name) %>%
  unique() %>%
  sort()

population_colours <- c(
  total_actual = "#1F4E79",
  total_estimated = "#9DC3E6",
  rural_actual = "#548235",
  rural_estimated = "#A9D18E",
  urban_actual = "#BF9000",
  urban_estimated = "#FFD966",
  male_actual = "#7030A0",
  male_estimated = "#C9B1E8",
  female_actual = "#C55A11",
  female_estimated = "#F4B183"
)


pdf(
  save_with_date(
    path = "plot",
    filename = "Population Distribution plot.pdf"
  ),
  width = 20,
  height = 14
)


for (country in countries) {
  
  print(country)
  
  plot_data <- data_w %>%
    filter(country_name == country)
  
  
  # -----------------------------
  # Total Population
  # -----------------------------
  
  pop_plot <- plot_data %>% 
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(
        y = f_total_population,
        colour = "Estimated population"
      ),
      linewidth = 1.2
    ) +
    geom_point(
      aes(
        y = total_population,
        colour = "Actual population"
      ),
      size = 2.2
    ) +
    labs(
      title = "Total population",
      x = "Year",
      y = "Count",
      colour = ""
    ) +
    theme(
      plot.title = element_text(
        hjust = 0.5,
        face = "bold",
        size = 14
      ),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, predict_year),
      breaks = seq(start_year, predict_year, 5)
    ) +
    scale_y_continuous(
      breaks = pretty_breaks(n = 10)
    ) +
    scale_colour_manual(
      values = c(
        "Actual population" =
          as.vector(population_colours["total_actual"]),
        "Estimated population" =
          as.vector(population_colours["total_estimated"])
      )
    )
  
  
  # -----------------------------
  # Gender Percentage
  # -----------------------------
  
  pop_gender_per_plot <- plot_data %>% 
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(
        y = f_male_population_percentage,
        colour = "Estimated Male Population %"
      ),
      linewidth = 1.2
    ) +
    geom_point(
      aes(
        y = male_population_percentage,
        colour = "Actual Male Population %"
      ),
      size = 2.2
    ) +
    geom_line(
      aes(
        y = f_female_population_percentage,
        colour = "Estimated Female Population %"
      ),
      linewidth = 1.2
    ) +
    geom_point(
      aes(
        y = female_population_percentage,
        colour = "Actual Female Population %"
      ),
      size = 2.2
    ) +
    labs(
      title = "Population Gender Distribution %",
      x = "Year",
      y = "Percentage",
      colour = ""
    ) +
    theme(
      plot.title = element_text(
        hjust = 0.5,
        face = "bold",
        size = 14
      ),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, predict_year),
      breaks = seq(start_year, predict_year, 5)
    ) +
    scale_y_continuous(
      breaks = pretty_breaks(n = 10)
    ) +
    scale_colour_manual(
      values = c(
        "Estimated Male Population %" =
          as.vector(population_colours["male_estimated"]),
        "Actual Male Population %" =
          as.vector(population_colours["male_actual"]),
        "Estimated Female Population %" =
          as.vector(population_colours["female_estimated"]),
        "Actual Female Population %" =
          as.vector(population_colours["female_actual"])
      )
    )
  
  
  # -----------------------------
  # Gender Population
  # -----------------------------
  
  pop_gender_plot <- plot_data %>% 
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(
        y = f_male_population,
        colour = "Estimated Male Population"
      ),
      linewidth = 1.2
    ) +
    geom_point(
      aes(
        y = male_population,
        colour = "Actual Male Population"
      ),
      size = 2.2
    ) +
    geom_line(
      aes(
        y = f_female_population,
        colour = "Estimated Female Population"
      ),
      linewidth = 1.2
    ) +
    geom_point(
      aes(
        y = female_population,
        colour = "Actual Female Population"
      ),
      size = 2.2
    ) +
    labs(
      title = "Population Gender Distribution",
      x = "Year",
      y = "Count",
      colour = ""
    ) +
    theme(
      plot.title = element_text(
        hjust = 0.5,
        face = "bold",
        size = 14
      ),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, predict_year),
      breaks = seq(start_year, predict_year, 5)
    ) +
    scale_y_continuous(
      breaks = pretty_breaks(n = 10)
    ) +
    scale_colour_manual(
      values = c(
        "Estimated Male Population" =
          as.vector(population_colours["male_estimated"]),
        "Actual Male Population" =
          as.vector(population_colours["male_actual"]),
        "Estimated Female Population" =
          as.vector(population_colours["female_estimated"]),
        "Actual Female Population" =
          as.vector(population_colours["female_actual"])
      )
    )
  
  
  # -----------------------------
  # Region Percentage
  # -----------------------------
  
  pop_region_per_plot <- plot_data %>% 
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(
        y = f_rural_population_percentage,
        colour = "Estimated Rural Population %"
      ),
      linewidth = 1.2
    ) +
    geom_point(
      aes(
        y = rural_population_percentage,
        colour = "Actual Rural Population %"
      ),
      size = 2.2
    ) +
    geom_line(
      aes(
        y = f_urban_population_percentage,
        colour = "Estimated Urban Population %"
      ),
      linewidth = 1.2
    ) +
    geom_point(
      aes(
        y = urban_population_percentage,
        colour = "Actual Urban Population %"
      ),
      size = 2.2
    ) +
    labs(
      title = "Population Region Distribution %",
      x = "Year",
      y = "Percentage",
      colour = ""
    ) +
    theme(
      plot.title = element_text(
        hjust = 0.5,
        face = "bold",
        size = 14
      ),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, predict_year),
      breaks = seq(start_year, predict_year, 5)
    ) +
    scale_y_continuous(
      breaks = pretty_breaks(n = 10)
    ) +
    scale_colour_manual(
      values = c(
        "Estimated Rural Population %" =
          as.vector(population_colours["rural_estimated"]),
        "Actual Rural Population %" =
          as.vector(population_colours["rural_actual"]),
        "Estimated Urban Population %" =
          as.vector(population_colours["urban_estimated"]),
        "Actual Urban Population %" =
          as.vector(population_colours["urban_actual"])
      )
    )
  
  
  # -----------------------------
  # Region Population
  # -----------------------------
  
  pop_region_plot <- plot_data %>% 
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(
        y = f_rural_population,
        colour = "Estimated Rural Population"
      ),
      linewidth = 1.2
    ) +
    geom_point(
      aes(
        y = rural_population,
        colour = "Actual Rural Population"
      ),
      size = 2.2
    ) +
    geom_line(
      aes(
        y = f_urban_population,
        colour = "Estimated Urban Population"
      ),
      linewidth = 1.2
    ) +
    geom_point(
      aes(
        y = urban_population,
        colour = "Actual Urban Population"
      ),
      size = 2.2
    ) +
    labs(
      title = "Population Region Distribution",
      x = "Year",
      y = "Count",
      colour = ""
    ) +
    theme(
      plot.title = element_text(
        hjust = 0.5,
        face = "bold",
        size = 14
      ),
      legend.position = "bottom"
    ) +
    scale_x_continuous(
      limits = c(start_year, predict_year),
      breaks = seq(start_year, predict_year, 5)
    ) +
    scale_y_continuous(
      breaks = pretty_breaks(n = 10)
    ) +
    scale_colour_manual(
      values = c(
        "Estimated Rural Population" =
          as.vector(population_colours["rural_estimated"]),
        "Actual Rural Population" =
          as.vector(population_colours["rural_actual"]),
        "Estimated Urban Population" =
          as.vector(population_colours["urban_estimated"]),
        "Actual Urban Population" =
          as.vector(population_colours["urban_actual"])
      )
    )
  
  
  # -----------------------------
  # Combine plots
  # -----------------------------
  
  gender_plot <- pop_gender_per_plot + pop_gender_plot
  
  region_plot <- pop_region_per_plot + pop_region_plot
  
  combined_plot <- wrap_plots(
    pop_plot,
    gender_plot,
    region_plot,
    nrow = 3
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


# Remove temporary objects
rm(
  country,
  countries,
  plot_data,
  population_colours,
  pop_plot,
  pop_gender_per_plot,
  pop_gender_plot,
  pop_region_per_plot,
  pop_region_plot,
  gender_plot,
  region_plot,
  combined_plot
)
