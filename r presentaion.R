
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



