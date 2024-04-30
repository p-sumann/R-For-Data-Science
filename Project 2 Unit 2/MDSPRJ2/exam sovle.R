# 

library(magrittr)
library(tidyverse)
set.seed(33)
age <- sample(18:99, size = 150, replace = T)
sex <- sample((c("male","female")), size = 150, replace = T)
edu <- sample((c("No Edu","primary","secondary","secondary","beyond")), size = 150, replace = T)
socio <- sample((c("low","middke","high")), size = 150, replace = T)
body <- sample(14:38, size = 150, replace = T)


df <- data.frame(Age=age, Sex=sex, Edu=edu, Socio=socio, Body=body)

barplot(cbind(df$Body,df$Socio))


#create a dataset with following variables: age(18-99 years),
# sex(male/female), educational levels (No education/Primary/Secondary/Beyond secondary),
# socio-economic status(Low, Middle, High) and body mass index (14-38) with 150 random classes of each variable.
# Set seed for reproducibility
set.seed(42)
# Number of samples
num_samples <- 150
# Generate random data for each variable
age <- sample(18:99, num_samples, replace = TRUE)
sex <- sample(c("male", "female"), num_samples, replace = TRUE)
education_levels <- sample(c("No education", "Primary", "Secondary", "Beyond secondary"), num_samples, replace = TRUE)
socio_economic_status <- sample(c("Low", "Middle", "High"), num_samples, replace = TRUE)
body_mass_index <- runif(num_samples, min = 14, max = 38)
# Create a dataframe
data <- data.frame(
  Age = age,
  Sex = sex,
  Educational_Levels = education_levels,
  Socio_Economic_Status = socio_economic_status,
  Body_Mass_Index = body_mass_index
)

# Create the dataset
age <- sample(18:99, 150, replace = TRUE)
sex <- sample(c("Male", "Female"), 150, replace = TRUE)
education <- sample(c("No education", "Primary", "Secondary", "Beyond secondary"), 150, replace = TRUE)
ses <- sample(c("Low", "Middle", "High"), 150, replace = TRUE)
bmi <- sample(14:38, 150, replace = TRUE)

data <- data.frame(age, sex, education, ses, bmi)


barplot(table(data$bim, data$sex), legend = TRUE, 
        main = "Body Mass Index by Sex",
        xlab = "BMI", ylab = "Count")

# Subdivided bar diagram by socio-economic status
barplot(table(data$bmi, data$ses), beside = TRUE, legend = TRUE,
        main = "Body Mass Index by Socio-Economic Status",
        xlab = "BMI", ylab = "Count")




emp.data <- data.frame(
  emp_id = c(1:5),
  emp_name =c("Rick", "Dan", "Michelle", "Ryan", "Gary"),
  salary = c(623.3, 515.2, 611.0, 729.0, 845.25),
  start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05- 11", "2015-03-27"))
)


sqr <- function(x=5) x**2


x <- c(1:100)


df <- ifelse(x<40,1,ifelse(x<60,2,3))


library(rvest)

