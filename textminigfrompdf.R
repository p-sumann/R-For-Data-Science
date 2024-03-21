
# Load the packages
library(pdftools)
library(tm)

# Set the working directory to the one containing the PDF files
setwd("C:/Users/SumanPaudel/Desktop/R For Data Science/Project 2 Unit 2/MDSPRJ2")

files <- list.files(pattern = "pdf$")

# tranform the outputs
opinions <- lapply(files, pdf_text)
corp <- Corpus(URISource(files),
               readerControl = list(reader = readPDF))


opinions.tdm <- TermDocumentMatrix(corp, 
                                   control = 
                                     list(removePunctuation = TRUE,
                                          stopwords = TRUE,
                                          tolower = TRUE,
                                          stemming = TRUE,
                                          removeNumbers = TRUE,
                                          bounds = list(global = c(3, Inf)))) 

# read the pdf file using tm::readPDF

reader <- readPDF(engine = 'pdftools')

pdf_content <- lapply(opinions, function(file) {
  reader <- readPDF(engine = "pdftools",control = list(info = NULL, text = NULL))
  pdf <-  reader(elem = list(uri = file), language = "en")
  pdf
})


library(pdftools)

# Assuming you have a list of PDF file paths in 'pdf_files'
pdf_list <- lapply(files, function(file) {
  reader <- readPDF(engine = "pdftools")
  pdf <-  reader(elem = list(uri = file), language = "en")
  pdf
})


# Create a corpus from the PDF files using lapply() and pdf_combine()
corpus <- Corpus(VectorSource((lapply(pdf_list, function(file) {
  combined_file <- paste0(tools::file_path_sans_ext(file), "_combined.pdf")
  pdf_combine(file, output = combined_file)
  text <- pdf_text(combined_file)
  file.remove(combined_file)
  return(text)
}))))