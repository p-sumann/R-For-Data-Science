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

# part 1 task 2

# import required library

library(foreign) # for .SAV file we can use foreign package for that as well
library(gt, warn.conflicts = FALSE) #genotype table
library(magrittr) # for using pipes

# read the .sav file using read_sav function from haven
saq_data <- read.spss("SAQ8.sav",to.data.frame=TRUE)


# for q1

q01 <- saq_data$q01


datalevels_q01 <- levels(q01)
freq_q01 <- as.numeric(table(q01))
percent_q01 <- as.numeric(round(prop.table(freq_q01) * 100, 1))
valid_percent_q01 <- as.numeric(round(prop.table(freq_q01) * 100, 1))
cum_percent <- cumsum(percent_q01)

# Create data frame
data <- data.frame(
  Levels = levels_q01,
  Freq = freq_q01,
  Percent = percent_q01,
  Val_Percent = valid_percent_q01,
  Cum_Percent = cum_percent
)

# Convert data to data frame
data <- as.data.frame(data)

# Add row for sum
sum_row <- c("Total", sum(data$Freq), sum(data$Percent), sum(data$Val_Percent), "") # or NULL or ""
data <- rbind(data, sum_row)
data



