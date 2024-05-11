library(tidyverse)
df <- airquality

wind_by_month_mean <- tapply(df[,3], df$Month,FUN = mean)

wind_by_month_sd <- tapply(df[,3], df$Month, FUN = sd)

results <- data.frame("Mean"=wind_by_month_mean, "SD" = wind_by_month_sd)
results$Month <- rownames_to_column(results, var = "Month") %>% select(Month, everything())