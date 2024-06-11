# Part I: Use NCI60 data of ISLR2 package and page 540 of ISLR2 book to do as follows in R Studio
# to knit PDF output:
  
# Define nci labels (NCI$labs) as nci.labs and nci data (NCI$data) and nic.data
# Check dimension of nci.data object and interpret it carefully
# Check first four cancer types using nci.labs object
# Fit principal component analysis (PCA) on nci.data with scale = TRUE argument as pr.out object
# Create a plot showing first three PCA components with three different colors
# Get summary of pr.out object and interpret it carefully
# Plot pro.out object and interpret it carefully
# Create custom scatterplots with principal components in x-axis and proportion variance explained
# (PVE) in y-axis for the first plot and cumulative PVE in the y-axis for the second plot 
# and interpret them carefully
# Perform PCA with varimax rotation and compare it with the PCA result obtained above
# Write summary of the results and conclusion based on your findings


# a. Define nci labels (NCI$labs) as nci.labs and nci data (NCI$data) as nic.data

library(ISLR2)
nci.labs <- NCI60$labs
nci.data <- NCI60$data

# b. Check dimension of nci.data object and interpret it carefully
dim(nci.data)# The data has 64 rows and 6,830 columns.


# c. Check first four cancer types using nci.labs object
nci.labs[1:4]
table(nci.labs)

# d. Fit principal component analysis (PCA) on nci.data with scale = TRUE argument as
# pr.out object
pr.out <- prcomp(nci.data, scale = TRUE)


# e. Create a plot showing first three PCA components with three different colors
Cols <- function(vec) {
  cols <- rainbow(length(unique(vec)))
  return(cols[as.numeric(as.factor(vec))])
}

# Adjusting figure margins
par(mar = c(1, 1, 1, 1)) 
par(mfrow = c(1, 2))
plot(pr.out$x[, 1:2], col = Cols(nci.labs), pch = 19,
     xlab = "Z1", ylab = "Z2")
plot(pr.out$x[, c(1, 3)], col = Cols(nci.labs), pch = 19,
     xlab = "Z1", ylab = "Z3")

# On the whole, cell lines corresponding to a single cancer type do tend to have similar
# values on the first few principal component score vectors. This indicates that cell 
# lines from the same cancer type tend to have pretty similar gene expression levels.
# f. Get summary of pr.out object and interpret it carefully
summary(pr.out)


# g. Plot pro.out object and interpret it carefully
plot(pr.out)
# the height of each bar in the bar plot is given by squaring the corresponding 
# element of pr.out$sdev.


# h. Create custom scatter plots with principal components in x-axis and proportion
# variance explained (PVE) in y-axis for the first plot and cumulative PVE in the y-axis
# for the second plot and interpret them carefully
pve <- 100 * pr.out$sdev^2 / sum(pr.out$sdev^2)
par(mfrow = c(1, 2))


plot(pve, type = "o", ylab = "PVE",
     xlab = "Principal Component", col = "blue")
plot(cumsum(pve), type = "o", ylab = "Cumulative PVE",
     xlab = "Principal Component", col = "brown3")

# Interpretation: We see that together, the first seven principal components explain
# around 40 % of the variance in the data. This is not a huge amount of the variance.
# However, looking at the scree plot, we see that while each of the first seven principal
# components explain a substantial amount of variance, there is a marked decrease in 
# the variance explained by further principal components. That is, there is an elbow in
# the plot after approximately the seventh principal component. This suggests that there
# may be little benefit to examining more than seven or so principal components (though
# even examining seven principal components may be difficult).

# i. Perform PCA with varimax rotation and compare it with the PCA result obtained above
library(psych)

pca.varimax <- principal(nci.data, nfactors = 7, rotate = "varimax", scores = TRUE)
pca.varimax

# Comparing PCA with varimax rotation to the original PCA results:
# Varimax rotation maximizes the sum of the variance of the squared loadings, making
# the interpretation easier.
# However, it does not change the amount of variance explained by the components.


# j. Write summary of the results and conclusion based on your findings
# Summary:
# 1. The NCI60 data set contains gene expression levels for 64 cancer cell lines and
# 6,830 genes.
# 2. PCA was performed on the data, revealing that the first few principal components
# explain a substantial amount of variance.
# 3. A scree plot and cumulative PVE plot indicate that the first seven principal 
# components account for around 40% of the variance in the data.
# 4. The first three principal components were visualized, showing that cell lines fr
# om the same cancer type tend to cluster together.
# 5. PCA with varimax rotation was also performed for comparison, confirming the 
# interpretability of rotated components without changing the variance explained.

