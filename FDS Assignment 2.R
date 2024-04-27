library(tidyverse, warn.conflicts = T)

auto_data <- read.csv("automobile.data", header = FALSE, na.strings = "?")


# change the names of columns of the auto_data dataframe

colnames(auto_data) <- c("symboling", "normalized_losses", "make", "fuel_type", "aspiration", "num_doors", 
                         "body_style", "drive_wheels", "engine_location", "wheel_base", "length", "width", 
                         "height", "curb_weight", "engine_type", "num_cylinders", "engine_size", "fuel_system", 
                         "bore", "stroke", "compression_ratio", "horsepower", "peak_rpm", "city_mpg", 
                         "highway_mpg", "price")

# Data exploration

# Check dimensions
dim(auto_data)

# View first few rows
head(auto_data)

# Check data types
str(auto_data)

# Summary statistics
summary(auto_data)

# Check for missing values
colSums(is.na(auto_data))

# Impute the missing values

auto_data <- auto_data %>% 
  mutate(normalized_losses = replace_na(normalized_losses, mean(normalized_losses, na.rm = TRUE)))


# # Mean price by make
make_price <- as_tibble(aggregate(price ~ make, auto_data, mean))
make_price$price <- as.integer(make_price$price)

ggplot(make_price, aes(x = make, y = price)) +
  geom_bar(stat = "identity", fill = "#133444") +
  geom_text(aes(label = price), vjust = -0.5) + 
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 40, vjust = 0.5, hjust = 1),
    plot.title = element_text(hjust = 0.5))+
  ylim(0,40000)+
  labs(x = "Make", y = "Mean Price", title = "Make by Price")

# Median horsepower by number of cylinders
hp_cyl<- as_tibble(aggregate(horsepower ~ num_cylinders, auto_data, median))
ggplot(hp_cyl, aes(x = horsepower, y = num_cylinders)) +
  geom_bar(stat = "identity", fill = "#996498") +
  geom_text(aes(label = horsepower), vjust = 0.5, hjust = -0.2) + 
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    plot.title = element_text(hjust = 0.5))+
  labs(x = "Horse Power", y = "Number of Cylinders", title = "Horsepower by Number of Cylinders")

# 
# # Standard deviation of mpg by fuel type
aggregate(cbind(city_mpg, highway_mpg) ~ fuel_type, auto_data, sd)

aggregate(cbind(city_mpg, highway_mpg) ~ num_cylinders, auto_data, mean)
# horsepower vs number of cylinders
aggregated_data <- as.data.frame(aggregate(horsepower ~ num_cylinders, data = auto_data, FUN = mean))
# aggregated_data$price <- as.integer(aggregated_data$price)
ggplot(data = aggregated_data, aes(x = horsepower, y = num_cylinders)) + 
  geom_bar(stat ='identity',fill = "orange") + 
  theme(axis.text.x = element_text(angle = 40,vjust = 0.5,hjust = 1)) + 
  geom_text(aes(label = horsepower, vjust = 1.5))+ ggtitle("Horsepower by Number of Cylinders") 

# make vs price
make_price <- as.data.frame(aggregate(make ~ price, data = auto_data, FUN = mean))
make_price$price <- as.integer(make_price$price)
ggplot(data = make_price, aes(x = make, y = price)) + 
  geom_bar(stat ='identity',fill = "orange") + 
  theme(axis.text.x = element_text(angle = 40,vjust = 0.5,hjust = 1)) + 
  geom_text(aes(label = price, vjust = 1.5)) + ggtitle("Make by Price") + ylim(0,40000)

# cylinder vs mpg (city, highway)
mpg_summary <- auto_data %>%
  group_by(num_cylinders) %>%
  summarize(mean_city_mpg = round(mean(city_mpg)), mean_highway_mpg = round(mean(highway_mpg)))
mpg_summary

mpg_summary %>%
  pivot_longer(c(mean_city_mpg, mean_highway_mpg), 
               names_to = "mpg_type", 
               values_to = "mean_mpg") %>%
  ggplot(aes(x = num_cylinders, y = mean_mpg, fill = mpg_type)) + 
  geom_col(position = "dodge") + 
  geom_text(aes(label = round(mean_mpg, 1)), position = position_dodge(width = 1), vjust = -0.5) + 
  labs(x = "Number of Cylinders", y = "Mean MPG", fill = "MPG Type") + 
  theme_classic()
