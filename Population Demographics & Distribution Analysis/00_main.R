rm(list = ls());gc()
set.seed(123)
options(scipen = 999)


# Set constants -----------------------------------------------------------

source("scripts/01_constants.R")


# Data download -----------------------------------------------------------

if(download_data){
  source("scripts/02_data_download.R")
} else {
  print(
    paste0(
      paste0(rep("*",20),collapse = "")," ",
      "Data download is disabled. Skipping data download step."," ",
      paste0(rep("*",20),collapse = "")
    )
  )
}
