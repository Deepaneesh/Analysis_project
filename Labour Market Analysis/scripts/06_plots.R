
# Getting the countries from the data
countries <- data_w %>% 
               pull(country_name) %>% 
               unique() %>% 
               sort()


# looping over every country to create the plots and saving them in the pdf

start_time <- Sys.time()

cairo_pdf(save_with_date(path = paste0("plot/", edition),
                   filename = "labour_data_plots.pdf"),
    width = 20,
    height = 12)

for(country in countries){
  
  print(country)
  
 country_data <- data_w %>% filter(country_name == country)


  # Colours
 plot_colors <- c(
      "Employed" = "#F8766D",
      "Unemployed" = "#619CFF",
      "Others" = "#00BA38",
      "Labour Count" = "#C77CFF")
 
 # perectage plot
 percentage_chart <- country_data %>% 
   ggplot() +
   aes(x = year) +
   geom_line(aes(y = f_employed_percent, color = "Employed"), linewidth = 1) +
   geom_line(aes(y = f_unemployed_percent, color = "Unemployed"), linewidth = 1) +
   geom_line(aes(y = f_others_percent, color = "Others"), linewidth = 1) +
   geom_point(aes(y = employed_percent, color = "Employed"), size = 2.5) +
   geom_point(aes(y = unemployed_percent, color = "Unemployed"), size = 2.5) +
   geom_point(aes(y = others_percent, color = "Others"), size = 2.5) +
   scale_color_manual(values = plot_colors) +
   scale_y_continuous(
     labels = scales::percent_format(scale = 1),
     breaks = scales::pretty_breaks(n = 10)
   ) +
   scale_x_continuous(breaks = seq(start_year, predict_year, by = 5)) +
   labs(
     x = "Year",
     y = "Percentage",
     title = "percentage of employed, unemployed and others",
     colour = ""
   ) +
   theme(
     plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
     legend.position = "bottom"
   )
 
 
 # Labour plot
 
 labour_plot <- country_data %>% 
   ggplot() +
   aes(x = year) +
   geom_line(aes(y = f_labour_count, color = "Labour Count"), linewidth = 1) +
   geom_point(aes(y = labour_count, color = "Labour Count"), size = 2.5) +
   scale_color_manual(values = plot_colors) +
   scale_y_continuous(
     labels = scales::comma_format(),
     breaks = scales::pretty_breaks(n = 10)
   ) +
   scale_x_continuous(breaks = seq(start_year, predict_year, by = 5)) +
   labs(
     x = "Year",
     y = "Labour Count",
     title = "Labour Counts",
     colour = ""
   ) +
   theme(
     plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
     legend.position = "bottom"
   )
 
 # Count plot
 count_plot <- country_data %>% 
   ggplot() +
   aes(x = year) +
   geom_line(aes(y = f_employed_count, color = "Employed"), linewidth = 1) +
   geom_line(aes(y = f_unemployed_count, color = "Unemployed"), linewidth = 1) +
   geom_line(aes(y = f_others_count, color = "Others"), linewidth = 1) +
   geom_point(aes(y = employed_count, color = "Employed"), size = 2.5) +
   geom_point(aes(y = unemployed_count, color = "Unemployed"), size = 2.5) +
   geom_point(aes(y = others_count, color = "Others"), size = 2.5) +
   scale_color_manual(values = plot_colors) +
   scale_y_continuous(
     labels = scales::comma_format(),
     breaks = scales::pretty_breaks(n = 10)
   ) +
   scale_x_continuous(breaks = seq(start_year, predict_year, by = 5)) +
   labs(
     x = "Year",
     y = "Count",
     title = "Count of employed, unemployed and others",
     colour = ""
   ) +
   theme(
     plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
     legend.position = "bottom"
   )
 
 # Stacked count plot
 stacked_count_plot <- country_data %>%
   select(year, f_employed_count, f_unemployed_count, f_others_count) %>%
   pivot_longer(
     cols = -year,
     names_to = "category",
     values_to = "count"
   ) %>%
   mutate(
     category = factor(
       category,
       levels = c(
         "f_unemployed_count",
         "f_others_count",
         "f_employed_count"
       ),
       labels = c("Unemployed", "Others", "Employed")
     )
   ) %>%
   ggplot(aes(x = year, y = count, fill = category)) +
   geom_col() +
   scale_fill_manual(values = plot_colors) +
   scale_y_continuous(
     labels = scales::comma_format(),
     breaks = scales::pretty_breaks(n = 10)
   ) +
   scale_x_continuous(
     breaks = seq(start_year, predict_year, by = 5)
   ) +
   labs(
     x = "Year",
     y = "Count",
     title = "Count of employed, unemployed and others",
     fill = ""
   ) +
   theme(
     plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
     legend.position = "bottom"
   )
 
  combained_plot <- (labour_plot+count_plot)/(percentage_chart+stacked_count_plot) +
    plot_annotation(
      title =  country,
      theme = theme(plot.title = element_text(hjust = 0.5, size = 20, face = "bold"))
    )
  
  print(combained_plot)
}

dev.off()
# Cleaning the Environment
rm(country_data,country,combained_plot,count_plot,
   labour_plot,percentage_chart,plot_colors,
   stacked_count_plot,countries)

# End time
end_time <- Sys.time()

print(paste0(rep("-", 100), collapse = ""))

print(paste0("Time taken to create the plots: ", 
             round(difftime(end_time, start_time, units = "mins"), 2), " minutes"))

rm(start_time,end_time)
