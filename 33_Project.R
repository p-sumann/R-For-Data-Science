# Task 1


# Task 2


# Task 3

# Data Mining
# import library pdftools

base_url <- "https://scholar.google.com/scholar?"
search_term <- "Data+Mining"
first_page <- 'start=0&hl=en&q='
second_page <- 'start=10&hl=en&q='
url_first <- paste0(base_url, first_page, search_term)
url_second <- paste0(base_url, second_page, search_term)


pdf_link1 <- read_html(url_first) 
pdf_link2 <- read_html(url_second) 

first_page_pdf_link <- pdf_link1 %>%
  html_elements('.gs_or_ggsm a') %>% html_attr('href') %>% unique() %>% head(5)

second_page_pdf_link <- pdf_link2 %>%
  html_elements('.gs_or_ggsm a') %>% html_attr('href') %>% unique() %>% head(5)

final_pdf_link <- rbind()
