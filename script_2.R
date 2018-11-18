library(raster)
library(ncdf4)
library(rasterVis)
library(maptools)
library(maps)
library(tidyr)
library(tibble)

big_enough <- function(x) {
  if (abs(x) > 1.13) {
    return(x)
  } else {
    return(0)
  }
}

CLIMATE = stack("data/HadCRUT.median.nc")

dims <- dim(CLIMATE)
message(paste("dimensions of climate stack: ", dims[1], "latitudes x ", dims[2], "longitudes x ", dims[3], " months"))

aug2018 <- CLIMATE[[2024]]  # data goes up to sep 2018
aug2018[is.na(aug2018[])] <- 0  # replace NA values with zero, the most reasonable assumption and easier to do sums on

message(paste("Mean monthly warming-up in Aug 2018 = ", mean(as.vector(aug2018))))

message("")
message("Building a global average and summary...")


nmonths <- dims[3]


months = numeric()
anomalies = numeric()

for (month in 1:60) {
  ras <- CLIMATE[[month]]  # raster object, like an image
  name <- names(ras)[1]
  months <- append(months, month)
  ras[is.na(ras[])] <- 0  # replace NA with zero
  anomaly <- mean(as.vector(ras)) # forget lat/long, just average all values
  interesting <- big_enough(anomaly)
  anomalies <- append(anomalies, anomaly)
}

# I found better docs on tibbles (a more modern data frame) than I had found on
# R's built-in data frame.  

df <- tibble(months=months, anomalies=anomalies)
plot(df)


saveRDS(df, "data/global_temperature_changes.rds")





