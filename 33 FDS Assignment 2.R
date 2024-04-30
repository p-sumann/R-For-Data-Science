# Task 1 Automobile data Set

# load the necessary library
library(tidyverse, warn.conflicts = T)


# load the data set
auto_data <- read.csv("automobile.data", header = FALSE, na.strings = "?")


# Basic Data exploration

# Check dimensions
dim(auto_data)

# View first few rows
head(auto_data)

# Check data types
str(auto_data)

# Summary statistics
summary(auto_data)


 # Data Wrangling
# there was no header in the dataset I had to change the column names
# change the names of columns of the auto_data dataframe
colnames(auto_data) <- c("symboling", "normalized_losses", "make", "fuel_type", "aspiration", "num_doors", 
                         "body_style", "drive_wheels", "engine_location", "wheel_base", "length", "width", 
                         "height", "curb_weight", "engine_type", "num_cylinders", "engine_size", "fuel_system", 
                         "bore", "stroke", "compression_ratio", "horsepower", "peak_rpm", "city_mpg", 
                         "highway_mpg", "price")


# Check for missing values
colSums(is.na(auto_data))

# Impute the missing values

auto_data <- auto_data %>% 
  mutate(
    num_doors = ifelse(is.na(num_doors), names(which.max(table(auto_data$num_doors))), num_doors),
    bore = ifelse(is.na(bore), median(bore, na.rm = TRUE), bore),
    stroke = ifelse(is.na(stroke), median(stroke, na.rm = TRUE), stroke),
    horsepower = ifelse(is.na(horsepower), median(horsepower, na.rm = TRUE), horsepower),
    peak_rpm = ifelse(is.na(peak_rpm), median(peak_rpm, na.rm = TRUE), peak_rpm),
    price = ifelse(is.na(price), median(price, na.rm = TRUE), price)
)

# Check for missing values
colSums(is.na(auto_data))

auto_data <- auto_data %>% 
  mutate(normalized_losses = replace_na(normalized_losses, mean(normalized_losses, na.rm = TRUE)))

auto_data$num_doors[is.na(auto_data$num_doors)] <- names(which.max(table(auto_data$num_doors)))

# Exploratory Data Analysis

# relationship between length and width of a automobile
plot(auto_data$length, auto_data$width, main='Lenght vs Width', xlab = 'Length', ylab = 'Width')

# price by make
make_price <- as_tibble(aggregate(price ~ make, auto_data, mean))
make_price$price <- as.integer(make_price$price)

ggplot(make_price, aes(x = make, y = price)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = price), vjust = -0.5) + 
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 40, vjust = 0.5, hjust = 1),
    plot.title = element_text(hjust = 0.5))+
  ylim(0,40000)+
  labs(x = "Make", y = "Mean Price", title = "Make by Price")

# relationship between horsepower by number of cylinders
hp_cyl<- as_tibble(aggregate(horsepower ~ num_cylinders, auto_data, median))
ggplot(hp_cyl, aes(x = horsepower, y = num_cylinders)) +
  geom_bar(stat = "identity", fill = "#996498") +
  geom_text(aes(label = horsepower), vjust = 0.5, hjust = -0.2) + 
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    plot.title = element_text(hjust = 0.5))+
  labs(x = "Horse Power", y = "Number of Cylinders", title = "Horsepower by Number of Cylinders")

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

# relationship between horsepower and price
ggplot(auto_data, aes(x = horsepower, y = price, color = fuel_type)) + 
  geom_point(alpha = 0.5) + 
  labs(x = "Horsepower", y = "Price", color = "Fuel Type") + 
  theme_classic() + 
  theme(panel.grid.major = element_line(size = 0.5, linetype = "dashed", color = "gray"),
        panel.grid.minor = element_line(size = 0.5, linetype = "dashed", color = "gray"),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 14, face = "bold")) + 
  ggtitle("Relationship between Horsepower and Price")

# relationship between engine size and price with respect to fuel type
ggplot(data = auto_data, aes(x = price, y = engine_size)) +
  geom_point(aes(color = fuel_type, shape = fuel_type))


# hypothesis test: does high horsepower means higher price?
cor.test(auto_data$horsepower,auto_data$price)


# hypothesis test: does lengthier car has higher price?
cor.test(auto_data$length,auto_data$price)

# does engine size impact horse power
cor.test(auto_data$engine_size,auto_data$horsepower)

# does engine size impact compression ratio
cor.test(auto_data$engine_size,auto_data$compression_ratio)





# Task 2: Sales Data Munging
library(readr)
library(reshape2)
library(tidyverse)
library(RColorBrewer)


