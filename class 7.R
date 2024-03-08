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

# 


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

covid_table$TPR <- gsub('[%]', '', covid_table$TPR)
covid_table$RR <- gsub('[%]', '', covid_table$RR)
covid_table$CFR <- gsub('[%]', '', covid_table$CFR)

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

