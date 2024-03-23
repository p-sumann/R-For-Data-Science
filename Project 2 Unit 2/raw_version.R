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



