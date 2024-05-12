# Set the random seed
set.seed(25)

# Generate 200 random data with one continuous dependent variable and five independent variables
n <- 200
X1 <- rnorm(n)
X2 <- rnorm(n)
X3 <- rnorm(n)
X4 <- rnorm(n)
X5 <- rnorm(n)
y <- 2 + 3*X1 + 4*X2 - 2*X3 + 5*X4 - 3*X5 + rnorm(n, 0, 2)

# Create the data frame
df <- data.frame(y, X1, X2, X3, X4, X5)

# Split the data into training and test sets
train_index <- sample(1:nrow(df), 0.7*nrow(df))
train_data <- df[train_index, ]
test_data <- df[-train_index, ]

# Scale the independent variables
library(caret)
preproc <- preProcess(train_data[, -1], method = c("center", "scale"))
train_scaled <- cbind(train_data[, 1], predict(preproc, train_data[, -1]))
test_scaled <- cbind(test_data[, 1], predict(preproc, test_data[, -1]))
colnames(train_scaled) <- colnames(test_scaled) <- colnames(df)

# Fit the bivariate and multivariate linear regression models
bivariate_model <- lm(y ~ X1, data = train_scaled)
multivariate_model <- lm(y ~ X1 + X2 + X3 + X4 + X5, data = train_scaled)

# Check the VIF
library(car)
vif(multivariate_model)

# Check BLUE and LINEX
library(lmtest)
bptest(multivariate_model)
dwtest(multivariate_model)

# Predict for the test data
bivariate_pred <- predict(bivariate_model, newdata = test_scaled)
multivariate_pred <- predict(multivariate_model, newdata = test_scaled)

# Compute R-squared and RMSE for the test data
library(caret)
bivariate_r2 <- R2(bivariate_pred, test_data$y)
bivariate_rmse <- RMSE(bivariate_pred, test_data$y)
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
  Model = c("Bivariate Linear Regression", "Multivariate Linear Regression", "KNN", "SVR", "ANN"),
  R2 = c(bivariate_r2, multivariate_r2, knn_r2, svr_r2, ann_r2),
  RMSE = c(bivariate_rmse, multivariate_rmse, knn_rmse, svr_rmse, ann_rmse)
)

# Print the results
print(results)