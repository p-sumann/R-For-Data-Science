
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

# independent variable
X <- matrix(rnorm(n * p), n, p)

# dependent variable
y <- rnorm(n) + X %*% runif(p)

# Create a data frame
df <-
  data.frame(
    y = y,
    X1 = X[, 1],
    X2 = X[, 2],
    X3 = X[, 3],
    X4 = X[, 4],
    X5 = X[, 5]
  )

# assumptions of bivariate linear regression model
# 

# assumptions of multivariate linear regression model

# bi variate regression
lm(y~X1, data=df)
lm(y~X2, data=df)
lm(y~X3, data=df)
lm(y~X4, data=df)
lm(y~X5, data=df)


mlr <- lm(y ~ ., data=df)

summary(mlr)
library(car)

# all assumptions of linear regression must be true
# vif
cor(train_set)
vif(mlr)

# blue
summary(mlr)

# Coefficient of determination > 0.50
# Multiple R-squared:  0.5914

# Regression ANOVA must be
# significant statistically
Anova(mlr)

# Y-intercept (a) an slope (b) must be
# statistically significant
summary(mlr)

# now that we have passed the BLUE test/ now we do line test
# Linearity of residuals: Do it!
plot(lm1, which=1, col=c("blue")) #sugeestive
summary(lm1$residuals) # confirmative

# Independence of residuals:
acf(lm1$residuals)
library(car)
durbinWatsonTest(lm1) # confirmation

# Normality of residuals:
plot(lm1, which=2, col=c("blue"))
shapiro.test(lm1$residuals)
# If the p-value > 0.05, residuals follow the normal distributions
# • If the p-value <= 0.05, residuals do not follow the normal distribution

# If the p-value > 0.05, no autocorrelation
# • If the p-value <= 0.05, autocorrelation present


plot(lm1, which=3, col=c("blue"))
library(lmtest)
bptest(lm1)
# If the p-value > 0.05, residual variances are equal (homoscedasticity)
# • If the p-value <= 0.05, residual variances are not equal (heteroscedasticity)

pred_set <- data.frame(
  X1 = runif(10, min = -2.5, max = 2.5),
  X2 = runif(10, min = -2.5, max = 2.5),
  X3 = runif(10, min = -2.5, max = 2.5),
  X4 = runif(10, min = -2.5, max = 2.5),
  X5 = runif(10, min = -2.5, max = 2.5)
)

predict(mlr, pred_set)

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


train_index <- sample(1:n, 0.7 * n, replace = FALSE)
X_train <- df[train_index,]
y_train <- y[train_index]
X_test <- cbind(X1[-train_index], X2[-train_index], X3[-train_index], X4[-train_index], X5[-train_index])
y_test <- y[-train_index]



























set.seed(33)
# Generate the data
n <- 200
p <- 5

# independent variable
X <- matrix(rnorm(n * p), n, p)

# dependent variable
y <- rnorm(n) + X %*% runif(p)

# Create a data frame
df <-
  data.frame(
    y = y,
    X1 = X[, 1],
    X2 = X[, 2],
    X3 = X[, 3],
    X4 = X[, 4],
    X5 = X[, 5]
  )

# Split the data into training and test sets
train_index <- sample(1:n, 0.7 * n, replace = FALSE)
df_train <- df[train_index, ]
df_test <- df[-train_index, ]

# Fit the bivariate linear regression models
lm1 <- lm(y~X1, data=df_train)
lm2 <- lm(y~X2, data=df_train)
lm3 <- lm(y~X3, data=df_train)
lm4 <- lm(y~X4, data=df_train)
lm5 <- lm(y~X5, data=df_train)

lm5

# fit the multivariate linear regression model
multivariate_model <- lm(y ~ X1 + X2 + X3 + X4 + X5, data = df_train)


library(car)

cor(df_train)
vif(multivariate_model)

library(lmtest)
bptest(multivariate_model)
dwtest(multivariate_model)

# Predict for the test data
bivariate_pred <- predict(bivariate_model, newdata = df_test)
multivariate_pred <- predict(multivariate_model, newdata = df_test)


train_index <- sample(1:nrow(df), 0.7*nrow(df))
train_data <- df[train_index, ]
test_data <- df[-train_index, ]

# Scale the independent variables
library(caret)
preproc <- preProcess(train_data[, -1], method = c("center", "scale"))
train_scaled <- cbind(train_data[, 1], predict(preproc, train_data[, -1]))
test_scaled <- cbind(test_data[, 1], predict(preproc, test_data[, -1]))
colnames(train_scaled) <- colnames(test_scaled) <- colnames(df)

multivariate_model <- lm(y ~ X1 + X2 + X3 + X4 + X5, data = train_scaled)

multivariate_pred <- predict(multivariate_model, newdata = test_scaled)
multivariate_r2 <- R2(multivariate_pred, test_data$y)
multivariate_rmse <- RMSE(multivariate_pred, test_data$y)


# Fit the KNN, SVR, and ANN models
library(caret)
library(e1071)
library(nnet)

# KNN
knn_model <- train(y ~ X1 + X2 + X3 + X4 + X5, data = train_scaled, method = "knn")
knn_pred <- predict(knn_model, newdata = test_scaled)
knn_r2 <- R2(knn_pred, test_data$y)
knn_rmse <- RMSE(knn_pred, test_data$y)

# SVR
svr_model <- svm(y ~ X1 + X2 + X3 + X4 + X5, data = train_scaled, type = "eps-regression")
svr_pred <- predict(svr_model, newdata = test_scaled)
svr_r2 <- R2(svr_pred, test_data$y)
svr_rmse <- RMSE(svr_pred, test_data$y)

# ANN
ann_model <- train(y ~ X1 + X2 + X3 + X4 + X5, data = train_scaled, method = "nnet")
ann_pred <- predict(ann_model, newdata = test_scaled)
ann_r2 <- R2(ann_pred, test_data$y)
ann_rmse <- RMSE(ann_pred, test_data$y)


# Create a data frame to store the results
results <- data.frame(
  Model = c("Multivariate Linear Regression", "KNN", "SVR", "ANN"),
  R2 = c(multivariate_r2, knn_r2, svr_r2, ann_r2),
  RMSE = c(multivariate_rmse, knn_rmse, svr_rmse, ann_rmse)
)