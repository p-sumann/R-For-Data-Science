library(jsonlite)


raw <- fromJSON(("https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD"))


food_market <- raw[['data']]

write.csv(food_market,'food_market')

names <- food_market[,14]

table(names)

table(v19)

table(food_market$V19)

str(food_market)

food_market[[14]]

dataframe = data.frame()


# using html
library(rvest)
simple <- read_html('https://dataquestio.github.io/web-scraping-pages/simple.html')

simple %>% html_nodes('p') %>% html_text()

# 


# wikipedia nepal covid 19 
wiki_link <- read_html('https://en.wikipedia.org/wiki/COVID-19_pandemic_in_Nepal')
str(wiki_link)

wiki_table <- wiki_link %>% html_elements('.COVID-19_pandemic_data_Nepal_medical_cases') %>% html_node('table') %>% html_table()

names(wiki_table) <- paste(names(wiki_table), wiki_table[1,],sep = "_")
wiki_table <- wiki_table[-1,]
wiki_table
