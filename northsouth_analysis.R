# it seems warmong of northern hemisphere is faster than southern, recently.
# is this significant?
# Asked someone with a PhD in stats and 30 years analysing time series in the
# City.  He recommended the Augmented Dickey Fuller test which tests the 'stationarity'
# of the mean of a time series
install.packages("tseries")
library("tseries")
dfnorth = readRDS("data/monthly_north.rds")
plot(dfnorth)
dfsouth = readRDS("data/monthly_south.rds")
plot(dfsouth)
northsouth = dfnorth$anomaly - dfsouth$anomaly
adf.test(northsouth)
plot(northsouth)
