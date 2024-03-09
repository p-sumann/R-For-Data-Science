# Session 7

# Reading data in R/R Studio: JSON
library("rjson")
data <- fromJSON(file = "jason_data.json")
# jason_data.json must be in the current working directory of R
print(data)
# covert to data frame:
jason_data_frame <- as.data.frame(data)
print(jason_data_frame)

# summary of jason_data_frame
summary(jason_data_frame)

# histogram of salary of jason data frame
# since salary was of character so hist was not produced, so I converted it to integer.
jason_data_frame$Salary <- as.integer(jason_data_frame$Salary)
hist(jason_data_frame$Salary)


# average salary by department
aggregate(Salary ~ Dept, data = jason_data_frame, FUN = max)

# also using dplyr package
library(dplyr)
library(magrittr)
avg_by_dept <-
  jason_data_frame %>% group_by(Dept) %>% summarise(avg_salart = mean(Salary))

# frequency distribution of all variables
# since tables only shows the frequency distribution of factors, table on numerical or integer value is bad practice.
table(jason_data_frame$Dept)


# Reading JSON file from URL: Web API 

library(jsonlite)

raw <-
  fromJSON((
    "https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD"
  ))

food_market <- raw[['data']] 
str(food_market) 
head(food_market)

names <- food_market[,14]
head(names)
table(names)

table(v19)

table(food_market$V19)

table(food_market[,19])

# Web scrapping in R: A Simple (barebones) Example
# https://www.dataquest.io/blog/web-scraping-in-r-rvest

# The recommended package for web scrapping in R is “rvest
# using html
library(rvest)
simple <- read_html('https://dataquestio.github.io/web-scraping-pages/simple.html')

simple %>% html_nodes('p') %>% html_text()


# wikipedia nepal covid 19 
wiki_link <- "https://en.wikipedia.org/wiki/COVID-19_pandemic_in_Nepal"
wiki_page <- read_html(wiki_link)
str(wiki_page)

wiki_page %>% html_nodes("table")

covid_table <- wiki_page %>% html_elements('.COVID-19_pandemic_data_Nepal_medical_cases') %>% html_node('table') %>% html_table()
covid_table <- covid_table[[1]]



names(covid_table) <- paste(names(covid_table), covid_table[1,], sep = "_")
names(covid_table)
covid_table <- covid_table[-1,]

str(covid_table)

colnames(covid_table) <- c(
  "Date",
  "Confirmed_Cases_Total",
  "Confirmed_Cases_New",
  "Confirmed_Cases_Active",
  "Recoveries_Total",
  "Recoveries_New",
  "Deaths_Total",
  "Deaths_New",
  "PCR_Total",
  "PCR_New",
  "TPR",
  "RR",
  "CFR",
  "Ref"
)

# another way to do same thing 

names(covid_table)[names(covid_table)=='Date_Date'] = 'Date'
names(covid_table)[names(covid_table)=='Confirmed cases_Total'] = 'Confirmed_Cases_Total'
names(covid_table)[names(covid_table)=='Confirmed cases_New'] = 'Confirmed_Cases_New'
names(covid_table)[names(covid_table)=='Confirmed cases_Active'] = 'Confirmed_Cases_Active'
names(covid_table)[names(covid_table)=='Recoveries_Total'] = 'Recoveries_Total'
names(covid_table)[names(covid_table)=='Recoveries_New'] = 'Recoveries_New'
names(covid_table)[names(covid_table)=='Deaths_Total'] = 'Deaths_Total'
names(covid_table)[names(covid_table)=='Deaths_New'] = 'Deaths_New'
names(covid_table)[names(covid_table)=='RT-PCR tests_Total'] = 'PCR_Total'
names(covid_table)[names(covid_table)=='RT-PCR tests_New'] = 'PCR_New'
names(covid_table)[names(covid_table)=='TPR_TPR'] = 'TPR'
names(covid_table)[names(covid_table)=='RR_RR'] = 'RR'
names(covid_table)[names(covid_table)=='CFR_CFR'] = 'CFR'
names(covid_table)[names(covid_table)=='Ref._Ref.'] = 'Ref'


# data wrangling part iii

# removing "+" and "%" from the variables

covid_table$Confirmed_Cases_New <- gsub('[+]', '', covid_table$Confirmed_Cases_New)
covid_table$Recoveries_New <- gsub('[+]', '', covid_table$Recoveries_New)
covid_table$Deaths_New <- gsub('[+]', '', covid_table$Deaths_New)
covid_table$PCR_New <- gsub('[+]', '', covid_table$PCR_New)

covid_table$TPR <- gsub('[%]', '', covid_table$TPR)
covid_table$RR <- gsub('[%]', '', covid_table$RR)
covid_table$CFR <- gsub('[%]', '', covid_table$CFR)