# Conclusion:
# PCA is a valuable tool for reducing dimensionality and identifying patterns in high
# -dimensional data such as gene expression levels. The results suggest that a few
# principal components capture significant patterns in the data, and varimax rotation aids
# in interpretability. Further analysis can be conducted to understand the biological 
# significance of these patterns.


# Part II: Use the distance between 10 US cities provided below in R Studio to knot
# PDF output:

# a. Get dissimilarity distance as city.dissimilarity object
# Step 1: Define the distance matrix
# Distance matrix for 10 US cities

city_distances <- matrix(c(
  0, 587, 1212, 701, 1936, 604, 748, 2139, 2182, 543,
  587, 0, 920, 940, 1745, 1188, 713, 2182, 2234, 597,
  1212, 920, 0, 879, 1949, 1726, 1631, 949, 1021, 1494,
  701, 940, 879, 0, 2394, 968, 1420, 2420, 2442, 597,
  1936, 1745, 1949, 2394, 0, 2300, 1645, 347, 403, 2339,
  604, 1188, 1726, 968, 2300, 0, 781, 2372, 2420, 1121,
  748, 713, 1631, 1420, 1645, 781, 0, 1923, 1960, 688,
  2139, 2182, 949, 2420, 347, 2372, 1923, 0, 214, 2571,
  2182, 2234, 1021, 2442, 403, 2420, 1960, 214, 0, 2534,
  543, 597, 1494, 597, 2339, 1121, 688, 2571, 2534, 0),
  nrow = 10, byrow = TRUE)

# City names
city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami", 
                "New York", "San Francisco", "Seattle", "Washington")
# Assign row and column names to the distance matrix
rownames(city_distances) <- city_names
colnames(city_distances) <- city_names
# Convert to a distance object
(city.dissimilarity <- as.dist(city_distances))

# b. Fit a classical multidimensional model using the city.dissimilarity object
city_mds <- cmdscale(city.dissimilarity, eig = TRUE, k = 2)
# c. Get the summary of the model and interpret it carefully
# Get the MDS coordinates
mds_coordinates <- city_mds$points
# Print the summary of the model
summary(city_mds)

# Interpretation: The summary includes the eigenvalues, which indicate the amount of
# variance captured by each dimension.
# eigenvalues <- city_mds$eig
# variance_explained <- eigenvalues / sum(eigenvalues) * 100
# variance_explained


# d. Get the bi-plot of the model and interpret it carefully
# Plot the MDS result
plot(mds_coordinates, type = "n", xlab = "Coordinate 1", ylab = "Coordinate 2",
     main = "Classical MDS of US Cities")
text(mds_coordinates, labels = rownames(mds_coordinates), col = "blue")



# Part III: Part I: Use NCI60 data of ISLR2 package and page 543 of ISLR2 book to
# do as follows in R Studio to knit PDF output:

# a. Scale the nci.data as sd.data object
sd.data <- scale(nci.data)

# b. Fit hierarchical cluster analysis on the sd.data using complete, average and single 
# linkage methods, show the results with dendrogram and interpret them carefully
par(mfrow = c(1, 3))
data.dist <- dist(sd.data)
plot(hclust(data.dist), xlab = "", sub = "", ylab = "",
     labels = nci.labs, main = "Complete Linkage")
plot(hclust(data.dist, method = "average"),
     labels = nci.labs, main = "Average Linkage",
     xlab = "", sub = "", ylab = "")
plot(hclust(data.dist, method = "single"),
     labels = nci.labs, main = "Single Linkage",
     xlab = "", sub = "", ylab = "")

# Interpretation:The choice of linkage certainly does affect the results obtained. 
# Typically, single linkage will tend to yield trailing clusters: very large clusters 
# onto which individual observations attach one-by-one. On the other hand, complete and 
# average linkage tend to yield more balanced, attractive clusters. For this reason, 
# complete and average linkage are generally preferred to single linkage. Clearly cell lines
# within a single cancer type do tend to cluster together, although the clustering is
# not perfect. We will use complete linkage hierarchical clustering for the analysis that follows
# We can cut the dendrogram at the height that will yield a particular number of clusters, say four.


# c. Find the best number for clusters using “cutree” function with best distance value
# Let's use the complete linkage method for this example

hc.out <- hclust(dist(sd.data))
hc.clusters <- cutree(hc.out, 4)
table(hc.clusters, nci.labs)