html <- minimal_html("
  <ol>
    <li>apple &amp; pear</li>
    <li>banana</li>
    <li>pineapple</li>
  </ol>
")


raw <-
  fromJSON((
    "https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD"
  ))


url <- 'https://dataquestio.github.io/web-scraping-pages/simple.html'

raw_html <- read_html(url)

raw_html %>% html_element('p') %>% html_text()

covid_url <- 'https://en.wikipedia.org/wiki/COVID-19_pandemic_in_Nepal'

covid <- read_html(covid_url)

data<- covid %>%  html_table() %>% .[[21]]
names(data) <- paste(names(data), data[1,],sep="_")

names(data)

data <- data[-1,]
data





x <- rnorm(50)
y <- x + rnorm(50)

my_ts <- ts(matrix(x,nrow=500,ncol=1),start = c(1950,1),frequency = 12)

my_dates <- seq(as.Date("2005/1/1"),by="month",length=50)

my_factor <- factor(mtcars$cyl)

sqr <- x^2

par(mfrow= c(2,3))
plot(x,y,main="Scatter")
plot(my_factor, main='Bar')
plot(my_ts, main='TS')
plot(my_dates, main='Trend')


x <- rnorm(500)
y <- rnorm(500)*1.5
plot(x,y, xaxt='n')

axis(1, at=seq(round(min(x)),round(max(x)),by=1))





gd <- as.data.frame(VADeaths)

barplot(gd$'Rural Male', horiz =
          T, names.arg = c("50-54", "55-59", "60-64", "65-69", "70-74"),
        plot(x, y, main = 'Title', col = 'red', pch=16,col.main='green'))

# su









df <- mtcars

range <- 33.9 - 10.4
I = round(sqrt(range))
# need to make 5 class interverl

breaks <- c(10,15,20,25,30)
# or
breaks <- seq(10,35,by=5)

bins <- cut(df$mpg, breaks, labels = c("10-15","15-20","20-25","25-30","30-35"))

bin.table <- table(bins)

barplot(bin.table)


# Load the mtcars dataset
data(mtcars)

# Create the histogram for the "mpg" variable
hist(mtcars$mpg, 
     main = "Histogram of MPG",
     xlab = "Miles per Gallon",
     ylab = "Frequency")

# Locate the mode
mode_bin <- which.max(hist(mtcars$mpg, plot = FALSE)$counts)
mode_value <- hist(mtcars$mpg, plot = FALSE)$breaks[mode_bin]

# Add a vertical line at the mode
abline(v = mode_value, col = "red", lwd = 2)
text(mode_value, max(hist(mtcars$mpg, plot = FALSE)$counts) * 0.9, 
     paste("Mode:", round(mode_value, 2)), 
     col = "red", adj = c(0, 1))


data <- rnorm(1000, mean = 10, sd = 2)

hist(data)
lines(density(data))
density_values <- density(data)$y
max_density <- max(density_values)
mode <- density(data)$x[which.max(density_values)]
abline(v = mode, col = "red")


# Load the mtcars dataset
data(mtcars)

# Calculate the mode, median, and mean of the "mpg" variable
mode_value <- as.numeric(names(which.max(table(mtcars$mpg))))
median_value <- median(mtcars$mpg)
mean_value <- mean(mtcars$mpg)

# Create the histogram with mode, median, and mean
hist(mtcars$mpg, 
     main = "Histogram of MPG",
     xlab = "Miles per Gallon",
     ylab = "Frequency",
     col = "lightblue")

# Add vertical lines for mode, median, and mean
abline(v = mode_value, col = "red", lwd = 2)
abline(v = median_value, col = "green", lwd = 2)
abline(v = mean_value, col = "blue", lwd = 2)

# Add labels for mode, median, and mean
text(mode_value, max(hist(mtcars$mpg, plot = FALSE)$counts) * 0.9, 
     paste("Mode:", round(mode_value, 2)), 
     col = "red", adj = c(0, 1))
text(median_value, max(hist(mtcars$mpg, plot = FALSE)$counts) * 0.8, 
     paste("Median:", round(median_value, 2)), 
     col = "green", adj = c(0, 1))
text(mean_value, max(hist(mtcars$mpg, plot = FALSE)$counts) * 0.7, 
     paste("Mean:", round(mean_value, 2)), 
     col = "blue", adj = c(0, 1))





set.seed(33)
mpg <- sample(c(10:50),size = 100, replace = T)
gear <- sample(c(3,4,5),size=5,replace=T)


hist(mpg)
qqnorm(mpg)
qqline(mpg,col='red',lwd=2)

shapiro.test(mpg)





set.seed(33)

age <- sample(c(18:99),150, replace=T)
sex <- sample(c('male','female'),150, replace=T)
edu <- sample(c('No','P','S','B'),150, replace=T)
ses <- sample(c('L','M','H'),150, replace=T)
bmi <- sample(c(14:38),150, replace=T)


barplot(table(sex,bmi), legend=TRUE, col=c('lightblue','red'))
barplot(table(ses, bmi), legend=TRUE, col=rainbow(3))

barplot(table(sex, age), beside = T, legend =T)
barplot(table(ses,age),beside = T, legend=T, fill=rainbow(3), col=rainbow(3))

boxplot(bmi)

rating <- c(9, 2, 5, 8, 6, 1, 3, 2, 8, 4, 6, 8, 7, 1, 2, 6, 10, 5, 6, 2,4,7)

valid <- length(unique(rating))

# table(rating)