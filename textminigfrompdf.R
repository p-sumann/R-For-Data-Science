

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

# my_stopwords <- c("author","citations","publications","cordoba")
# remove stopwords from the corpus
# corpus <- tm_map(corpus, removeWords, my_stopwords)

# stem the corpus
# corpus <- tm_map(corpus, stemDocument)


# create a copy version of preprocessing so that further we don't have
# to it again 
corpus_copy <- corpus

# create Term Document Matrix with word lenght 1 or many

tdm <- TermDocumentMatrix(corpus, control = list((wordLenghts=c(1,Inf))))


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
      wordLenghts = c(1,Inf)
    )
)

# finding frequency of words which is at least present 10 times
low_frequent_terms <- findFreqTerms(my_tdm, lowfreq = 10)
head(low_frequent_terms)
# finding frequency of words which is at max present 10 times
high_frequent_terms <- findFreqTerms(my_tdm, highfreq = 10)
head(high_frequent_terms)


# top 10 words and their respective counts.
freq_term <- findFreqTerms(my_tdm)
high_count_freq <- as.matrix(my_tdm[freq_term,])
df_high_freq <- as.data.frame(head(sort(apply(high_count_freq, 1, sum), decreasing = TRUE), n = 10))
df_high_freq


library(magrittr)
library(tibble)
df_high_freq <- 
  my_tdm %>%
  as.matrix() %>%
  apply(1, sum) %>%
  sort(decreasing = TRUE) %>%
  head(10) %>%
  enframe(name = "word", value = "counts")
df_high_freq
# find words association 

# for word "mining" with correlation 0.4
findAssocs(my_tdm, "mining", 0.4)

# for word "warehouse" with correlation 0.5
findAssocs(my_tdm, "warehouse", 0.35)

# for word data with correlation 0.3
findAssocs(my_tdm, "classification", 0.3)

library(graph)
library(Rgraphviz)

plot(my_tdm, terms = low_frequent_terms, corThreshold = 0.7, weighting = T)















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