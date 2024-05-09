
set.seed(33)  # Replace with your roll number

# Generate the data

# independent variable
n <- 200
p <- 5
X <- matrix(rnorm(n * p), n, p)

# independent variable
y <- rnorm(n) + X %*% runif(p)