# Load the data
df <- read_csv("Sales.csv")

# Print the shape of the data
(dim(df))
(head(df))


# Check column info of the data
(str(df))
spec(df)

# Check for missing values
colSums(is.na(df))
# print(heatmap(is.na(df), col = "hot"))

# now missing values for invoice
impute_invoice <- function() {
  x <- sample(c(100:999), 10, replace = T)
  y <- sample(c(10:99), 10, replace = T)
  z <- sample(c(100:999), 10, replace = T)
  a <- paste0(x, "-", y, "-", z)
  return (a)
}


df[is.na(df$'Invoice ID'),1] <- impute_invoice()
df

colSums(is.na(df))

# now missing values for unit price
df[is.na(df$'Unit price'),c('Unit price','Total','Tax 5%','Quantity')]
df$'Unit price' <- ifelse(is.na(df$'Unit price'), (df$Total - df$'Tax 5%') / df$Quantity, df$'Unit price')


# missing values for Quantity
head(df[is.na(df$'Quantity'),])
df$'Quantity' <- ifelse(is.na(df$'Quantity'), (df$Total - df$'Tax 5%') %/% df$'Unit price', df$'Quantity')
colSums(is.na(df))

# missing values for Total
df[is.na(df$'Total'),c('Unit price','Total','Tax 5%','Quantity')]
df$'Total' <- ifelse(is.na(df$'Total'), (df$'Unit price' * df$'Quantity') + df$'Tax 5%', df$'Total')
colSums(is.na(df))

# missing values for Tax 5%
df[is.na(df$'Tax 5%'),c('Unit price','Total','Tax 5%','Quantity')]
df$'Tax 5%' <- ifelse(is.na(df$'Tax 5%'), (df$'Total' - (df$'Unit price') * df$'Quantity'), df$'Total')
colSums(is.na(df))

# missing values for Time
df[is.na(df$Time),c('Date', 'Time')]
random_time <- as.character(sample(df$Time,1))
df[is.na(df$Time),'Time'] <- random_time
df$Time <- gsub(":00", "",df$Time)

# missing values for Payment
df[is.na(df$Payment),]
unique(df$Payment)

most_payment <-  names(which.max(table(df$Payment)))
df[is.na(df$Payment),'Payment'] <- most_payment

# missing values for Payment

df[is.na(df$'gross margin percentage'),
   c('Total', 'gross income', 'gross margin percentage')]
df[,c('Total', 'gross income', 'gross margin percentage')]

df[is.na(df$'gross margin percentage'),'gross margin percentage'] <- unique(df$'gross margin percentage')[1]

colSums(is.na(df))

# # Convert the date column to datetime format
df$Date <- as.Date(mdy(df$Date))

# Plot the distribution of different branches


branch_counts <- table(df$Branch)

# Choose a color palette
colors <- brewer.pal(length(branch_counts), "Paired")


explode <- rep(0, length(branch_counts))
explode[which.max(branch_counts)] <- 0.1

ggplot(data.frame(Branch = names(branch_counts), Count = as.numeric(branch_counts)), aes(x = "", y = Count, fill = Branch)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(Count / sum(branch_counts) * 100, 1), "%")), 
            position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = colors) +
  theme_void() +
  theme(legend.position = "right",
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 12)) +
  labs(title = "Branch Distribution")

# Plot the distribution of different cities
ggplot(df, aes(x = City, fill = City)) +
  geom_bar(width = 0.6, color = "white") +
  scale_fill_manual(values = brewer.pal(length(unique(df$City)), "Paired")) +
  labs(title = "Distribution of Different Cities",
       x = "City",
       y = "Count") +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, size = 3.5) +
  ylim(0, 400) +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        axis.title = element_text(size = 12),
        legend.position = "right",
        legend.title = element_blank())

# Plot the distribution of customer types
ggplot(df, aes(x = df$`Customer type`)) + 
  geom_bar(width = 0.5, color = "white", fill='#B33F62') +
  labs(title = "Distribution of customer types", x = "Customer type", y = "Count") + 
  geom_text(stat = "count", aes(label = comma(..count..)), vjust = -0.5, size = 3.5) +
  ylim(0,600) + 
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        axis.title = element_text(size = 12),
        legend.position = "right",
        legend.title = element_blank())



# Plot the distribution of genders
ggplot(data.frame(Gender = names(table(df$Gender)), Count = as.numeric(table(df$Gender))), aes(x = "", y = Count, fill = Gender)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(Count / sum(branch_counts) * 100, 1), "%")), 
            position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = colors) +
  theme_void() +
  theme(legend.position = "right",
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 12)) +
  labs(title = "Gender Distribution")


