# column vector
x <- c(1:30)
y <- x ^ 3
plot(x, y)

# store the current working using following command:
initial.dir <- getwd()

# to change the working directory your custom directory
setwd("C:/Users/SumanPaudel/Desktop/R For Data Science")

# loading the necessary libraries
library(magrittr)

# to set the output file and bypass the output of R console and R Studio
sink('session3.out')

# load the dataset from the working directory set earlier
iris <- read.csv('iris.csv')

# plot the iris dataset to do some analysis
#  this won't appear in R studio as output is being saved in session3.out file
plot(iris)


# summary of iris dataset
summary(iris)

# to close the output file
sink()

# unloading the loaded library
detach("package:magrittr")

# to change back to original directory
setwd(initial.dir)


# extracting data from internet to use pipe
# load the iris data from UCI machine learning repo
iris <-
  read.csv(
    url(
      'https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data'
    ),
    header = FALSE
  )

# look first few values of data
head(iris)

# add column names for V1, V2, V3, V4, V5 columns to iris dataframe
names(iris) <- c("Sepal.Length",
                 "Sepal.Width",
                 "Petal.Length",
                 "Petal.Width",
                 "Species")

# saving the downloaded file to csv in local system
# write.csv(dataframe_name, "path\file_name.csv", row.names=FALSE)
write.csv(iris, 'iris.csv')

# check your working directory using:
getwd()

# Using forward pipe operator/s in R
# for using pipes in R we need magrittr library
# compute the square root of `iris$Sepal.Length` and assign it to the new variable
# Hotkey for pipe i.e. is Ctrl + Shift + M in windows and for MacOS CMD + Shift + M

iris$Sepal.Length.SQRT <- iris$Sepal.Length %>% sqrt()

# Compute the square root of `iris$Sepal.Length` and assign it to the same variable
# The assignment pipe, %<>%, is used to update a value by first piping it into one or more rhs expressions
# while using %<>%, we must be careful as original data will be lost.
# It's a good practice to store the computed value in new column
iris$Sepal.Length %<>% sqrt


# The “tee” pipe operator “%T%”
set.seed(123)
# setting random seed to generate random number that can be reproduced

# rnorm generated the random value from normal distribution
rnorm(200) %>%
  matrix(ncol = 2) %>%
  plot %>%
  colSums
# the above code didn't run because in R after plot no code will be executed because it won't return anything

# pipe `tee` in action
rnorm(200) %>%
  matrix(ncol = 2) %T>%
  plot %>%
  colSums

# Here %T>% is useful when an expression is used for its side-effect, in our case plotting.
# we are able to get the column sum even after plotting.

# The exposing pipe operator “%$%”
iris %>%
  subset(Sepal.Length > mean(Sepal.Length)) %$%
  cor(Sepal.Length, Sepal.Width)
# it gives the correlation of subset of values on which sepal length is greater than mean of sepal length
# This is useful when functions do not have a built-in data argument.

cor(iris$Sepal.Length, iris$Sepal.Width)

# When not to use R pipes
# • pipes are longer than (say) ten steps
# • have multiple inputs or outputs
# • starting to think about a directed graph with a complex dependency structure
# • doing internal package development

# Final Notes:
# %>% are use widely in R
# %<>% used when assignment of variables are required
# %T% and %$% use when required explicitly on rare occasion.
