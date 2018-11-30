# analysis from dataframe
library("tidyverse")

df <- readRDS("data/anomaly_dataframe.rds")

if (!dir.exists('plots')) { 
  dir.create('plots')
  message("created plots directory")
}

by_month <- group_by(df, nmonth)
global <- summarize(by_month, anomaly=mean(anomaly))
saveRDS(global, "data/monthly_global.rds")
ggplot(data=global) + geom_point(mapping=aes(x=nmonth, y=anomaly))
ggsave("plots/anomaly_over_time.png")

t <- filter(df, y > 0)
t <- group_by(t, nmonth)
t <- summarize(t, anomaly=mean(anomaly))
saveRDS(t, "data/monthly_north.rds")
ggplot(data=t) + geom_point(mapping=aes(x=nmonth, y=anomaly))
ggsave("plots/northern_hemisphere_over_time.png")

t <- filter(df, y < 0)  # latitude negative
t <- group_by(t, nmonth)
t <- summarize(t, anomaly=mean(anomaly))
saveRDS(global, "data/monthly_south.rds")
ggplot(data=t) + geom_point(mapping=aes(x=nmonth, y=anomaly))
ggsave("plots/southern_hemisphere_over_time.png")
