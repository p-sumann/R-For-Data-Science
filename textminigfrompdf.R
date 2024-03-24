

# Load the packages
library(pdftools)
library(tm)

# Set the working directory to the one containing the PDF files
setwd("C:/Users/SumanPaudel/Desktop/R For Data Science/Project 2 Unit 2/MDSPRJ2")

files <- list.files(pattern = "pdf$")

# tranform the outputs
pdf_files <- lapply(files, pdf_text)

# create a corpus from vector source i.e from list pdf_files
corpus <- Corpus(VectorSource(unlist(pdf_files)))

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


# create a copy version of preprocessing so that further we don't have
# to it again 
corpus_copy <- corpus

# create Term Document Matrix with word lenght 1 or many

tdm <- TermDocumentMatrix(corpus, control = list((wordLenghts=c(1,Inf))))


remove <- function(x) gsub("values","value",x)
corpus <-  tm_map(corpus, remove)
# best way to create a Term Document Matrix with preprocessing
my_tdm <- TermDocumentMatrix(
  corpus,
  control =
    list(
      removePunctuation = TRUE,
      stopwords = TRUE,
      tolower = TRUE,
      stemming = FALSE,
      removeNumbers = TRUE,
      bounds = list(global = c(3, Inf)),
      wordLenghts = c(1,Inf),
      removeWords = (c("can","may","used")),
      gsub = c('values' , 'value')
    )
)

# finding frequency of words which is at least present 10 times
low_frequent_terms <- findFreqTerms(my_tdm, lowfreq = 100)
head(low_frequent_terms)
# finding frequency of words which is at max present 10 times
high_frequent_terms <- findFreqTerms(my_tdm, highfreq = 10)
head(high_frequent_terms)

# top 10 words and their respective counts 
library(magrittr)
library(tibble)
df_high_freq <- 
  my_tdm %>%
  as.matrix() %>%
  rowSums() %>%
  sort(decreasing = TRUE) %>%
  head(10) %>%
  enframe(name = "word", value = "counts")
df_high_freq


library(ggplot2)


bargraph <- ggplot(df_high_freq, aes(word, counts)) +
  geom_bar(stat = "identity", fill = "#db6810") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Top 10 words by counts.") +
  geom_text(aes(label = counts), vjust = -0.5)

print(bargraph)

myTdm <- TermDocumentMatrix(corpus_copy, control = list((wordLenghts=c(1,Inf))))
freq.terms <- findFreqTerms(my_tdm, lowfreq = 10)


library(magrittr)
mat <- as.matrix(my_tdm)
freq <- mat %>% rowSums() %>% sort(decreasing = T)

# word cloud
library(wordcloud)
wordcloud(names(freq), freq, min.freq = 300, colors = brewer.pal(4, "Dark2"),random.order = FALSE)

wordcloud(
  words = names(freq),
  freq = freq,
  
  min.freq = 200,
  max.words = 1000,
  random.order = FALSE,
  colors = brewer.pal(8, "Dark2"),
  scale = c(4, 0.5),
  random.color = TRUE,
  rot.per = 0.35,
  
  use.r.layout = FALSE
)

wordcloud(my_tdm
          , scale=c(5,0.5)     # Set min and max scale
          , max.words=100      # Set top n words
          , random.order=FALSE # Words in decreasing freq
          , rot.per=0.35       # % of vertical words
          , use.r.layout=FALSE # Use C++ collision detection
          , colors=brewer.pal(8, "Dark2")
          , min.freq = 200)


library(topicmodels)

set.seed(123)

myLda <- LDA(my_tdm,k=5)
terms(myLda)

# sorted_word_counts <- sort(word_counts, decreasing = TRUE)
# 
# # Select the top 10 words with their counts
# top_10_words <- names(head(freq, 10))
# 
# # Subset the TermDocumentMatrix to include only the columns corresponding to the top 10 words
# top_10_tdm <- my_tdm[, top_10_words]
# 
# # Convert the subsetted TDM to a regular matrix
# top_10_matrix <- as.matrix(top_10_tdm)


library(ggplot2)

# Assuming you have a data frame named 'data' with columns 'word' and 'frequency'
data <- data.frame(word = c("apple", "banana", "cherry", "date"), frequency = c(10, 20, 30, 40))

# Create the heatmap
ggplot(df_high_freq, aes(x = word, y = counts, fill = counts)) +
  geom_tile() +
  theme_void() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# # Create a heatmap for the top 10 words
# heatmaply(top_10_matrix, 
#           scale_fill_gradientn = list(colors = c("blue", "white", "red")),
#           main = "Heatmap of Top 10 Words")

# # read the pdf file using tm::readPDF
# 
# reader <- readPDF(engine = 'pdftools')
# 
# 
# 
# 
# pdf_content <- lapply(files, function(file) {
#   pdf <-  reader(elem = list(uri = file), language = "en")
#   pdf
# })
# 



# library(pdftools)
# 
# # Assuming you have a list of PDF file paths in 'pdf_files'
# pdf_list <- lapply(files, function(file) {
#   reader <- readPDF(engine = "pdftools")
#   pdf <-  reader(elem = list(uri = file), language = "en")
#   pdf
# })
# 
# 
# # Create a corpus from the PDF files using lapply() and pdf_combine()
# corpus <- Corpus(VectorSource((lapply(pdf_list, function(file) {
#   combined_file <-
#     paste0(tools::file_path_sans_ext(file), "_combined.pdf")
#   pdf_combine(file, output = combined_file)
#   text <- pdf_text(combined_file)
#   file.remove(combined_file)
#   return(text)
# }))))