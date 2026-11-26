
new_data <- iris[22,] %>% clean_names()

new_data

model <- get_latest_data(path = 'model') %>% readRDS()

predict(model,new_data = new_data[,1:4])
