# set the current working directory to Project 2 Unit 2
setwd("C:/Users/SumanPaudel/Desktop/R For Data Science/Project 2 Unit 2")


# task 1 part 1

# load the data using Base R read.csv 
data <- read.csv("covnep_252days.csv")

summary(data$totalCases)

# minimum value is 0 but we need 1 instead
# this can be achieved using multiple ways like ifelse or pmax or subsetting

# using ifelse
totalCases_ifelse <- ifelse(data$totalCases < 1, 1, data$totalCases)
summary(totalCases_ifelse)

# using pmax
totalCases_pmax <- pmax(data$totalCases, 1)
summary(totalCases_pmax)

# subsetting
totalCases_subsetting <- data$totalCases
totalCases_subsetting[totalCases_subsetting < 1] <- 1
summary(totalCases_subsetting)

# task 2 part 1

# import required library

library(foreign) # for .SAV file we can use foreign package for that as well
library(gt, warn.conflicts = FALSE) #genotype table
library(magrittr) # for using pipes
library(tibble)
library(dplyr)

# read the .sav file using read_sav function from haven
saq_data <- read.spss("SAQ8.sav",to.data.frame=TRUE)


# for q1

q01 <- saq_data$q01

datalevels_q01 <- levels(q01)
freq_q01 <- as.numeric(table(q01))
percent_q01 <- as.numeric(round(prop.table(freq_q01) * 100, 1))
valid_percent_q01 <- as.numeric(round(prop.table(freq_q01) * 100, 1))
cum_percent <- cumsum(percent_q01)

# Create data frame for computed value
data <- data.frame(
  Levels = datalevels_q01,
  Freq = freq_q01,
  Percent = percent_q01,
  Val_Percent = valid_percent_q01,
  Cum_Percent = cum_percent
)

# final version of calculated table
data <- data %>% add_row(Levels = "Total", Freq = sum(data$Freq), 
                 Percent = sum(data$Percent), 
                 Val_Percent = sum(data$Val_Percent),
                 Cum_Percent = NULL)

# aethetics table using gt
data %>% gt(rowname_col = 'Levels') %>% 
  tab_header(title = md("Statistics makes me cry")) %>% 
  cols_label(Freq = "Frequency",
             Percent = "Percent",
             Val_Percent = "Valid Percent",
             Cum_Percent = "Cumulative Percent") %>% 
  sub_missing(missing_text = "")
  

# for q03

q03 <- saq_data$q03
datalevels_q03 <- levels(q03)
freq_q03 <- as.numeric(table(q03))
percent_q03 <- as.numeric(round(prop.table(freq_q03) * 100, 1))
valid_percent_q03 <- as.numeric(round(prop.table(freq_q03) * 100, 1))
cum_percent_q03 <- cumsum(percent_q03)

data_q03 <- data.frame(
  Levels = datalevels_q03,
  Freq = freq_q03,
  Percent = percent_q03,
  Val_Percent = valid_percent_q03,
  Cum_Percent = cum_percent_q03
)

data_q03 <- data_q03 %>% add_row(Levels = "Total", Freq = sum(data_q03$Freq), 
                         Percent = sum(data_q03$Percent), 
                         Val_Percent = sum(data_q03$Val_Percent),
                         Cum_Percent = NULL)

# final version of calculated table
data_q03 %>% gt(rowname_col = 'Levels') %>% 
  tab_header(title = md("Statistic makes me cry")) %>% 
  cols_label(Freq = "Frequency",
             Percent = "Percent",
             Val_Percent = "Valid Percent",
             Cum_Percent = "Cumulative Percent") %>% 
  sub_missing(missing_text = "")


# for q06
q06 <- saq_data$q06

datalevels_q06 <- levels(q06)
freq_q06 <- as.numeric(table(q06))
percent_q06 <- as.numeric(round(prop.table(freq_q06) * 100, 1))
valid_percent_q06 <- as.numeric(round(prop.table(freq_q06) * 100, 1))
cum_percent_q06 <- cumsum(percent_q06)

data_q06 <- data.frame(
  Levels = datalevels_q06,
  Freq = freq_q06,
  Percent = percent_q06,
  Val_Percent = valid_percent_q06,
  Cum_Percent = cum_percent_q06
)

