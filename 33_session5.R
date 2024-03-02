# variable naming convention R


adjustcolor <- FALSE #alllowercase
plot.new <- plot(iris) #period.separated
numeric_version <- 1 # underscore_separated
addTaskCallback <- 5 #lowerCamelCase
SignatureMethod <- TRUE # UpperCamelCase


# function in R: Build-in Functions

# rounding of numbers
round(3.1415)
round(3.1415,digits = 2)

# factorial
factorial(3)
factorial(2*3)

# mean
mean(1:6)
mean(c(1:30))


# random sampling without and with replacement in R using sample function
die <- 1:6
# sample size 1
sample(x=die,size=1)
sample(x=die,size=1)
sample(x=die,size=1,replace = TRUE)

# sample size 2
sample(x=die,size=2)
sample(x=die,size=2)
sample(x=die,size=2,replace = TRUE)

# load the iris dataset from current working directory

iris <- read.csv('iris.csv')
set.seed(123)
# training testing sample
tt.sample <- sample(c(TRUE, FALSE), nrow(iris), replace=T, prob=c(0.7,0.3))
train <- iris[tt.sample,]
test <- iris[!tt.sample,]


# user defined function in R

my_function <- function(){
  ## my function which does nothing
}

# user define function 1 : roll()
# simple function with no argument
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  cat("Dice Rolled:", dice, '\n')
  sum(dice)
}
# first roll()
cat('First Roll:', roll())

# second roll()
cat('Second Roll:', roll())

# third roll()
cat('Third Roll:', roll())

# User-defined function 2: roll2()
# function with a argument dice which has default value of 1:6
# if no data is passed computes using default value
roll2 <- function(dice = 1:6) {
  dice <- sample(dice, size = 2, replace = TRUE)
  cat("Dice Rolled:", dice, '\n')
  sum(dice)
}

# first roll()
cat('First Roll:', roll2())


# User-defined function 3: roll3(data)
# function with one required argument 
# when calling the function the argument must be provided
roll3 <- function(dice) {
  dice <- sample(dice, size = 2, replace = TRUE)
  sum(dice)
}

roll3(dice = 1:6)
roll3(dice = 1:12)
roll3(dice = 1:24)

# Function in R: Continued...

# function which prints the chunk of given character vector best_practice
best_practice <- c('Let', 'the', 'computer', 'do', 'the', 'work')
print_words <- function(sentence) {
  print(sentence[1])
  print(sentence[2])
  print(sentence[3])
  print(sentence[4])
  print(sentence[5])
  print(sentence[6])
}

print_words(best_practice)
print_words(best_practice[-6])
best_practice[-6]


# for loops in R
# for (variable in collection) {
#   do things with variable
# }
print_words <- function(sentence) {
  for (word in sentence) {
    print(word)
  }
}
  
print_words(best_practice)
print_words(best_practice[-6])

# Conditionals in R
if (y < 20) {
  x <- "Too low"
} else {
  x <- "Too high"
}

# if else in R
check.y <- function(y) {
  if (y < 20) {
    print("Too Low")
  } else {
    print("Too High")
  }
}
check.y(10)
check.y(30)
# binary variables using `ifelse`
y <- 1:40
ifelse(y<20, 'Too low', 'Too high')
# logical 
ifelse(y<20, TRUE, FALSE)
# binary 
y <- 1:40
ifelse(y<20, 1, 0)

# multiple if else conditions
if (this) {
  # do that
} else if (that) {
  # do something else
} else if (that) {
  # do something else
} else{
  # remaining
}

check.x <- function(x=1:99){
  if (x<20){
    print("Less than 20")
  }
  else {
    if (x < 40){
      print("20-39")
    }
    else {
      print("40-99")
    }
  }
}

check.x(15)
check.x(30)
check.x(45)

x <- 1:99
x1 <- ifelse(x<20, 1,0) 
x2.1 <- ifelse(x<20, '<20', '20+')

x3 <- ifelse(x<20,1,ifelse(x<40,2,3))
x3
# represents the frequency distribution of categorical data.
# It essentially counts the occurrences of unique values within a dataset and presents the result in a tabular format.
table(x3)



# Petal. Length categories is created from Petal. Length variable of iris data frame using within
# within Evaluate an Expression in a Data Environment like list or dataframe

iris <- within(iris, {
  Petal.cat <- NA
  Petal.cat[Petal.Length < 1.6] <- "Small"
  Petal.cat[Petal.Length >= 1.6 &
              Petal.Length < 5.1] <- "Medium"
  Petal.cat[Petal.Length >= 5.1] <- "Large"
})

iris$Petal.cat
table(iris$Petal.cat)


# Multiple Conditions: If, else if, else if, else if
temp <- function(x) {
  if (temp <= 0) {
    "freezing"
  }
  else if (temp <= 10) {
    "cold"
  }
  else if (temp <= 20) {
    "cool"
  }
  else if (temp <= 30) {
    "warm"
  }
  else {
    "hot"
  }
}