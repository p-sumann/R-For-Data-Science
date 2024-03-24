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


findAssocs(myTdm, "social", 0.2)

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
top_600_frequent_tems <- findFreqTerms(my_tdm, lowfreq = 600)
plot(my_tdm, terms = top_600_frequent_tems, corThreshold = 0.2, weighting = T)