data_q06 <- data_q06 %>% add_row(Levels = "Total", Freq = sum(data_q06$Freq), 
                         Percent = sum(data_q06$Percent), 
                         Val_Percent = sum(data_q06$Val_Percent),
                         Cum_Percent = NULL)

# final version of calculated table
data_q06 %>% gt(rowname_col = 'Levels') %>% 
  tab_header(title = md("I have little experience of computer")) %>% 
  cols_label(Freq = "Frequency",
             Percent = "Percent",
             Val_Percent = "Valid Percent",
             Cum_Percent = "Cumulative Percent") %>% 
  sub_missing(missing_text = "")

# for q08
q08 <- saq_data$q08

datalevels_q08 <- levels(q08)
freq_q08 <- as.numeric(table(q08))
percent_q08 <- as.numeric(round(prop.table(freq_q08) * 100, 2))
valid_percent_q08 <- as.numeric(round(prop.table(freq_q08) * 100, 2))
cum_percent_q08 <- cumsum(percent_q08)


data_q08 <- data.frame(
  Levels = datalevels_q08,
  Freq = freq_q08,
  Percent = round(valid_percent_q08,1),
  Val_Percent = round(valid_percent_q08,1),
  Cum_Percent = round(cum_percent_q08,1)
)

data_q08 <- data_q08 %>% add_row(Levels = "Total", Freq = sum(data_q06$Freq), 
                         Percent = sum(data_q08$Percent), 
                         Val_Percent = sum(data_q08$Val_Percent),
                         Cum_Percent = NULL)


# final version of calculated table
data_q08 %>% gt(rowname_col = 'Levels') %>% 
  tab_header(title = md("Statistics makes me cry")) %>% 
  cols_label(Freq = "Frequency",
             Percent = "Percent",
             Val_Percent = "Valid Percent",
             Cum_Percent = "Cumulative Percent") %>% 
  sub_missing(missing_text = "")

# part 3 task 1

library(readxl)
library(tidyverse)

mr_drugs <- read_xlsx("MR_Drugs.xlsx")

inco <- mr_drugs %>% select(starts_with('inco'))

transform_inco <- mr_drugs %>% select(starts_with('inco')) %>%
  colSums() %>%
  enframe("income", "N") %>%
  mutate(Percent = round(N / sum(N) * 100, 1))

transform_inco

income_frequencies <- apply(inco, 2, table) %>% 
  t() %>% 
  as.data.frame()
income_frequencies

transform_inco <- transform_inco %>% 
  mutate(`Percent of Cases` = 
           round(d$N / (d$N + income_frequencies[, 1]) * 100, 1))


# final version of calculated table
data <- d %>% add_row(
  income = "Total",
  N = sum(d$N),
  Percent = round(sum(d$Percent),2),
  "Percent of Cases" = round(sum(d$`Percent of Cases`),2),
)

# converting into percentage
data$Percent <- paste0(sprintf("%.1f", data$Percent),"%")
data$`Percent of Cases` <- paste0(sprintf("%.1f", data$`Percent of Cases`),"%")

library(gt)
data %>% gt(rowname_col = 'income') %>% 
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


# Task 2

library(RSelenium)
library(rvest)
library(netstat)
rD <- rsDriver(browser="firefox",verbose = F, port = 14420L)
remDr <- rD[["client"]]
remDr$navigate("https://aqicn.org/forecast/kathmandu/")
aqi_html  <- read_html(remDr$getPageSource() %>% unlist())
aqi_html %>% html_element(".forecast-body-table") %>%  html_nodes("table") %>% html_table() -> forecast_table



aqi_table <- forecast_table %>% .[[1]]


aqi_table <- aqi_table %>% select(-c('X10','X11','X20','X21','X30','X31','X40','X41','X50','X51','X60','X61'))

aqi_table <- aqi_table %>% filter(X1 != 'UVI')
aqi_table <- aqi_table %>% filter(X1 != 'humidity')
aqi_table <- aqi_table %>% mutate(X1 = replace(X1, 9, "humidity"))
aqi_table <- aqi_table %>% mutate(X1 = replace(X1, 1, "Index"))
aqi_table <- aqi_table %>% filter(X1 != '')

headers <- aqi_table[1,]

colnames(aqi_table) <- headers

aqi_table <- aqi_table[-1,]

aqi_table <- aqi_table %>% column_to_rownames(var = 'Index')

library(stringr)

