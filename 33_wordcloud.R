library(tm)
library(Rgraphviz)
library(wordcloud)
library(rvest)
library(rvest)
library(tidyverse)
url = 'https://thehimalayantimes.com/opinion/navigating-nepals-digital-frontier-understanding-cybersecurity-in-the-digital-age-ensuring-data-safety-and-the-role-of-ai'


url <- 'https://thehimalayantimes.com/opinion/navigating-nepals-digital-frontier-understanding-cybersecurity-in-the-digital-age-ensuring-data-safety-and-the-role-of-ai'

# Fetch the web content
x <- read_html(url)

post_content <- x %>% html_element('.post-content') %>% html_text()

