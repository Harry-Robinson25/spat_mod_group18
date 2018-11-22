# Transform Climate data into a cleaned-up array
# The saved object is a 3d array with dimensions  (lat, long, month)
# Each element is a number showing anomaly relative to base temperature
# for that month.   All anomalises less that +/- 1.17 have been removed.

library(raster)
library(ncdf4)
library(tibble)
CLIMATE = stack("data/HadCRUT.median.nc")

# compressed file containing the same data but faster to work with.
saveRDS(CLIMATE, "data/raw_anomaly_stack.rds")

source('functions.R')
c2 <- load_raw_cube()
# make a dataframe with only the non-NA values in 'tidy' format



message(colnames(df))
dims <- dim(c2)
latitudes <- 1:dims[1]  # list of the values
longitudes <- 1:dims[2]
months <- 1:dims[3]
namez <- names(c2)

df <- tibble(
  nmonth=integer(),
  x=numeric(), 
  y=numeric(),
  anomaly=numeric()
)


# for (month in head(months, 2)) {
#   band <- c2[[month]]
#   for (lat in latitudes) {
#     for (long in longitudes) {
#       value <- band[lat, long]
#       if (!is.na(value)) {
#         df <- add_row(df, nmonth=month, nlat=lat, nlong=long, anomaly=value)
#       }
#     }
#   }
# }

for (month in months) {
  band <- c2[[month]]
  # grab all non-NA values into a data frame. We get lat, long and anomaly
  df2 <- as.data.frame(band, na.rm=TRUE, xy=TRUE)
  colnames(df2) <- c("x", "y", "anomaly")
  df2$nmonth <- month;  # add a constant column
  df2 <- df2[,c(4,1,2,3)]
  df <- rbind(df, df2)
}



saveRDS(df, "data/anomaly_dataframe.rds")

message(paste("Built dataframe with ", nrow(df), " rows, saved in data/anomaly_dataframe.rds"))