# removing "," from the variables
covid_table$Confirmed_Cases_Total <- gsub('[,]', '', covid_table$Confirmed_Cases_Total)
covid_table$Confirmed_Cases_New <- gsub('[,]', '', covid_table$Confirmed_Cases_New)
covid_table$Confirmed_Cases_Active <- gsub('[,]', '', covid_table$Confirmed_Cases_Active)
covid_table$Recoveries_Total <- gsub('[,]', '', covid_table$Recoveries_Total)
covid_table$Recoveries_New <- gsub('[,]', '', covid_table$Recoveries_New)

covid_table$Deaths_Total <- gsub('[,]', '', covid_table$Deaths_Total)
covid_table$Deaths_New <- gsub('[,]', '', covid_table$Deaths_New)
covid_table$PCR_Total <- gsub('[,]', '', covid_table$PCR_Total)
covid_table$PCR_New <- gsub('[,]', '', covid_table$PCR_New)

covid_table$TPR <- gsub('[,]', '', covid_table$TPR)
covid_table$RR <- gsub('[,]', '', covid_table$RR)
covid_table$CFR <- gsub('[,]', '', covid_table$CFR)


# converting  chr variables as 1

covid_table$Confirmed_Cases_Total <-
  as.integer(covid_table$Confirmed_Cases_Total)
covid_table$Confirmed_Cases_New <-
  as.integer(covid_table$Confirmed_Cases_New)
covid_table$Confirmed_Cases_Active <-
  as.integer(covid_table$Confirmed_Cases_Active)
covid_table$Recoveries_Total <-
  as.integer(covid_table$Recoveries_Total)
covid_table$Recoveries_New <-
  as.integer(covid_table$Recoveries_New)

# converting chr variable as integer

covid_table$Deaths_Total <- as.integer(covid_table$Deaths_Total)
covid_table$Deaths_New <- as.integer(covid_table$Deaths_New)
covid_table$PCR_Total <- as.integer(covid_table$PCR_Total)
covid_table$PCR_New <- as.integer(covid_table$PCR_New)

#Data wrangling: Part IV
#Converting “chr” variables as numbers 
covid_table$TPR <- as.numeric(covid_table$TPR)
covid_table$RR <- as.numeric(covid_table$RR)
covid_table$CFR <- as.numeric(covid_table$CFR)



start_date_2020 <- '2020-01-23'
end_date_2020 <- '2020-12-31'
final <- ifelse(1:nrow(covid_table) <= diff, 2020, 2021)
# using base R date time functions
diff <- as.numeric(difftime(end_date_2020,start_date_2020,units = 'days')) + 1
formatted_date <- as.Date(covid_table$Date,format = "%d %b")
formatted_date <- format(formatted_date, '-%m-%d')
final_converted_date <- paste0(final,formatted_date)
class(final_converted_date)

# using lubridate
diff <- (ymd(start) %--% ymd(end)) %/% days(1) + 1
final <- ifelse(1:nrow(covid_table) <= diff, 2020, 2021)
formatted_date <- ymd(as.Date(covid_table$Date,format = "%d %b"))
final_converted_date <- make_date(year = final,month = month(formatted_date), day = day(formatted_date))
class(final_converted_date)

# -----------------------------------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------------------------------
# Session 8 and 9


library(tidyverse)
library(magrittr)


table1 <- tibble(
  country = c("Afghanistan", "Afghanistan", "Brazil", 
               "Brazil", "China", "China"),
  year = c(1999, 2000, 1999, 2000, 1999, 2000),
  cases = c(745,2666,37737,80488,212258,213766),
  population = c(19987071,20595360,172006362, 
                 174504898, 1272915272,1280428583)
)

table1
table2
table3
table4a
table4b

# Pivoting – Longer to wider
# (To do standard statistical analysis)
table2 %>% pivot_wider(names_from = type, values_from = count)

# Pivoting – Wider to Longer 
# (To do Variance components analysis)
table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to =
                 "year", values_to = "cases")

# Tidy data: Separate
table3 %>% 
  separate(rate, into = c("cases", "population"))
OR
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

# Tidy data: Unite
table5 %>% 
  unite(new, century, year)
OR
table5 %>% 
  unite(new, century, year, sep = "")

# Missing values: Example
stocks <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr = c( 1, 2, 3, 4, 2, 3, 4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)

stocks %>% pivot_wider(names_from = year, values_from = return)



stocks %>%
  pivot_wider(names_from = year, values_from = return) %>%
  pivot_longer(
    cols = c(`2015`, `2016`),
    names_to = "year",
    values_to = "return",
    values_drop_na = TRUE
  )

# Complete a data frame with missing combinations of data
# Turns implicit missing values into explicit missing values
stocks %>% complete(year, qtr)



# row wise tibble creation

