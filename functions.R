# utility functions for group 18

load_raw_cube <- function() {
  c <- readRDS("data/raw_anomaly_stack.rds")
  return(c)
}

load_data_frame <- function() {
  c <- readRDS("data/anomaly_dataframe.rds")
}

na_to_zero <- function(band) {
  band[is.na(band[])] <- 0 
  return(band)
}