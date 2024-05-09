
set.seed(33)  # Replace with your roll number

# Assumptions
# All the assumptions of the simple
# linear regression are also
# applicable here
# There is one more condition:
# Multicollinearity must not be
# present i.e. correlations between
# independent variables

# Generate the data

n <- 200
p <- 5
X <- matrix(rnorm(n * p), n, p)
y <- rnorm(n) + X %*% runif(p)

# Create a dataframe
df <- data.frame(y = y, X1 = X[, 1], X2 = X[, 2], X3 = X[, 3], X4 = X[, 4], X5 = X[, 5])

lm(y~X1, data=df)
lm(y~X2, data=df)
lm(y~X3, data=df)
lm(y~X4, data=df)
lm(y~X5, data=df)


mlr <- lm(y ~ ., data=df)

summary(mlr)
library(car)

vif(mlr)



train_index <- sample(nrow(df), 0.7*nrow(df))
test_index <- setdiff(1:nrow(df), train_index)

train_set <- df[train_index, ]
test_set <- df[test_index, ]

# validation approach
library(caret)
library(dplyr)
lm1 <- lm(y ~ ., data=train_set)
predict1 <- lm1 %>% predict(test_set)
R2(predict1, test_set$y)
RMSE(predict1, test_set$y)
summary(lm1)


# LOOCV
lm2 <- train(y ~ ., data=df, method='lm',trainControl=trainControl(method = "LOOCV"))
predict2 <- lm2 %>% predict(test_set)
R2(predict1, test_set$y)
RMSE(predict2, test_set$y)


# Kfold cv
lm3 <- train(y ~ ., data=df, method='lm',trainControl=trainControl(method = "cv"))
lm3
predict3 <- lm3 %>% predict(test_set)
R2(predict3, test_set$y)
RMSE(predict3, test_set$y)

# repeated Kfold cv
lm4 <- train(y ~ ., data=df, method='lm',trainControl=trainControl(method = "repeatedcv"))
lm4
predict4 <- lm4 %>% predict(test_set)
R2(predict4, test_set$y)
RMSE(predict4, test_set$y)



