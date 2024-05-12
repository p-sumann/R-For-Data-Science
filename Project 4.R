# library(tidyverse)
df <- airquality

wind_by_month_mean <- tapply(df[,3], df$Month,FUN = mean)

wind_by_month_sd <- tapply(df[,3], df$Month, FUN = sd)

results <- data.frame("Mean"=wind_by_month_mean, "SD" = wind_by_month_sd)
results$Month <- row.names(results)
row.names(results) <- NULL

results %>% select(Month, everything())

for (i in unique(airquality$Month)) {
  print(paste0("Month ", i, ":"))
  print(shapiro.test(airquality$Wind[airquality$Month == i]))
}

for (i in unique(airquality$Month)) {
  print(paste0("Month ", i, ":"))
  hist(airquality$Wind[airquality$Month == i], main = "Histogram", ylab = "")
}

for (i in unique(airquality$Month)) {
  print(paste0("Month ", i, ":"))
  plot(density(airquality$Wind[airquality$Month == i]))
}

# data is normal



