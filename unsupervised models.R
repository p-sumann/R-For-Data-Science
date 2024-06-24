# PCA looks to find a low- dimensional representation of the 
# observations that explain a good 
# fraction of the variance;

# Clustering looks to find 
# homogeneous subgroups among 
# the observations or cases.


# In K-means clustering, we seek 
# to partition the observations 
# into a pre-specified number of 
# clusters.


# On the other hand, in 
# hierarchical clustering, we do 
# not know in advance how many 
# clusters we want and we use 
# “dendogram” to find the 
# number of clusters for the data


set.seed(33)

x <- matrix(rnorm(50*2),ncol=2)
x[1:25,1]<-x[1:25,1]+3
x[1:25,2]<-x[1:25,2]-4


par(mfrow=c(1,2))
km.out1 <- kmeans(x, 2, nstart = 20)

km.out$cluster

plot(
  x,
  col = (km.out1$cluster + 1),
  main = "K-Means Clustering
Results with K = 2",
  xlab = "",
  ylab = "",
  pch = 20,
  cex =
    2
)


# kmean for 3 clusters
km.out2 <- kmeans(x, 3, nstart = 20)
km.out


plot(x, col = (km.out2$cluster + 1),
     main = "K-Means Clustering 
Results with K = 3",
     xlab = "", ylab = "", pch = 20, cex = 
       2)


# k mean clustering with iris dataset

set.seed(33)
data("iris")
str(iris)

iris_1 <- iris[,-5]

kmeas_iris <- kmeans(iris_1,centers=3,nstart=20)
kmeas_iris

# confusion matrix for dependent variable
