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

cm <- table(iris$Species,kmeas_iris$cluster)
cm

accuracy <- sum(diag(cm)/sum(cm))

mce <- 1 - accuracy

accuracy
mce

# plot k means
par(mfrow=c(1,1))
plot(iris_1[c("Sepal.Length", 
              "Sepal.Width")],
     col = kmeas_iris$cluster,
     pch = 20,
     main = "K-means with 3 
clusters")
points(kmeas_iris$centers[, c("Sepal.Length","Sepal.Width")], 
        pch = 8, 
        cex = 3)


# clusters with centers
library(cluster)



clusplot(
  iris_1[, c("Sepal.Length", "Sepal.Width")],
  kmeas_iris$cluster,
  lines = 0,
  shade = TRUE,
  color = TRUE,
  labels = 2,
  plotchar = FALSE,
  span = TRUE,
  main = paste("Cluster iris"),
  xlab = 'Sepal.Length',
  ylab = 'Sepal.Width'
)


# Hierarchical cluster analysis (HCA):
# One potential disadvantage of K- means clustering is that it requires
# us to pre-specify the number of
# clusters K.

# Hierarchical clustering is an
# alternative approach which does
# not require that we commit to a
# particular choice of K.


# Hierarchical clustering has an
# added advantage over K-means
# clustering in that it results in an
# attractive tree-based
# representation of the observations,
# called a dendrogram.


# The hierarchical clustering 
# dendrogram is obtained via an 
# extremely simple algorithm.
# • We begin by defining some sort 
# of dissimilarity measure 
# between each pair of 
# observations. Most often, 
# Euclidean distance is used. 
# • The algorithm proceeds 
# iteratively. 
# • Starting out at the bottom of the 
# dendrogram, each of the n 
# observations is treated as its 
# own cluster.


# US arrest single linkage HCA

data <- USArrests[,-3]
state.disimilarity <- dist(data)

single_hca <- hclust(state.disimilarity,method = 'single')

plot(single_hca, 
     labels=rownames(data), 
     ylab="Distance")

complete_hca <- hclust(state.disimilarity,method = 'complete')

plot(complete_hca, 
     labels=rownames(data), 
     ylab="Distance")
