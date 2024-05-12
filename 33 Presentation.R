set.seed(33)

n <- 200
X1 <- rnorm(n, mean = 0, sd = 1)
X2 <- rnorm(n, mean = 0, sd = 1)
X3 <- rnorm(n, mean = 0, sd = 1)
X4 <- rnorm(n, mean = 0, sd = 1)
X5 <- rnorm(n, mean = 0, sd = 1)
y <- 2 + 3 * X1 + 4 * X2 - 2 * X3 + 1.5 * X4 + 2 * X5 + rnorm(n, mean = 0, sd = 1)

data <- data.frame(y, X1, X2, X3, X4, X5)

train_index <- sample(1:nrow(data), 0.7 * nrow(data))
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

bivariate_model <- lm(y ~ X1, data = train_data)

multivariate_model <- lm(y ~ X1 + X2 + X3 + X4 + X5, data = train_data)