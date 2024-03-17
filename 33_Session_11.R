# data mining

# library(BiocManager)
# BiocManager::install("Rgraphviz")
# 
# install.packages("twitteR")
# install.packages("tm")
# install.packages("SnowballC")
# install.packages("wordcloud")
# install.packages("topicmodels")
# 
# library(tm)

# laod the twitter data

load(file = "C:/Users/SumanPaudel/Desktop/R For Data Science/rdmTweets.RData")

tweets <- rdmTweets

str(tweets)

n.tweets <- length(tweets)

strwrap(tweets[[154]])

library(tm)
library(twitteR)

df <- twListToDF(tweets)

myCorpus <- Corpus(VectorSource(df$text))

inspect(myCorpus)

# convert to lower case

myCorpus <- tm_map(myCorpus, tolower)
inspect(myCorpus[1:3])

# remove puntucations and numbers
myCorpus <- tm_map(myCorpus, removePunctuation)
inspect(myCorpus[1:3])

myCorpus <- tm_map(myCorpus, removeNumbers)
inspect(myCorpus[1:3])

# remove url

removeURL <- function(x) gsub("http*","",x)

myCorpus <- tm_map(myCorpus, removeURL)

inspect(myCorpus[1:3])


myStopwords <- setdiff(stopwords("english"),c("r","big"))

myCorpus <- tm_map(myCorpus, removeWords, myStopwords)
inspect(myCorpus[1:3])



# text cleaning in R: Preprocessing 

# stemming

myCorpuscopy <- myCorpus


# stem word

myCorpus <- tm_map(myCorpus, stemDocument)
inspect(myCorpus[1:3])

myCorpus <- tm_map(myCorpus, gsub, pattern='posit',replacement='position')

strwrap(myCorpus[154], width = 55)



# create term documetn matrix and cehkt its stcuture via tm package

myTdm <- TermDocumentMatrix(myCorpuscopy, control = list((wordLenghts=c(1,Inf))))

# inspect frequent words on tdm OF NON STEMMED MYCorpus
freq.terms <- findFreqTerms(myTdm, lowfreq = 10)


# which words are asscoicated with r?

findAssocs(myTdm, "social", 0.2)



library(graph)
library(Rgraphviz)

plot(myTdm, terms = freq.terms, corThreshold = 0.1, weighting = T)


library(wordcloud)

m <- as.matrix(myTdm)

freq <- sort(rowSums(m), decreasing = T)


wordcloud(words = names(freq), freq = freq, min.freq = 4, random.order = F)


# topic model

library(topicmodels)

set.seed(123)

myLda <- LDA(as.DocumentTermMatrix(myTdm),k=5)
terms(myLda)


# google scholar 