# There are some clear patterns. All the leukemia cell lines fall in cluster 3, while
# the breast cancer cell lines are spread out over three diferent clusters. We can plot
# the cut on the dendrogram that produces these four clusters:
par(mfrow = c(1, 1))
plot(hc.out, labels = nci.labs)
abline(h = 139, col = "red")


# Printing the output of hclust 
hc.out


# d. Use your roll number as set.seed and perform k-means clustering on sd.data with
# the best number of clusters/distance value with nstart=20
set.seed(30)
km.out <- kmeans(sd.data, 4, nstart = 20)
km.clusters <- km.out$cluster
table(km.clusters, hc.clusters)

# Interpretation: The four clusters obtained using hierarchical clustering and Kmeans
# clustering are somewhat different. Cluster 2 in K-means clustering is identical to
# cluster 1 in hierarchical clustering. However, the other clusters differ: for instance,
# cluster 3 in K-means clustering contains a portion of the observations assigned to 
# cluster 4 by hierarchical clustering, as well as all of the observations assigned to 
# cluster 3 by hierarchical clustering. Rather than performing hierarchical clustering on
# the entire data matrix, we can simply perform hierarchical clustering on the frst few
# principal component score vectors, as follows:


# e. Get summary of the k-means clustering and interpret them carefully
summary(km.out)


# f. Plot this k-means results using base r plot and cluster package and interpret them carefully
par(mfrow = c(1, 2))
plot(sd.data, col = km.out$cluster, main = "K-means Clustering Results", pch = 20)
points(km.out$centers, col = 1:4, pch = 8, cex = 2)
par(mfrow=c(1,1))



# Part IV: Use “Groceries” data available in the “datasets” package to do as follows
# in R Studio to knit PDF output

# a. Load “arules” and “arulesViz” libraries
library(arules)
library(arulesViz)
# b. Load “Groceries” data, check its structure and interpret it carefully
data("Groceries")
str(Groceries)
summary(Groceries)

# Interpretation: The Groceries dataset is a sparse matrix of transactions, where each
# row represents a transaction and each column represents an item. The summary gives
# an overview of the number of transactions, the number of items, and some basic statistics.
# c. Get Frequent Item frequencies using itemFrequencyPlot function and interpret it carefully.

itemFrequencyPlot(Groceries, topN = 20, type = "absolute")

# Interpretation: This plot shows the absolute frequencies of the top 20 items. Items
# like "whole milk" and "other vegetables" are among the most frequently purchased items

# d. Set a priori rule with support = 0.001 and confidence = 0.8 and interpret the output carefully
rules <- apriori(Groceries, parameter = list(support = 0.001, confidence = 0.8))
summary(rules)

# Interpretation: The apriori algorithm generates association rules based on the specified
# minimum support and confidence. The summary provides the number of rules generated
# and basic statistics like minimum, maximum, and average support and confidence.

# e. Show the top five rules using inspect and round the results to two digits
inspect(head(rules, 5))

# f. Sort the rule by confidence in decreasing order
rules <- sort(rules, by = "confidence", decreasing = TRUE)
inspect(head(rules, 5))

# g. Use “whole milk” as target item and show the items in “lhs” with decreasing order
# of confidence and show the top five rules

rules_lhs <- subset(rules, lhs %pin% "whole milk")
rules_lhs <- sort(rules_lhs, by = "confidence", decreasing = TRUE)
inspect(head(rules_lhs, 5))


# h. Use “whole milk” as target item and show the items in “rhs” with decreasing order
# of confidence and show the top five rules
rules_rhs <- subset(rules, rhs %pin% "whole milk")
rules_rhs <- sort(rules_lhs, by = "confidence", decreasing = TRUE)
inspect(head(rules_rhs, 5))


# i. Write summary and conclusion based on your findings above
# Based on the analysis, the "Groceries" data reveals several interesting associations:
  # 1.Frequent Items: Items like "whole milk" and "other vegetables" are among the most
  # frequently purchased.
# 2. Association Rules: Setting a minimum support of 0.001 and confidence of 0.8, we
# generated a significant number of rules, indicating strong associations among items.
# 3. Top Rules: By inspecting the top rules, we can see high-confidence associations,
# such as items frequently bought together with "whole milk."
# 4. Targeted Rules: When "whole milk" is the target item in the LHS or RHS, the rule
# s show high confidence and lift, highlighting items that are commonly bought with "whole milk."
# Overall, the analysis provides valuable insights into customer purchasing behavior,
# which can be leveraged for marketing strategies and inventory management.