# Product Line

table(df$`Product line`)

ggplot(df, aes(x = df$`Product line`, fill = df$`Product line`)) +
  geom_bar(width = 0.6, color = "white") +
  scale_fill_manual(values = brewer.pal(length(unique(df$`Product line`)), "Paired")) +
  labs(title = "Distribution of Different Cities",
       x = "City",
       y = "Count") +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, size = 3.5) +
  ylim(0, 200) +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        axis.title = element_text(size = 12),
        legend.position = "right",
        legend.title = element_blank())


# Plot the distribution of unit prices
plot(density(df$`Unit price`,na.rm = T), main = 'Distribution of Unit Price')

# plot scatterplot between total and rating with respect to Branch
ggplot(data=df, aes(x= Total, y= Rating))+
  geom_point(aes(color=Branch, shape=Branch))



# Hypothesis testing: Does gross income increase when total sales increase?
cor.test(df$Total, df$`gross income`)
# it is indeed true, and is statistically significant

# Plot the relationship between total sales and gross income
ggplot(df, aes(x = Total, y = `gross income`)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship between Total and Gross Income",
    x = "Total",
    y = "Gross Income"
  ) +
  theme_classic() +
  xlim(0,1200) + ylim(0,60)

# Plot the relationship between customer type and total sales
ggplot(df, aes(x = Total, color = `Customer type`)) + 
  geom_density() + 
  labs(title = "Relationship between customer type and total sales", x = "Total sales", y = "Density")


# Which branch sales has the highest ratings?
df %>% 
  group_by(Branch) %>% 
  summarise(mean_rating = mean(Rating)) %>% 
  arrange(desc(mean_rating))

# which product is used by different group of Gender

product_usage <- df %>%
  group_by(Gender, `Product line`) %>%
  summarize(Count = n()) %>%
  arrange(desc(Count))


ggplot(product_usage, aes(x = `Product line`, y = Count, fill = Gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Product Usage by Gender",
    x = "Product Line",
    y = "Count",
    fill = "Gender"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.3),
    legend.position = "right"
  )


product_usage_city <- df %>%
  group_by(City, `Product line`) %>%
  summarize(Count = n()) %>%
  arrange(desc(Count))

# Create the plot
ggplot(product_usage_city, aes(x = `Product line`, y = Count, fill = City)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Product Usage by City",
    x = "Product Line",
    y = "Count",
    fill = "City"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.3),
    legend.position = "right"
  ) + ylim(0,80)




# Task 3: Text Mining and Word Cloud (Used both Python and R)

library(tm)
library(Rgraphviz)
library(wordcloud)

text_document <- readLines('himalayan_times.txt')


corpus <- Corpus(VectorSource(text_document))

# inspect(corpus)[1:20]
# 
# corpus <- tm_map(corpus, tolower)
# corpus <- tm_map(corpus, removePunctuation)
# corpus <- tm_map(corpus, removeNumbers)
# corpus <- tm_map(corpus, stemDocument)
# my_stopwords <- c("can","may","used")
# remove stopwords from the corpus
# corpus <- tm_map(corpus, removeWords, my_stopwords)
# tdm <- TermDocumentMatrix(corpus, control = list((wordLenghts=c(1,Inf))))
my_stopwords <- c("can","may","used")
corpus <- tm_map(corpus, removeWords, my_stopwords)
my_tdm <- TermDocumentMatrix(
  corpus,
  control =
    list(
      removePunctuation = TRUE,
      stopwords = TRUE,
      tolower = TRUE,
      stemming = FALSE,
      removeNumbers = TRUE,
      bounds = list(global = c(1, Inf)),
      wordLenghts = c(1,Inf))
)


low_frequent_terms <- findFreqTerms(my_tdm)
low_frequent_terms



library(wordcloud)
mat <- as.matrix(my_tdm)

freq <- mat %>% rowSums() %>% sort(decreasing = T)

df <-
  my_tdm %>%
  as.matrix() %>%
  rowSums() %>%
  sort(decreasing = TRUE) %>%
  head(10) %>%
  enframe(name = "word", value = "counts")
df

# top 10 words and counts using bargraph
library(ggplot2)
ggplot(df, aes(word, counts)) +
  geom_bar(stat = "identity", fill = "#932421") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Top 10 words by counts.") +
  geom_text(aes(label = counts), vjust = -0.5)

# plot word cloud
wordcloud(
  words = names(freq),
  freq = freq,
  random.order = FALSE,
  colors = brewer.pal(8, "Dark2"),
  scale = c(4, 0.5),
  random.color = TRUE,
)