treatment <- tribble(
  ~ person, ~ treatment, ~response,
  "Derrick Whitmore", 1, 7,
  NA, 2, 10,
  NA, 3, 9,
  "Katherine Burke", 1, 4
)


treatment %>% fill(person) 

# filter() The filter() function is used to subset a data frame, retaining all rows that satisfy your conditions. 
# arrange() arrange() orders the rows of a data frame by the values of selected columns.
# select() select (and optionally rename) variables in a data frame, using a concise mini-language that makes it easy to refer to variables based on their name (e.g. a:f selects all columns from a on the left to f on the right) or type (e.g. where(is.numeric) selects all numeric columns).
# mutate() mutate() creates new columns that are functions of existing variables. It can also modify (if the name is the same as an existing column) and delete columns (by setting their value to NULL).
# summarise() summarise() creates a new data frame. It returns one row for each combination of grouping variables; if there are no grouping variables, the output will have a single row summarising all observations in the input. It will contain one column for each grouping variable and one column for each of the summary statistics that you have specified
# group_by Most data operations are done on groups defined by variables. group_by() takes an existing tbl and converts it into a grouped tbl where operations are performed "by group". ungroup() removes grouping.

library(dplyr)
library(nycflights13)
flights


filter(flights, month == 1, day == 1)

jan1 <- filter(flights, month == 1, day == 1)
(jan1 <- filter(flights, month == 1, day == 1))

dec25 <- filter(flights, day ==12 , day == 25)
(dec25 <- filter(flights, day ==12 , day == 25))

filter(flights, month = 1)

filter(flights, month == 1) 

filter(flights, month == 11 | month == 12)
filter(flights, month == 11 | 12)

nov_dec <- filter(flights, month %in% c(11, 12))

# De Morgan's Law:

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120) 

# arrange example

arrange(flights, year, month, day)

# descending order
arrange(flights, desc(dep_delay))

# select example
# Select columns by name
select(flights, year, month, day)
# Select all columns between year and day (inclusive)
select(flights, year:day)


# select except example
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))

flights %>% select(starts_with('d'))
flights %>% select(ends_with('e'))
flights %>% select(contains('d'))
flights %>% select(matches("(.)\\1"))
flights %>% select(num_range("dest",1:15))

# select() can be used to rename 
# variables, but it’s rarely useful 
# because it drops all of the 
# variables not explicitly 
# mentioned.

# rename
rename(flights, tail_num = tailnum)

# move to the start of the data frame
select(flights, time_hour, air_time, everything())

# to create new column in data frame

flights_sml <- select(flights, year:day, ends_with('delay'), distance, air_time)

# added gain and speed on newly created tibble flights_sml
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60)

# again mutated 
mutate(
  flights_sml,
  gain = dep_delay - arr_delay,
  hours = air_time * 60,
  gain_per_hour = gain / hours
)


# transmutate

transmute(
  flights,
  gain = dep_delay - arr_delay,
  hours = air_time / 60,
  gain_per_hour = gain / hours
)

transmute(flights,
          dep_time,
          hour = dep_delay %/%  100,
          minute = dep_time %% 100)

# summarize
summarise(flights, delay=mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, carrier)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))


delays <-
  flights %>% group_by(dest) %>% summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)) %>% filter(count > 20, dest != 'HNL'
    )
delays 

flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))


flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), 
         !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = 
              mean(dep_delay))

# Counts: Example

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )

delays

hist(delays$delay)

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, 
                 na.rm = TRUE),
    n = n()
  )
hist(delays$n)

plot(delays$n, delays$delay)

# When do the first and last flights leave each day
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

# Why is distance to some 
# destinations more variable than 
# to others?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = 
              sd(distance)) %>% 
  arrange(desc(distance_sd))

# Which destinations have the 
# most carriers?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = 
              n_distinct(carrier)) %>% 
  arrange(desc(carriers))
 
# How many flights left before 
# 5am? (these usually indicate 
# delayed flights from the previous 
# day)
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = 
              sum(dep_time < 500))

# What proportion of flights are 
# delayed by more than an hour?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_prop = 
              mean(arr_delay > 60))

#Find all groups bigger than a 
# threshold:
popular_dests <- flights %>%
  group_by(dest) %>%
  filter(n() > 365)
popular_dests

head(popular_dests$dest)
tail(popular_dests$dest)


# slice function
#What will happen?
flights %>% slice(1L)
flights %>% slice(n())
flights %>% slice(5:n())
slice(flights,-(1:4))
flights %>% slice_sample(n=5)
flights %>% slice_sample(n=5, 
                           replace = TRUE)
set.seed(123)
train_data <- flights %>% 
  slice_sample(prop=0.8)
train_data
test_data <- flights %>% 
  slice_sample(prop=0.2)
test_data

