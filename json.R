# library(tidyverse)
# library(jsonlite)
# library(httr)
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


covid_unnested <- covid %>%
  pluck('AN') %>%
  pluck('dates') %>%
  enframe() %>%
  unnest_wider(value) %>%
  mutate(
    across(c(delta, delta7,total), ~ map(., ~ set_names(as_tibble(.x), paste0(cur_column(), "_", names(.)))))) %>% 
    unnest_wider(c(delta,delta7,total))

# Assuming your data frame is named df

df_with_dates <- covid %>% enframe() %>% 
  
  unnest_wider(value) %>% unnest_wider(dates)
  pivot_longer(name)
  mutate(
    value = map(value, ~ set_names(as_tibble(.x), paste0(key, "_", names(.))))
  ) %>%
  unnest(value)
  
  
  
  df_long <-
    covid %>% enframe() %>% unnest_wider(value) %>% unnest_wider(dates) %>%
    pivot_longer(cols = !name,
                 names_to = 'date',
                 values_to = "value") %>% unnest_wider(value) %>%
    mutate(across(c(delta, delta7, total), ~ map(., ~ set_names(
      as_tibble(.x), paste0(cur_column(), "_", names(.)))))) %>%
    unnest_wider(c(delta, delta7, total))
  

library(jsonlite)
  
data1 = 'https://data.covid19india.org/v4/min/timeseries.min.json'
data2 = 'https://data.covid19india.org/v4/min/data.min.json'

json1 <- fromJSON(data1)
json2 <- fromJSON(data2)

df1 <- data.frame(json1)
df2 <- data.frame(json2)
  