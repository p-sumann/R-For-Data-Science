# I. Explain these terms with examples for R:
#   a) Getting multi-way table with array
# b) Creating class intervals of continuous variable
# c) Missingness vs nothingness

# A multi-way table, also known as a contingency table, 
# is used to display the distribution of categorical variables 
# in a multidimensional format

dim1 <- c("A", "B")

data <- array(sample(dim1, 100, replace = TRUE), dim = c(10, 5, 2))
print(table(data))

# Class intervals, also known as bins, are used to group continuous variables into categories for analysis.
# In R, you can create class intervals using the cut() function. 

set.seed(123)
continuous_var <- rnorm(100, mean = 50, sd = 10)

# Create class intervals with equal width
class_intervals <- cut(continuous_var, breaks = seq(from = 0, to = 100, by = 10))
print(class_intervals)

# missingness refers to the absence of a value for a particular observation in a dataset
# Nothingness, on the other hand, refers to the absence of a variable or observation itself

missing <- c("Hello","World", NA)
missing <- c("Hello","World", NULL)

# 2. Explain following concepts with focus on R software:
#   a) Raw data
# b) Data wrangling
# c) Tidy data

 # Raw data refers to the original, unprocessed data that is collected from various sources 
# such as surveys, experiments, or sensors.
# raw_data <- read.csv("path/to/your/file.csv")

# Data wrangling, also known as data cleaning or data preprocessing, is the process of transforming raw data
# into a more usable and structured format for analysis. 
# In R, you can use packages like dplyr, tidyr, and stringr for data wrangling

library(dplyr)

# Data wrangling example
# wrangled_data <- raw_data %>%
#   filter(age > 18) %>%  # Filter observations with age greater than 18
#   select(id, age, gender, income) %>%  # Select specific variables
#   rename(sex = gender) %>%  # Rename a variable
#   mutate(income_category = ifelse(income < 50000, "Low", "High"))

# Tidy data is a standardized way of organizing data in a consistent and structured format, 
# which makes it easier to analyze and visualize. According to Hadley Wickham's definition, tidy data has the following properties:
# Each variable forms a column.
# Each observation forms a row.
# Each type of observational unit forms a table.
library(tidyr)
table3 %>%
  +     pivot_wider(names_from = "country", values_from = "rate")

# 3. Explain the followings with examples for R:
#   a) Reference range based on mean
# b) Reference range based on median
# c) Outliers and extreme values

# Reference range based on mean: A reference range based on the mean is a range of values that includes a 
# certain percentage of the data, typically 95%, centered around the mean.

# data <- rnorm(100, mean = 50, sd = 10)
# reference_range_mean <- mean(data) + c(-1, 1) * qnorm(0.975) * sd(data)
# print(reference_range_mean)

# Reference range based on median: A reference range based on the median is a range of values that 
# includes a certain percentage of the data, typically 95%, centered around the median.

set.seed(123)
data <- rnorm(100, mean = 50, sd = 10)
reference_range_median <- quantile(data, probs = c(0.025, 0.975))
print(reference_range_median)

# Outliers and extreme values are data points that are significantly different from the rest of the data. 

set.seed(123)
data <- rnorm(90, mean = 50, sd = 10)
iqr <- IQR(data)
lower_bound <- quantile(data, probs = 0.25) - 1.5 * iqr
upper_bound <- quantile(data, probs = 0.75) + 1.5 * iqr
outliers <- data[data < lower_bound | data > upper_bound]
print(outliers)

# Explain the following concepts with focus on R software:
#   a) Test of normality
# b) Parametric tests
# c) Residual analysis

# a) Test of normality: A test of normality is a statistical test used to determine whether a 
# sample of data comes from a normally distributed population.
# use Shapiro-Wilk test for small samples, 
# use the Kolmogorov-Smirnov test for large samples
set.seed(123)
data <- rnorm(100, mean = 50, sd = 10)
shapiro.test(data)

# Parametric tests: Parametric tests are statistical tests that assume the data comes
# from a population with a specific distribution, typically the normal distribution.
# Examples of parametric tests include the t-test, ANOVA, and linear regression.

# set.seed(123)
# group1 <- rnorm(50, mean = 50, sd = 10)
# group2 <- rnorm(50, mean = 55, sd = 10)
# 
# # Perform a two-sample t-test
# t.test(group1, group2)


set.seed(123)
x <- rnorm(100, mean = 50, sd = 10)
y <- 2 * x + rnorm(100, mean = 0, sd = 5)

# Fit a linear regression model
model <- lm(y ~ x)