aqi_table[2,] <- floor(as.integer(str_extract(as.character(aqi_table[2,]), "\\d+")) / 1000)
aqi_table[3,] <- floor(as.integer(str_extract(as.character(aqi_table[3,]), "\\d+")) / 100)

lengths <- as.numeric(nchar(aqi_table[4,]))
aqi_table[4,] <- ifelse(lengths == 2, substr(aqi_table[4,], 1, 1), ifelse(lengths %in% 3:4, substr(aqi_table[4,], 1, 2), ""))

# Load the packages
library(pdftools)
library(tm)
library(magrittr)
library(tibble)
library(wordcloud)
library(Rgraphviz)
library(graph)
# top 10 words and counts using bargraph
library(ggplot2)
# Set the working directory to the one containing the PDF files
setwd("C:/Users/SumanPaudel/Desktop/R For Data Science/Project 2 Unit 2/MDSPRJ2")

# load the file path in list
files <- list.files(pattern = "pdf$")

# load the pdf files into list
pdf_files <- lapply(files, pdf_text)

# create a corpus from vector source i.e from list pdf_files
corpus <- Corpus(VectorSource(unlist(pdf_files)))

# copy the loaded corpus
corpus_copy <- corpus

# inspect first few texts of corpus
inspect(corpus[1:2])

# text mining preprocessing
# convert the all texts in lower
corpus <- tm_map(corpus, tolower)
inspect(corpus[1:2])

# remove punctuations
corpus <- tm_map(corpus, removePunctuation)

# remove numbers
corpus <- tm_map(corpus, removeNumbers)

my_stopwords <- c("can","may","used")
# remove stopwords from the corpus
corpus <- tm_map(corpus, removeWords, my_stopwords)

# stem the corpus
corpus <- tm_map(corpus, stemDocument)

remove <- function(x) gsub("values","value",x)
corpus <-  tm_map(corpus, remove)

# create Term Document Matrix with word lenght 1 or many

tdm <- TermDocumentMatrix(corpus, control = list((wordLenghts=c(1,Inf))))


# best way to create a Term Document Matrix with preprocessing
remove <- function(x) gsub("values","value",x)
corpus_copy <-  tm_map(corpus_copy, remove)
my_tdm <- TermDocumentMatrix(
  corpus_copy,
  control =
    list(
      removePunctuation = TRUE,
      stopwords = TRUE,
      tolower = TRUE,
      stemming = FALSE,
      removeNumbers = TRUE,
      bounds = list(global = c(3, Inf)),
      wordLenghts = c(1,Inf),
      removeWords = (c("can","may","used")))
)

# finding frequency of words which is at least present 10 times
low_frequent_terms <- findFreqTerms(my_tdm, lowfreq = 10)
head(low_frequent_terms)
# finding frequency of words which is at max present 10 times
high_frequent_terms <- findFreqTerms(my_tdm, highfreq = 10)
head(high_frequent_terms)


findAssocs(my_tdm, "mining", 0.3)

findAssocs(my_tdm, "learning", 0.35)

findAssocs(my_tdm, "classification", 0.4)

# top 10 words and their respective counts 
library(magrittr)
library(tibble)
df <-
  my_tdm %>%
  as.matrix() %>%
  rowSums() %>%
  sort(decreasing = TRUE) %>%
  head(10) %>%
  enframe(name = "word", value = "counts")
df


# top 10 words and counts using bargraph
library(ggplot2)
bargraph <- ggplot(df, aes(word, counts)) +
  geom_bar(stat = "identity", fill = "#E69F00") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Top 10 words by counts.") +
  geom_text(aes(label = counts), vjust = -0.5)

bargraph




# word cloud
library(wordcloud)

mat <- as.matrix(my_tdm)
freq <- mat %>% rowSums() %>% sort(decreasing = T)

# plot word cloud
wordcloud(
  words = names(freq),
  freq = freq,
  min.freq = 300,
  max.words = 500,
  random.order = FALSE,
  colors = brewer.pal(8, "Dark2"),
  scale = c(4, 0.5),
  random.color = TRUE,
  rot.per = 0.35,
  use.r.layout = FALSE
)


# correlation between top 600 frequent terms
top_600_frequent_tems <- findFreqTerms(my_tdm, lowfreq = 650)
plot(my_tdm, terms = top_600_frequent_tems, corThreshold = 0.2, weighting = T)

