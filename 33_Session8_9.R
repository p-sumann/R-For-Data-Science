library(dplyr)

# filter() The filter() function is used to subset a data frame, retaining all rows that satisfy your conditions. 
# arrange() arrange() orders the rows of a data frame by the values of selected columns.
# select() Select (and optionally rename) variables in a data frame, using a concise mini-language that makes it easy to refer to variables based on their name (e.g. a:f selects all columns from a on the left to f on the right) or type (e.g. where(is.numeric) selects all numeric columns).
# mutate() mutate() creates new columns that are functions of existing variables. It can also modify (if the name is the same as an existing column) and delete columns (by setting their value to NULL).
# summarise() summarise() creates a new data frame. It returns one row for each combination of grouping variables; if there are no grouping variables, the output will have a single row summarising all observations in the input. It will contain one column for each grouping variable and one column for each of the summary statistics that you have specified
# group_by Most data operations are done on groups defined by variables. group_by() takes an existing tbl and converts it into a grouped tbl where operations are performed "by group". ungroup() removes grouping.

flights <- nycflights13::flights

str(flights)

filter(flights, month == 1, day == 1)

jan1 <- filter(flights, month == 1, day == 1)
(jan1)

(dec25 <- filter(flights, day ==12 , day == 25))

filter(flights, month == 11 | month == 12)
# filter(flights, month == 11 | 12) doesn't work

nov_dec

# De Morgan's Law:

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120 , dep_delay <= 120)

# arrange

arrange(flights, year, month, day)


arrange(flights, desc(dep_delay))

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


# groupy by summar


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


cancelled_flights <- flights %>% filter(is.na(dep_delay), is.na(arr_delay))
cancelled_flights %>% group_by(year, month, day) %>%  summarise(mean = mean(dep_delay))


not_cancelled_flights <- flights %>% filter(!is.na(dep_delay), !is.na(arr_delay))
cancelled_flights %>% group_by(year, month, day) %>%  summarise(mean = mean(dep_delay))


delays <- not_cancelled_flights %>% group_by(tailnum) %>% summarise(delay = mean(arr_delay))
hist(delays$delay)



delays <- not_cancelled_flights %>% group_by(tailnum) %>% summarise(delay=mean(arr_delay,na.rm = TRUE),n=n())

hist(delays$n)
hist(delays$delay)

plot(delays$n, delays$delay)


not_cancelled_flights %>% group_by(year, month) %>% summarise(first = min(dep_time),
                                                                   last = max(dep_time))



# why distance to some destinatiions more bvaraiable than to others

not_cancelled_flights %>%  group_by(dest) %>% summarise(distance_sd = sd(distance)) %>% arrange(desc(distance_sd))
not_cancelled_flights %>%  group_by(dest) %>% summarise(distance_sd = sd(distance), mean = mean(distance, na.rm = TRUE)) %>% arrange(desc(distance_sd))


# which destinations gave the nmost carriers

not_cancelled_flights %>% group_by(dest) %>% summarise(carriers = n_distinct(carrier)) %>% arrange(desc(carriers))

not_cancelled_flights %>% group_by(year, month) %>% summarise(early = sum(dep_time < 500)) 


not_cancelled_flights %>% group_by(year, month) %>% summarise(early = mean(dep_delay >= 60)) 

# example homeyork sort by popular desc
popular_dest <- flights %>% group_by(dest) %>% filter(n() > 365) %>% arrange(desc(n()))

# 
