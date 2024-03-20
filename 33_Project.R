# Task 1


# Task 2


# Task 3

# Data Mining
# import library pdftools

library(tidyverse)
library(pdftools)
library(rvest)
library(purrr)


base_url <- "https://scholar.google.com/scholar?"
search_term <- "Data+Mining"
first_page <- 'start=0&hl=en&q='
second_page <- 'start=10&hl=en&q='
url_first <- paste0(base_url, first_page, search_term)
url_second <- paste0(base_url, second_page, search_term)


pdf_link1 <- read_html(url_first) 
pdf_link2 <- read_html(url_second) 

first_page_pdf_link <- pdf_link1 %>%
  html_elements('.gs_or_ggsm a') %>%
  html_attr('href') %>%
  unique() %>%
  head(5) %>%
  enframe(name = NULL)

second_page_pdf_link <- pdf_link2 %>%
  html_elements('.gs_or_ggsm a') %>%
  html_attr('href') %>%
  unique() %>%
  head(5) %>%
  enframe(name = NULL)

final_pdf_link <- rbind(first_page_pdf_link,second_page_pdf_link)%>% rename(url=value)

pdf_urls <- final_pdf_link$url

# Create the 'MDS503P2' folder if it doesn't exist
dir.create("MDS503P2", showWarnings = FALSE)


map(seq_along(pdf_urls), function(url, i) {
  print(url)
  file_name <- base
  download.file(url, file.path("MDS503P2", file_name))
})


library(jsonlite)
  
  
  
  
  
  
  # Find all the hyperlinks in the site
covid_india_urls <- read_html("https://data.covid19india.org") %>% 
html_elements("a") %>% 
html_attr("href") 

# Filter URLs with ".json" extension
json_link <- covid_india_urls[grep("\\json$",covid_india_urls)]
json_link

covid_india <- lapply('https://data.covid19india.org/v4/min/data.min.json',fromJSON)
df <- as.data.frame(covid_india)




