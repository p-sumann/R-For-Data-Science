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
# select() Select (and optionally rename) variables in a data frame, using a concise mini-language that makes it easy to refer to variables based on their name (e.g. a:f selects all columns from a on the left to f on the right) or type (e.g. where(is.numeric) selects all numeric columns).
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


# Mutate: Example
flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

# transmute
# If you only want to keep the new 
# variables, use transmute()
transmute(
  flights,
  gain = dep_delay - arr_delay,
  hours = air_time / 60,
  gain_per_hour = gain / hours
)

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))


by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm =
                   TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")






dep_delay <- filter(flights, dep_delay > 0)
dep_delay_20 <- head(arrange(dep_delay,desc(dep_delay)), n = 20)
dep_delay_20 <- arrange(dep_delay,desc(dep_delay)) %>% slice(1:20)
# dep_delay_20 <- arrange(dep_delay,desc(dep_delay)) %>% slice(1:20)
table(dep_delay_20$carrier)

mean(dep_delay_20$dep_delay)

dep_delat_20$dep_delay %>% mean()

mean(dep_delay_20$dep_delay) / 60

# select
select(flights, year, month, day)

# select alll columns between year and day (inclusive)
select(flights, year:day)

# select alll columns except those between year and day (inclusive)
select(flights,-(year:day))


select(flights, time_hour, air_time, everything())
select(flights, time_hour, air_time)


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

