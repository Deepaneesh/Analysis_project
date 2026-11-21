fill_spline_mask <- function(x, back = TRUE) {
  
  n_non_na <- sum(!is.na(x))
  
  if (n_non_na >= 2) {
    x %>% 
      fill_spline_advance(back = back)
  } else {
    x %>% 
      fill_constant()
  }
}
