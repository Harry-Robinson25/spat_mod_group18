# Transform Climate data into a cleaned-up array
# The saved object is a 3d array with dimensions  (lat, long, month)
# Each element is a number showing anomaly relative to base temperature
# for that month.   All anomalises less that +/- 1.17 have been removed.

library(raster)
library(ncdf4)

big_enough <- function(x) {
  if (abs(x) > 1.17) {
    return(x)
  } else {
    return(0)
  }
}

CLIMATE = stack("data/HadCRUT.median.nc")
dims <- dim(CLIMATE)
m <- as.matrix(CLIMATE)
v <- as.array(m)  # make it into one long array, easier to loop over

v[is.na(v)] <- 0  # replace all NA values with 0
v <- lapply(v, big_enough)  # only keep significant local anomalies
dim(v) <- dims
saveRDS(v, "data/clean_anomaly_cube.rds")
message(paste("Saved 3d array of clean data with dimensions", dims))






