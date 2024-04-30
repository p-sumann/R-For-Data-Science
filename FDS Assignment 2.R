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
  geom_bar(stat = "identity", fill = "#133444") +
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
ggplot(data=auto_data, aes(x= price, y= engine_size))+
  +     geom_point(aes(color=fuel_type, shape=fuel_type))


# hypothesis test: does high horsepower means higher price?
cor.test(auto_data$horsepower,auto_data$price)


# hypothesis test: does lengthier car has higher price?
cor.test(auto_data$length,auto_data$price)

# does engine size impact horse power
cor.test(auto_data$engine_size,auto_data$horsepower)

# does engine size impact compression ratio
cor.test(auto_data$engine_size,auto_data$compression_ratio)












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



