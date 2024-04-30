

die <- 1:6
print(sample(x=die, size=1))
print(sample(x=die, size=1))
sample(x=die, size=1, replace = TRUE)

sample(x=die, size=2)
sample(x=die, size=2)
sample(x=die, size=2)

# iris = read.csv("iris.csv")
iris = read.csv('iris.csv')
set.seed(123)
tt.sample <- sample(c(TRUE, FALSE), nrow(iris), replace = T, prob = c(0.7, 0.3))
train <- iris[tt.sample,]
test <- iris[!tt.sample,]

roll_a_die <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  dice
  sum(dice)
}
roll_a_die()
roll2 <- function(dice = 1:6){
  dice <- sample(dice, size = 2, replace = TRUE)
  sum(dice)
}
roll2()

roll3 <- function(dice){
  dice <- sample(dice, size = 2, replace = TRUE)
  sum(dice)
}
roll3(1:12)

best_practices <- c("Let", "the", "computer", "do", "the", "work")
print_words <- function(sentence) {
  print(sentence[1])
  print(sentence[2])
  print(sentence[3])
  print(sentence[4])
  print(sentence[5])
  print(sentence[6])
}
print_words(best_practices) 
print_words(best_practices[-6])
best_practices[-6]
# loops in R

print_words <- function(sentence) {
  for (word in sentence) {
    print(word)
  }
}
print_words(best_practices)

check.y <- function(y) {
  if (y < 20) {
    print("too low")
  } else {
    print("two high")
  }
}
check.y(10)
#ifelse
y <- 1:40
ifelse(y<20, 'Too Low','Too High')
ifelse(y < 20, TRUE, FALSE)
ifelse(y < 20, 1, 0)

check.x <- function(x = 1:99) {
  if (x < 20) {
    print("Less than 20")
  } else if (x < 40) {
    print("20-39")
  } else {
    print("41-99")
  }
}
x <- 1:99
check.x(10)
x3 <- ifelse(x<20,1,ifelse(x<40,2,3))
table(x3) #gives frequency distribution


iris <- within(iris,{
  Petal.cat <- NA
  Petal.cat[Petal.Length < 1.6] <- "Small"
  Petal.cat[Petal.Length >= 1.6 & Petal.Length < 5.1] <- "Medium"
  Petal.cat[Petal.Length >= 5.1] <- "Large"
})
iris$Petal.cat
table(iris$Petal.cat)

sink()
