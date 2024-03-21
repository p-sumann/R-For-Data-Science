
# Load the packages
library(pdftools)
library(tm)

# Set the working directory to the one containing the PDF files
setwd("C:/Users/SumanPaudel/Desktop/R For Data Science/Project 2 Unit 2/MDSPRJ2")
pdf_files <- list.files(pattern = "\\.pdf$")

# tranform the outputs
read_pdf <- function(file) {
  txt <- pdf_text(file)
  return(txt)
}

library(pdftools)

# Assuming you have a list of PDF file paths in 'pdf_files'
pdf_list <- lapply(pdf_files, function(file) {
  reader <- readPDF(engine = "pdftools")
  pdf <-  reader(elem = list(uri = file), language = "en")
  pdf
})


# Create a corpus from the PDF files using lapply() and pdf_combine()
corpus <- VCorpus(VectorSource(unlist(lapply(pdf_files, function(file) {
  combined_file <- paste0(file_path_sans_ext(file), "_combined.pdf")
  pdf_combine(file, output = combined_file)
  text <- pdf_text(combined_file)
  file.remove(combined_file)
  return(text)
}))))