# Task 1


# Task 2


# Task 3

# Data Mining
# import library pdftools

base_url <- "https://scholar.google.com/scholar?start=10&hl=en&q="
search_term <- "Data+Mining"
url <- paste0(base_url, search_term)
url


pdf_link <- read_html(url) 

# pdf_link %>%
#   html_node('.gs_or_ggsm a') %>% 
#   html_attr('href') %>% str_remove("[?.*]")
# .gs_or_ggsm a
pdf_urls <- pdf_link %>%
  html_elements('.gs_or_ggsm') %>% html_elements('a') %>% html_attr('href')
html_attr("href")

pdf_urls