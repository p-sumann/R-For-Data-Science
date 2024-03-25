library(tidyverse)
library(jsonlite)
library(httr)
# 
# # link to the API output as a JSON file
# url_json <- "https://site.web.api.espn.com/apis/fitt/v3/sports/football/nfl/qbr?region=us&lang=en&qbrType=seasons&seasontype=2&isqualified=true&sort=schedAdjQBR%3Adesc&season=2019"
# 
# # get the raw json into R
# raw_json <- httr::GET(url_json) %>% 
#   httr::content()
# 
# # get names of the QBR categories
# category_names <- pluck(raw_json, "categories", 1, "labels") %>% tolower()
# 
# 
# # create the dataframe and tidy it up
# ex_output <- pluck(raw_json, "athletes") %>%
#   enframe() %>%
#   unnest_wider(value) %>% 
#   unnest_wider(athlete) %>% 
#   select(displayName, teamName:teamShortName, headshot, categories) %>% 
#   hoist(categories, 
#         data = list(1, "totals")) %>%
#   mutate(data = map(data, ~set_names(.x, nm = category_names))) %>% 
#   select(-categories) %>% 
#   unnest(data) %>% 
#   mutate(headshot = pluck(headshot,'href'))
#   

# load the data and do some analysis on AN state
covid <- jsonlite::fromJSON('Project 2 Unit 2/json_data.json')
# an <- covid %>% pluck('AN') %>% enframe() %>% unnest(name) %>% unnest(value) %>% unnest(value)%>% unnest(value)%>% unnest(name)
# an <- covid %>% pluck('AN') %>% pluck('dates') %>% enframe() %>% unnest(value) %>% unnest

# 
an <-
  covid %>% pluck('AN') %>% 
  pluck('dates') %>% 
  enframe() %>% 
  unnest_wider(value) %>%  
  mutate(
    delta7 = map(delta7, ~ tibble(
      delta7_confirmed = .x$confirmed,
      delta7_recovered = .x$recovered,
      delta7_tested = .x$tested
    ))
  ) %>% unnest_wider(delta7)

data1 = 'https://data.covid19india.org/v4/min/timeseries.min.json'
data2 = 'https://data.covid19india.org/v4/min/data.min.json'
covid_1 <- jsonlite::fromJSON(data1)
covid_2 <- jsonlite::fromJSON(data2)

covid_unnested_1 <- covid_1 %>%
  pluck('AN') %>%
  pluck('dates') %>%
  enframe() %>%
  unnest_wider(value) %>%
  mutate(
    across(c(delta, delta7,total), ~ map(., ~ set_names(as_tibble(.x), paste0(cur_column(), "_", names(.)))))) %>% 
  unnest_wider(c(delta,delta7,total))

covid_unnested_2 <- covid_1 %>%
  pluck('AN')

# Assuming your data frame is named df

df_with_dates <- covid %>% enframe() %>% 
  
  unnest_wider(value) %>% unnest_wider(dates)
pivot_longer(name)
mutate(
  value = map(value, ~ set_names(as_tibble(.x), paste0(key, "_", names(.))))
) %>%
  unnest(value)



df_long <-
  covid_1 %>% enframe() %>% unnest_wider(value) %>% unnest_wider(dates) %>%
  pivot_longer(cols = !name,
               names_to = 'date',
               values_to = "value") %>% unnest_wider(value) %>%
  mutate(across(c(delta, delta7, total), ~ map(., ~ set_names(
    as_tibble(.x), paste0(cur_column(), "_", names(.)))))) %>%
  unnest_wider(c(delta, delta7, total))

df_long %>% select(delta_confirmed, delta_recovered, delta_confirmed ,na.rm=TRUE)

df <- covid_2 %>% enframe() %>% unnest_wider(value) %>% 
  unnest_wider(c(delta,delta21_14, delta7, total),names_sep = "_") %>% select(-c(districts,meta))



library(jsonlite)

data1 = 'https://data.covid19india.org/v4/min/timeseries.min.json'
data2 = 'https://data.covid19india.org/v4/min/data.min.json'

json1 <- fromJSON(data1)
json2 <- fromJSON(data2)

df1 <- data.frame(json1)
df2 <- data.frame(json2)

library(readxl)
mr_drugs <- read_excel('mr_drugs.xlsx')

mr_drugs

library(dplyr)
library(tidyverse)
d <- mr_drugs %>% select(starts_with('inco')) %>% 
  colSums() %>% 
  enframe("income", "N") %>% 
  mutate(Percent = round(N / sum(N) * 100,1)) %>% 
  mutate("Percent of Cases" = c("23.5%","63.0%","30.4%","5.2%","8.5%","15.7%","36.6%"))
# mutate(Percent = paste0(round(N / sum(N) * 100,1),"%")) %>% 
library(dplyr)
library(tidyverse)
d <- mr_drugs %>% select(starts_with('inco')) %>% 
  colSums() %>% 
  enframe("income", "N") %>% 
  mutate(Percent = round(N / sum(N)*100,1)) %>% 
  mutate("Percent of Cases" = c("23.5%","63.0%","30.4%","5.2%","8.5%","15.7%","36.6%")) %>% 
  add_row(income="Total",N = sum(d$N), Percent = sum(d$Percent), `Percent of Cases`="182")
d



d %>% gt(rowname_col = 'income') %>% 
  tab_spanner(label='Response',columns = c('N','Percent')) %>% 
  cols_align(align = "center",columns = c("Percent", "N")) %>% 
  tab_header(title = md("$Income Frequencies")) %>% 
  tab_footnote(footnote = "a. Dichotomy group tabulated at value 1") %>%  tab_style(
    style = cell_borders(
      sides = c("left", "right","top","bottom"),
      color = "#d3d3d3",
      weight = px(1.5),
      style = "solid"
    ),
    locations = cells_body()
  )
  

