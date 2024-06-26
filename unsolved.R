# 2080 q6 our batch

# question number 6
# a
# column vector X from 1 to 30
X <- 1:30


# b
# column vector Y of cubes of vector Y
Y <- X ^ 3

# c
# converted the the X, Y in dataframe
DF <- data.frame(X=X,Y=Y)

# d
# plotted a scatter plot to see relationship between X and Y
plot(X,Y)

# e
# Since there was no linear relationship we take log of X and Y
logX <- log(X)
logY <- log(Y)

plot(logX, logY)

# Interpretation
# Created a vector X with Numbers between 1 and 30
# Created a vector Y with Numbers with cubes of vector 3
# Created a new data.frame called DF with vectors X and Y
# Created a scatter plot of X and Y and it is seen that there no linear relationship between X and Y.
# Converted the values log to make it linear and then plotted scatter plot again

# question number 7
# a
set.seed(33)
roll <- function(die=1:6){
  sample(die, size=2, replace = T)
}

# b
# first roll
roll()

# c
# second roll
roll()

# d
# third roll
roll()

# e
# given a die with sample size two everything we roll we get different rolls in dice
# mimicing the real world dice game

# Interpretation
# Created a function roll() which has arguments as die = 1:6, the die is rolled twice with replacement, to achieve that I have used sample function.
# Rolled a die first time and result was 2 and 6
# Rolled a die second time and result was 4 and 1
# Rolled a die first time and result was 2 and 4
# Given a die with sample size two everything we roll we get different rolls in dice mimicking the real world dice game. And every time we roll we will different outcomes and also because replacement is set to true we might get same roll twice occasionally as well.


# qnuestion number 8

library(tidyverse, warn.conflicts = F)

# a
country_data <- tibble(
  Country = sample(x = c("Nepal","India","USA"),size = 10, replace = T),
  Year = sample(x=c(2000,2001,2003),size=10,replace = T),
  Cases = sample(c(9999:19999),size = 10),
  Population = sample(c(999999:999999),size = 10),
)

# b
country_data_long <- country_data %>%
  pivot_longer(cols = c(Year, Population), names_to = "Year", values_to = "Value")

print(country_data_long)

# c 
country_data$LnCase <- log(country_data$Cases)
country_data$LnPop <- log(country_data$Population)


# d
plot(country_data$Cases, country_data$Population)
plot(country_data$LnCase, country_data$Population)
plot(country_data$Cases, country_data$LnPop)
plot(country_data$LnCase, country_data$LnPop)

# e
par(mfrow=c(2,2))
plot(country_data$Cases, country_data$Population, main = "Cases Vs Population", xlab='Cases',ylab = 'Population',)
plot(country_data$LnCase, country_data$Population,main = "LnCases Vs Population", xlab='LnCases',ylab = 'Population')
plot(country_data$Cases, country_data$LnPop, main = "Cases Vs LnPopulation",xlab='Cases',ylab = 'LnPopulation')
plot(country_data$LnCase, country_data$LnPop,main = "LnCases Vs LnPopulation", xlab='LnCases',ylab = 'LnPopulation')
par(mfrow=c(1,1))

# Interpretation
# Created a tibble country_data from tidyverse using 10 variables for country, year, cases and population.
# Transformed the created data into long format using pivot_longer(), I have taken year and population columns to pivot it longer. Pivot longer increases the number of rows.
# Transformed the cases and population variable in log and assigned them in LnCase and LnPop.
# Created a scatter plot for all 4 i.e.
# Cases and Population
# LnCases and Population
# Cases and LnPopulation
# LnCases and LnPopulation
# plot the 4 plots in single graph window using par(mfrow=c(2,2)) and grid 2X2.

# question number 9
# a
df <- mtcars
hist(df$mpg)

# b
hist(df$mpg,col = 'blue', breaks=10)

# c
abline(v=mean(df$mpg), color='red',lwd=3,lty=2)

# d
qqnorm(df$mpg)
qqline(df$mpg, col='red', lwd=3)

# e
plot(density(df$mpg), type='n')
polygon(density(df$mpg), col='yellow', border = NA)

# Interpretation
# Plotted the histogram of mpg variable, by default R took 5 bins with interval of 5.
# Refined the histogram by filling the bars color with blue and created bin size 10.
# Added a vertical abline with mean of mpg variable.
# Created a qqplot to assess the distribution of the mpg variable and added QQ line with red color and it visually almost normally distributed and we can say that it is normally distributed as most of the data are fitted to those red line.
# LnCases and LnPopulation
# Plotted a density plot of mpg variable without border and filled it yellow color, the figure shows that data is falls under the area of normal distribution.

# question number 10

library(igraph, warn.conflicts = F)
library(Rgraphviz, warn.conflicts = F)
# a
g <- graph(c(1,2,3,4))

# b
plot(g)

# c
g1 <- graph(c("Sita","Ram","Sita","Gita","Gita","Sita","Sita",
              "Gita","Anita","Rita","Ram","Sita"))
# d
plot(g1, vertex.color='green',vertex.size=20,edge.size=10,edge.color='red')

# e
# degree
igraph::degree(g1)

# closeness
closeness(g1,mode = 'in')

# betweeness
betweenness(g1)

# Interpretation
# define a graph object g with (1,2,3,4)
# plotted a graph and we can see that 1 goes to 2 and 3 goes to 4 forming no cycle.
# define a graph object g1 with (“Sita”,“Ram”,“Sita”,“Gita”,“Gita”,“Sita”,“Sita”, “Gita”,“Anita”,“Rita”,“Ram”,“Sita”)) as its elements
# plotted a graph with all of the node color as green and node size as 20, edge color as red and link size as 10, we can see that ram has bi direction cycle between him and Sita, Sita has and Gita both of them has bi drection cycle between them, as Anita has direction going from her to Rita
# got the degree which show the adjacent edges between nodes,
# got the closeness which shows how many steps are required to access each vertex from given, here I have taken ‘in’
# got the betweenness which shows the numbers paths going thorough one particular vertex


# 2080 QN8 or
# a
set.seed(34)
# Number of cases
num_cases <- 250

# Generate random data for each variable
age <- sample(18:99, num_cases, replace = TRUE)

sex <- sample(c("male", "female"), num_cases, replace = TRUE)

education_levels <- sample(c("No education", "Primary", "Secondary", "Beyond Secondary"), num_cases, replace = TRUE)

soc_eco_status <- sample(c("Low", "Middle", "High"), num_cases, replace = TRUE)
bmi <- sample(14:38, num_cases, replace = TRUE)

data <- data.frame(
  Age = age,
  Sex = sex,
  EducationLevel = education_levels,
  SocioEconomicStatus = soc_eco_status,
  BMI = bmi
)

# b
# suggestive plot for normal distribution
qqnorm(data$BMI)
qqline(data$BMI)
# from the q-q plot we can see many data points are outliers so the data set are not normally distributed.

hist(data$BMI)

# conformative test
# ks_test_result <- ks.test(data$BMI, "pnorm", mean = mean(data$BMI), sd = sd(data$BMI))
# ks test if n>100
ks_test_result <- ks.test(data$BMI, "pnorm",mean = mean(data$BMI), sd = sd(data$BMI))
ks_test_result
# if p value is greater than 0.05 it follows normal distribution.
# since p value is less than 0.05 it does not follow normal distribution.


# shapiro.test in n<100
shapiro.test(data$BMI)



# c
# for equality of variance
library(car)
library(ggplot2)
head(data)
str(data)

#Suggestive plot
ggplot(data=data,mapping=aes(y=Sex,x=BMI))+
  geom_boxplot()

boxplot(bmi ~ sex, data = data, main = "BMI by Sex")
# since the length of whiskers of the boxplot are not same the variance of BMI  with sex donot seem to be equal.


# Conformitary test
data$Sex=as.factor(data$Sex)
(leveneTest(BMI ~Sex, data = data))
# since the value of Pr is greater than 0.05 the variance of BMI with sex is same.


# d
# If Pr(>F) is greater than 0.05, we assume equal variances use Student's t-test.


# if pr(<F) is less than 0.05 we assume unequal varaince and use welch t test.

#e
t.test(BMI ~ Sex, data = data, var.equal = TRUE)
# since p value is greater than 0.05 we accept alternative hypothesis i.e difference in means between group female and group male is not equal to 0

t.test(BMI ~ Sex, data = data, var.equal = FALSE)
# welch t test


# true difference in means between group female and group male is not equal to 0.
# if p value is less than 0.05 we accept null hypothesis.(ie.means between group female and group male is  equal to 0 )


# exam Q7

data<-airquality
head(data)

# a
# suggestive plot for normal distribution
qqnorm(data$Temp)
qqline(data$Temp)
# from the q-q plot we can see many data points are in qqline so the data set seem to be normally distributed.

hist(data$Temp)
# histogram shows that the data seem to be normally distributed although not perfect.

str(data)
# conformative test
# ks_test_result <- ks.test(data$BMI, "pnorm", mean = mean(data$BMI), sd = sd(data$BMI))
# ks test if n>100
ks_test_result <- ks.test(data$Temp, "pnorm",mean = mean(data$Temp), sd = sd(data$Temp))
ks_test_result
# if p value is greater than 0.05 it follows normal distribution.


# b
# for equality of variance
library(car)
library(ggplot2)
head(data)
str(data)

#Suggestive plot
ggplot(data=data,mapping=aes(y=factor(Month),x=Temp))+
  geom_boxplot()

boxplot(Temp ~ Month, data = data, main = "Temp by Month")
# since the length of whiskers of the boxplot are not same the variance of Temp  with Month donot seem to be equal.


# Conformitary test
data$Month=as.factor(data$Month)
data$Temp=as.numeric(data$Temp)
(leveneTest(Temp ~Month, data = data))
str(data)
# since the value of Pr is less than 0.05 the variance of Temp across month is not equal.



# c
# if Pr(>F) is less than 0.05 for more than two groups we use welch_anova
# if Pr(>F) is greater than 0.05 for more than two groups we use standard one way anova


# d
(welch_anova <- oneway.test(data$Temp~factor(data$Month), var.equal = FALSE))
# since p value is less than 0.05 means of Temp across month are not equal.



# if Pr(>F) is greater than 0.05 for more than two groups we use standard one way anova
welch_anova <- oneway.test(aq$Temp~factor(aq$Month), var.equal = TRUE)
welch_anova


(anova_model <- aov(Temp ~ Month, data = data))


# Apply TukeyHSD to the ANOVA model
tukey_result <- TukeyHSD(anova_model)
print(tukey_result)
# the pairs in  which p value is less than 0.05 ie. 6-5 has difference in mean temperature.
# the pairs in  which p value is less than 0.05 ie. 8-7 has no difference in mean temperature.





# Qn 8
# a
flower_scale<- iris[,-5]
head(flower_scale)
pr.out <- prcomp(flower_scale, scale = TRUE)


#b
pr.out

std_devs <- pr.out$sdev
std_devs
eigenvalues <- std_devs^2
eigenvalues
# SD of PC1...PC4 are 1.7083611 0.9560494 0.3830886 0.1439265
# eigenvalues of PC1...PC4 are are 2.91849782 0.91403047 0.14675688 0.02071484 which is square of SD
# according to kaisers rule we consider principal components with eigenvalues greater than 1 ie. PC1

# c
# Load necessary library
library(ggplot2)

# Create a data frame for plotting
plot(eigenvalues,type='o',xlab="Principal components")
abline(h=1,col="red")
abline(v=1,col="green")
# since the eigen value of PC1 is only grater than 1 as required by kaisers rule ...the PC1 is the component that describes the 
# which describes  maximum variance among all other components.

# d
library(FactoMineR)
pca.1 <- PCA(flower_scale, scale = TRUE, ncp = 3, graph = FALSE)
varimax_rot <- varimax(pca.1$ind$coord[,1:3])
varimax_rot
pr.out1 <- prcomp(varimax_rot$loadings, scale = TRUE)
pr.out1
std_devs1 <- pr.out1$sdev
std_devs1
eigenvalues1 <- std_devs1^2
eigenvalues1


# even after varimax rotation only one component has eigen value greater than 1 so we consider only one component
# as kaisers rule.
# thus varimax rotation does the bring any new conclusion even after re scaling.


# biplot of PCA model
biplot(pr.out)
pr.out

title("Bi plot of PCA")

# Each point on the biplot represents an observation (data point) in the new coordinate system preserving orgonal data
# with x axis as PC1 and y axis as PC2.

# The arrows (vectors) represent the original variables. 
# The direction and length of the arrows indicate how each variable contributes 
# to the principal components.

# A longer arrow means that the variable has a stronger contribution to the principal component.
# All the arrows has almost similar length so their contribution seems to be equal.

# The angle between the arrows and the axes indicates the correlation between 
# the variable and the principal component.A smaller angle means a higher correlation.
# Petal.Length and Petal.Width has higher angle with PC2 so it has low correlation but has higher coorelation with PC1.
# 


# QN  8 or

library(stats)

# Question a
city_distances <- matrix(c(
  0, 587, 1212, 701, 1936, 604, 748, 2139, 2182, 543,
  587, 0, 920, 940, 1745, 1188, 713, 1858, 1737, 597,
  1212, 920, 0, 879, 831, 1726, 1611, 1949, 2204, 1494,
  701, 940, 879, 0, 1374, 968, 1420, 1645, 1891, 1220,
  1936, 1745, 831, 1374, 0, 2339, 2451, 347, 2734, 2300,
  604, 1188, 1726, 968, 2339, 0, 1092, 2594, 2408, 923,
  748, 713, 1611, 1420, 2451, 1092, 0, 2571, 678, 205,
  2139, 1858, 1949, 1645, 347, 2594, 2571, 0, 678, 2442,
  2182, 1737, 2204, 1891, 2734, 2408, 678, 678, 0, 2329,
  543, 597, 1494, 1220, 2300, 923, 205, 2442, 2329, 0
), nrow = 10, byrow = TRUE)
# Create a distance matrix from the given data in the problem

city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami", "New York", "San Francisco", "Seattle", "Washington D.C.")
rownames(city_distances) <- city_names
colnames(city_distances) <- city_names
# Assigning names to row and columns
summary(city_distances)
city_dissimilarity <- as.dist(city_distances)
city_dissimilarity
# Convert to a dissimilarity object

# Question b
mds_model <- cmdscale(city_dissimilarity, eig = TRUE, k = 2)
mds_model
# Fit the classical MDS model using city.dissimilarity object
# the original location of the cities with respect to other cities are preserved in the new dimension 


# Question c
mds_coords <- mds_model$points
print(mds_coords)
summary(mds_coords)
# Summarizing the model
# these cordinate points preserve the original properties of the cities location


# Question d
plot(mds_coords, type = "n")
text(mds_coords, labels = city_names, cex = 0.7)
title("Classical MDS of US Cities")
# Bi-plot of the model
# the bi-plot shows the city map in two dimension where the oroginal distance disimilaty of cities is preserved.








# QN 10 or 


install.packages("ClusterR")
install.packages("cluster")
library(ClusterR)
library(cluster)
head(iris)
table(iris$Species)
iris_1<-iris[,-5]
sum(is.na(iris_1))
set.seed(34)
# observing the data set

## a

kmeans.c2<-kmeans(iris_1,centers = 2,nstart = 20)
kmeans.c2
# k mean clustering with two clusters
# it forms two clusters of sizes 53, 97

kmeans.c3<-kmeans(iris_1,centers = 3,nstart = 20)
kmeans.c3
# k mean clustering with three clusters
# it forms two clusters of sizes 50, 62, 38


## b
plot(iris_1[c("Sepal.Length", 
              "Sepal.Width")],
     col = kmeans.c3$cluster,
     main = "K-means with 3 
clusters")

plot(iris_1$Sepal.Length,iris_1$Sepal.Width,col=kmeans.c3$cluster)

# the plot for three clusters is formed
# each cluster is colored differently ie. black, red and green
# in plot some of the green and red are seen mixed which means points are not well clustered
# for better visualization sepal length and sepal width are considered for plotting


## c

kmeans.c3$centers
kmeans.c3$centers[, 
                  c("Sepal.Length", "Sepal.Width")]
plot(iris_1[c("Sepal.Length", 
              "Sepal.Width")],
     col = kmeans.c3$cluster,
     main = "K-means with 3 
clusters")

points(kmeans.c3$centers[, 
                         c("Sepal.Length", "Sepal.Width")],col = 1:3, pch= 8, cex= 5)

# the center of clusters with respect to sepal length and sepal width is found 
# the center is plotted with plot () function
# the center gives mean of each cluster

## d
(iris$Species[50])
(kmeans.c3$cluster[50])
cm<-table(iris$Species,kmeans.c3$cluster)
cm

(accuracy<-
    sum(diag(cm))/sum(cm))

# three clusters were compared using confusion matrix
# the cm gives that 50 of setosa , 48 of versicolor and 36 of virginica were clustered correctly
# 14 of virginica and 2 of versicolr are predicted incorrectly
# using confusion matrix accuracy was found to be 89.33 %






# QN 10


head(iris)
ir_label <- iris$Species
ir_data <- iris[,-5]
head(ir_data)

#a
# sd.data <- scale(ir_data)
data.dist <- dist(ir_data)
plot(hclust(data.dist,method = "single"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Single Linkage")

#b
plot(hclust(data.dist,method = "complete"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Complete Linkage")

#c
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

#d
# Best hierarchical model

plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

abline(h = 1.85, col = "red")


hc.out1 <- hclust(dist(ir_data),method = "single")
hc.out2 <- hclust(dist(ir_data),method = "complete")
hc.out3 <- hclust(dist(ir_data),method = "average")

hc.clusters1 <- cutree(hc.out1,3)
hc.clusters2 <- cutree(hc.out2,3)
hc.clusters3 <- cutree(hc.out3,3)


table(hc.clusters1, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters2, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters3, ir_label)
# only few of the virginica is incorrectly clustered as versicolor which is better than other methods.

plot(hc.out3, labels = ir_label,main = "Average Linkage (Best HCA model)")
abline(h = 1.85, col = "green")

# since the number of correctly represented data in dendrogram is formes in average method we prefer average method.




# Final 2078  6 OR
ggplot(data=diamonds,mapping=aes(x=carat,y=price))+
  geom_point(stat = "identity",position = "identity")+
  scale_x_continuous()+scale_y_continuous()+
  coord_cartesian()+
  labs(title="Scatter plot of price and carat")

# final 2078 6
set.seed(1)
mpg<-sample(c(10:50),500,replace = TRUE)
hist(mpg)
hist(mpg,col="blue",border = "white",breaks=8)
abline(v=mean(mpg),col="green")
qqnorm(mpg)
qqline(mpg,col="red")
# data are scatterd and it is randomally distributed
ks.test(mpg,"pnorm")

plot(density(mpg),col="yellow",frame=FALSE)
polygon(density(mpg),col="yellow")


#First term 6

x<-c(1:30)
y<-x^3
data<-data.frame(x,y)
plot(x,y)
plot(log(x),log(y))



# 2078 10 or
# Load the data
data <- USArrests
# Check the first few rows of the data
head(data)
names(data)
data<-as.matrix(data)
str(data)
dim(data)

# a
# Compute the distance matrix
state_dissimilarity <- dist(data)

# b
mds_model <- cmdscale(state_dissimilarity, eig = TRUE, k = 2)
mds_model
# Fit the classical MDS model using city.dissimilarity object
# the original data  of the state for arrest are preserved in the new dimension 


# c
mds_coords <- mds_model$points
print(mds_coords)
summary(mds_coords)
# Summarizing the model
# these cordinate points preserve the original properties of the cities location

# d
plot(mds_coords, type = "n")
text(mds_coords, labels = row.names(data), cex = 0.7)
title("Classical MDS of USArrests")
# Bi-plot of the model
# the bi-plot shows the city map in two dimension where the oroginal distance disimilaty of cities is preserved.


# e

# PCA coordinates
pca_coords <- pr.out$x[, 1:2]

# MDS coordinates
mds_coords <- mds_model$points

# Plot PCA vs MDS
par(mfrow = c(1, 2))
plot(pca_coords, main = "PCA", xlab = "PC1", ylab = "PC2", pch = 19, col = "blue")
text(pca_coords, labels = rownames(data), cex = 0.7, pos = 4)
plot(mds_coords, main = "MDS", xlab = "Dim 1", ylab = "Dim 2", pch = 19, col = "red")
text(mds_coords, labels = rownames(data), cex = 0.7, pos = 4)

# Correlation between PCA and MDS coordinates
cor(pca_coords, mds_coords)

# PCA1  has high degree of positive correlation with MDS1 and low degree of positive correlation with MDS2
# PCA2  has low degree of positive correlation with MDS1 and high degree of negative correlation with MDS2
# These findings imply that both PCA and MDS reveal similar structures in the data, with PC1 and MDS1 representing 
# a common dimension, and PC2 and MDS2 representing another common dimension but with reversed directionality.

# Do the following in R studio and with R script to knit HTML output:
#   a) Define an Object "rating" With 9, 2, 5.8, 6, l, 3, 2, 8, 4, 6, 8, 7. 1.2, 6, IO, S, 6, 7 values.
# b) Replic* given table obtained from SPSS software for the rating in R.

data <- c(9,2,5,8,6,1,3,2,8,4,6,8,7,1,2,6,10,5,6,9,6,2,4,7)
length(data)

valid <- sort(unique(data))
valid

freq <- as.numeric(table(data))
freq

percent <- as.numeric(round(prop.table(freq)*100,1))

valid_per <- as.numeric(round(prop.table(freq)*100,1))

cum_per <- as.numeric(cumsum(percent),1)

df <- data.frame(
  'Valid' = as.character(valid),
  'Frequency' = freq,
  'Percent' = percent,
  'Valid Percent' = valid_per,
  'Cumulative Percent' = as.character(cum_per)
)
df[10,5] <- as.character(round(cum_per[10]))

library(dplyr)

df <- df %>% add_row('Valid'='Total', Frequency=sum(freq),
                     Percent=round(sum(df$Percent)),
                     'Valid.Percent' =round(sum(df$Valid.Percent)),
                     'Cumulative.Percent'= ""
                     ) %>% rename('Valid Percent'='Valid.Percent') %>% rename('Cumulative Percent'='Cumulative.Percent')

# 
# DO the following in R Studio with R script:
#   a) Create a dataset with following variables: age (18-99 years), sex (male/female), educational levels (NO
#                                                                                                           educatioWPrimary/Secondary/Beyond secondary), socio-economic status (Low, Middle, High) and.body
# mass index (14 — 38) With random 250 cases Of each VÜiable. Your exam roll number must be used to
# set the random seed.
# b) Check if body mass index variable follows normal didribütion using suggestive plot and confirrnative
# tests and interpret the results careMIy.
# c) ChEk if body mass variables have equal variance for sex variable using suggestive plot and
# confirmatory test and interpret the results carefully.
# dj Which independent urnplet-test must be used to comparebodymass index by sex? Why?
#   e) Perform the independent sample t-test identified above and interpret it carefully.
# ) IOSTTU
# 2
# 2080 QN8 or
# a

set.seed(34)
# Number of cases
num_cases <- 250

# Generate random data for each variable
age <- sample(18:99, num_cases, replace = TRUE)

sex <- sample(c("male", "female"), num_cases, replace = TRUE)

education_levels <- sample(c("No education", "Primary", "Secondary", "Beyond Secondary"), num_cases, replace = TRUE)

soc_eco_status <- sample(c("Low", "Middle", "High"), num_cases, replace = TRUE)
bmi <- sample(14:38, num_cases, replace = TRUE)

data <- data.frame(
  Age = age,
  Sex = sex,
  EducationLevel = education_levels,
  SocioEconomicStatus = soc_eco_status,
  BMI = bmi
)

# b
# suggestive plot for normal distribution
qqnorm(data$BMI)
qqline(data$BMI)
# from the q-q plot we can see many data points are outliers so the data set are not normally distributed.

hist(data$BMI)

# conformative test
# ks_test_result <- ks.test(data$BMI, "pnorm", mean = mean(data$BMI), sd = sd(data$BMI))
# ks test if n>100
ks_test_result <- ks.test(data$BMI, "pnorm",mean = mean(data$BMI), sd = sd(data$BMI))
ks_test_result
# if p value is greater than 0.05 it follows normal distribution.
# since p value is less than 0.05 it does not follow normal distribution.


# shapiro.test in n<100
shapiro.test(data$BMI)



# c
# for equality of variance
library(car)
library(ggplot2)
head(data)
str(data)

#Suggestive plot
ggplot(data=data,mapping=aes(y=Sex,x=BMI))+
  geom_boxplot()

boxplot(bmi ~ sex, data = data, main = "BMI by Sex")
# since the length of whiskers of the boxplot are not same the variance of BMI  with sex donot seem to be equal.


# Conformitary test
data$Sex=as.factor(data$Sex)
(leveneTest(BMI ~Sex, data = data))
# since the value of Pr is greater than 0.05 the variance of BMI with sex is same.


# d
# If Pr(>F) is greater than 0.05, we assume equal variances use Student's t-test.


# if pr(<F) is less than 0.05 we assume unequal varaince and use welch t test.

#e
t.test(BMI ~ Sex, data = data, var.equal = TRUE)
# since p value is greater than 0.05 we accept alternative hypothesis i.e difference in means between group female and group male is not equal to 0

t.test(BMI ~ Sex, data = data, var.equal = FALSE)
# welch t test


# true difference in means between group female and group male is not equal to 0.
# if p value is less than 0.05 we accept null hypothesis.(ie.means between group female and group male is  equal to 0 )





# second reassment 2081
# 6. Do the following in R Studio using ggplot2 package with R script to knit PDF output
# a) Create a dataset with follovang variables age (20-59years). height (l IO - 190 centimeters), weight (40-90 kg)
# "ith random I SO cases ofeach variable
# b) Compute body mass Index (B.MI) vanable as BMI - [(wetght in kg)/ (height in centimeter squared))
# c) Create body mass index categories. <IS, 18-24.25-30, -309 label them as "lmderweight". "mrmal",
# "overv.eight" and "obese" respectively using dplyr package
# d) Show the percentage distribution of labelled BMI vanable with pie chart using ggplot2
# Q.6)
# a)
set.seed(22)
dataset <- data.frame(
  age = sample(c(20:59), 150, replace = T),
  height = sample(c(110:190), 150, replace = T),
  weight = sample(c(40:90), 150, replace = T)
)


head(dataset)


# b) Compute BMI (The formula should be BMI = weight in kg/height in m squared) but according to the question i have applied it.
dataset$bmi <- dataset$weight / (dataset$height)^2




# c) Categorizing bmi
dataset$bmi_category <- ifelse(dataset$bmi < 18, 'underweight', ifelse(dataset$bmi <= 24, 'normal',
                                                                       ifelse(dataset$bmi <= 30), 'overweight', 'obese'))

head(dataset)




library(ggplot2)

# Create a summary data frame
bmi_summary <- as.data.frame(table(dataset$bmi_category))
colnames(bmi_summary) <- c("Category", "Frequency")

# Calculate percentages
bmi_summary$Percentage <- (bmi_summary$Frequency / sum(bmi_summary$Frequency)) * 100


# Create a pie chart
ggplot(bmi_summary, aes(x = "", y = Frequency, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "BMI Categories Distribution") +
  theme(legend.position = "right") +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")),
            position = position_stack(vjust = 0.5))


## If bmi is computed using a formula (BMI = weight in kg/height in m^2 ) then

# b) Compute BMI (The formula should be BMI = weight in kg/height in m squared) but according to the question i have applied it.
dataset$bmi <- dataset$weight / ((dataset$height)/100)^2




# c) Categorizing bmi
# Calculate BMI
dataset$bmi <- dataset$weight / ((dataset$height)/100)^2

# Categorize BMI
dataset$bmi_category <- ifelse(dataset$bmi < 18, 'underweight', 
                               ifelse(dataset$bmi <= 24, 'normal',
                                      ifelse(dataset$bmi <= 30, 'overweight', 'obese')))

head(dataset)




library(ggplot2)

# Create a summary data frame
bmi_summary <- as.data.frame(table(dataset$bmi_category))
colnames(bmi_summary) <- c("Category", "Frequency")

# Calculate percentages
bmi_summary$Percentage <- (bmi_summary$Frequency / sum(bmi_summary$Frequency)) * 100


# Create a pie chart
ggplot(bmi_summary, aes(x = "", y = Frequency, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "BMI Categories Distribution") +
  theme(legend.position = "right") +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")),
            position = position_stack(vjust = 0.5))


# very imp

# 
# 7. Do the following in R Studio using "airquality" dataset of R •anth R script to knit PDF output:
#   a)
# b)
# c)
# d)
# Perform test of normality of "Wind" variable by each categones of "Month" variable interpret the results
# carefully
# Perform test of equality of variancé on "Wind" variable by each categories of Month vanable and interpret the
# result carefully
# Perform the best independent sample statistical test for this data now and interpret the result carefully
# Perform the post-hoc test for this data and interpret the results carefully

# Q.7) 

data <- airquality

# Chaning the Month variable as a factor variable
data$Month <- as.factor(data$Month)



## a) Perform goodness-of-fit test on Wind variable by Month variable to check if it follows normal distribution or not


## If the sample size for each category is less than 100, it's appropriate to use the Shapiro-Wilk test for normality, especially if you're interested in testing the normality assumption within each group separately.
library(dplyr)

per_month_count <- data %>% group_by(Month) %>% summarize(count= n())

per_month_count

## Since wind variable has laround 30 to 31 data points per each month so it is appropriate to use Shapiro-Wilk test for normality test.

## Shapiro Wilk Test Of Normality
##  H0: The sample data comes from a normally distributed population.
##  H1: The sample data does not come from a normally distributed population.
## If the p-value obtained from the Shapiro-Wilk test is less than or equal to α (p ≤ 0.05),
## you reject the null hypothesis. This suggests that the sample data significantly deviates
## from a normal distribution.
## If the p-value is greater than α (p > 0.05), you fail to reject the null hypothesis.
## This suggests that there is no significant evidence to say that the sample data is not 
## normally distributed.



# Function to perform Shapiro-Wilk test for normality within each group
shapiro_within_month <- function(data) {
  result <- tapply(data$Wind, data$Month, shapiro.test)
  return(result)
}

# Perform Shapiro-Wilk test for each month
shapiro_results <- shapiro_within_month(data)

# View the results
print(shapiro_results)

## Since the p-value is greater than 0.05 for every months, then we can say that the data comes from a normal distribution.
## Thus, we can say that wind variable by each month follows a normal distribution.



## b)	Perform a test of equality of variance on "Wind" variable by each categories of the Month variable and interpret the results.

# Levene's test for homogeneity of variances

## H0: The variances of wind speed are equal across all categories of the "Month" variable.
## H1: The variances of wind speed are not equal across all categories of the "Month" variable.

library(car)
# Perform Levene's test
levene_result <- leveneTest(Wind ~ Month, data = data)

# View the test result
print(levene_result)
## Since the p-value is 0.9467 which is way greater than 0.05 so we fail to reject the null hypothesis.
## That means the variances of wind speed are equal across all categories of the "Month" variable.


## c) Perform the best independent sample statistical test for this data now and interpret the result carefully?

#### Since, wind variable is normally distributed across each month and the variances of wind speed are
#### equal across all cateogries of the "Month" variable, we can apply Classical One-Way Anova test.

## Applying One Way ANOVA
## H0: There are no differences in the means of the "Wind" variable in different months.
## H1: There is a difference in the means of the "Wind" variable in different months.

summary(aov(Wind ~ Month, data = data))

#### Since the p-value (0.00879) is less than the common significance level of 0.05, we reject the null hypothesis.
#### This suggests that there is a statistically significant difference in mean wind speed across different months.

#### This means, post-hoc test or pairwise comparison is required!

# d) Perform the post-hoc test for this data and interpret the results carefully.
#### For classical 1-way ANOVA, Tukey HSD is the best post-hoc test!
#### This will help in identifying which months have significantly different mean wind speeds from each other.

#### H0: There is no significant difference in mean wind speed between the two months being compared.
#### H1: There is a significant difference in mean wind speed between the two months being compared.

#### When the p-value is greater than 0.05, we fail to reject the null hypothesis. This means 
#### that we do not have sufficient evidence to conclude that there is a statistically 
#### significant difference in mean wind speed between the two groups.
#### When the p-value is less than 0.05, we reject the null hypothesis. This means that we
#### have sufficient evidence to conclude that there is a statistically significant difference
#### in mean wind speed between the two groups.
TukeyHSD (aov(Wind ~ Month, data = data))


#### Since, adjusted p value for june and may (6-5) is 0.53 which is greater than 0.05, that means the
#### there is no significant difference in windspeed betweeen these two months.
#### From the above table, we can say that there is a significant difference in windspeeds in
#### July-May (7-5) and August-May(8-5) but in all other months there is no such difference in windspeeds.

summary(lm(Wind ~ Month, data = data))

#### The coefficients for both July and August are negative and statistically significant, indicating that mean wind speed in both months is significantly lower compared to May.


# Conclusion
#### Both Tukey's HSD test and the linear regression model suggest that July and August have statistically significant differences in mean wind speed compared to May.
#### According to Tukey's HSD test, the adjusted p-values for both comparisons are less than 0.05, indicating significant differences.
#### In the linear regression model, the coefficients for July and August are negative and statistically significant at α = 0.05, further confirming lower mean wind speeds in these months compared to May.


# 
# 8. Do the follo'wing in Studio using "Arrests" dåtaset of cai package with R script to knit PDF outiut
# a) Divide the Arrests data into train and test datasets with 7030 random splits
# b) Fit a supervised logistic regression and naive Bayes classification models on train data with "released" as
# dependent variable and all other variables as independent variable
# c) Predict the released variable in the test datasets of both the models and interpret the result carefully
# d) Compare and decide which classification model is better for this data

# Q8) 

library(car)
library(dplyr)

data <- Arrests


### taking colour, age, sex, employed and citizen as independent variable and released as dependent variable
### Converting the target variable into numeric values and then again converting them as factor variables.

data$released <- ifelse(data$released == "Yes", 1, 0)

data$released <- as.factor(data$released)

final_data <- select(data, "released", "colour", "age", 
                     "sex", "employed", "citizen")

table(final_data$colour)

## Converting categorical variables colour into binary intergers and then as factors
final_data$colour <- ifelse(final_data$colour == "Black", 0, 1)
final_data$colour <- as.factor(final_data$colour)

### Converting categorical variables gender female as 0 and male as 1
final_data$sex <- ifelse(final_data$sex == "Female", 0, 1)
final_data$sex <- as.factor(final_data$sex)

### Converting categorical variables employed  no as 0 and yes as 1
final_data$employed <- ifelse(final_data$employed == "No", 0, 1)
final_data$employed <- as.factor(final_data$employed)

### Converting categorical variables citizen no as 0 and yes as 1
final_data$citizen <- ifelse(final_data$citizen == "No", 0, 1)
final_data$citizen <- as.factor(final_data$citizen)





library(ggplot2)

##
create_plot <- function(x, y, title) {
  ggplot(data, aes(x = !!x, y = !!y)) +
    geom_point(color = 'red') +
    labs(title = title) +
    theme_bw()
}

plot1<- create_plot(final_data$released, final_data$colour, "released vs colour")
plot2<- create_plot(final_data$released, final_data$age, "released vs age")
plot3<- create_plot(final_data$released, final_data$sex, "released vs sex")
plot4<- create_plot(final_data$released, final_data$employed, "released vs employed")
plot5<- create_plot(final_data$released, final_data$citizen, "released vs citizen")


library(gridExtra)



grid.arrange(plot1, plot2, plot3, plot4, plot5, 
             nrow = 3, ncol = 2)


### From this graph, we can see that there exist non linear relationship between the target variable and independent variable.


### Apply multivariate logistic regression

model.lr <- glm(released~., data = final_data,
                family = 'binomial'
)


summary(model.lr)

### Checking whether there exist mulitcollinearity in the features.
### TO check it, we have VIF(Variance Inflation Factor).
### IF the VIF value of the feautures in a model is greater than 2, then we can remove such feature as it suffers from multicolinearity issue.
vif(model.lr)

### Since, the vif of all of these features are less than 2, we can say that these features are not collinear to each other.

## Divide the data into train and test sets using 70:30 random splits
set.seed(22)

ind <- sample(2, size = nrow(final_data), replace = T, 
              prob = c(0.7, 0.3))




train.data <- final_data[ind == 1,]
test.data <- final_data[ind == 2, ]


## Now only applying logistic regression on the training dataset
model.lr <- glm(released~., data = train.data,
                family = 'binomial'
)


#### Making predictions on the test datasets

predictions <- predict(model.lr, test.data)


predictions <- ifelse(predictions > 0.5, 1, 0)


lr_pred_df<- data.frame(actual = test.data$released, 
                        predicted = predictions)


head(lr_pred_df, 10)


### Based on the predicted results, we can say that the model is pgiving more postive(1) predictions correct than 0 predictions correct.

### Confusion Matrix

library(caret)


confusionMatrix(as.factor(predictions), test.data$released)

### The accuracy of the logistic regression model is 0.8296 and specificity is 0.98 and sensitivity is 0.06.

## naive bayes algorithm
library(e1071)



model.nb <- naiveBayes(released~., data = train.data)



predictions <- predict(model.nb, test.data)

nb_pred_df<- data.frame(actual = test.data$released, 
                        predicted = predictions)


head(nb_pred_df, 10)

### Based on the predicted results, we can say that the model is pgiving more postive(1) predictions correct than 0 predictions correct.


confusionMatrix(as.factor(predictions), test.data$released)

### The accuracy of the naive bayes model is 0.8277 and specificity is 0.98 and sensitivity is 0.066.
# 
# 
# Use the four variables of "USArrests" data file into R Studio and do as follows with R script to knit PDF output:
#   a) Fit a k-means clustering model in the data with k=2, plot it in the single graph and interpret it carefully
#   b) Add cluster centers for the plot of clusters formed with k=2 and interpret it carefully
#   c) Fit a k-means clustering model in the data with k=3, plot it in the single graph and interpret it carefully
#   d) Add cluster centers for the plot of clusters formed with k=3 and interpret it carefully

# Q.10)
data <- USArrests

head(data)

## a) Applying K-Means Algorithm with k = 2 and ploting it in a single graph and interpret it carefully.

## Before applying K-means clustering algorithm, we need to scale the values at a common scale since Kmeans depends on distance (euclidean distance metrics)
library(dplyr)
scaled_data <- data %>% scale()

head(scaled_data)


## Applying Kmeans Clustering
scaled_kmeans_clust <- kmeans(scaled_data, centers = 2, nstart = 20)

scaled_kmeans_clust$cluster

## We have used centers = 2 so we have 2 clusters. These two clusters explain 86.75% of the point variability.


plot(scaled_data, col = (scaled_kmeans_clust$cluster + 1),
     main = "K-Means Clustering with K=2",
     xlab = "",
     ylab = "",
     pch = 20, cex = 2)

### From this graph we can clearly see that the two groups separated by our clustering algorithm. 
### One of the group is in green color whereas the other group is in red color. 
### There are 2 red points which fall nearer to the green cluster.

# b) Add cluster centers for the plot of clusters formed with k = 2 and interpret it carefully.


## Visualizing clusters

y_kmeans <- scaled_kmeans_clust$cluster

cluster_centroids <- scaled_kmeans_clust$centers

library(cluster)
clusplot(x = scaled_data,
         y_kmeans,
         main = "Clustering using k= 2",
         color = TRUE,
         labels = 0,
         xlab = '',
         ylab = '')

# Add cluster centroids
points(cluster_centroids, col = c('red', 'blue'), pch = 8, cex = 2)

## We can clearly see two different clusters with their centroid located with red star and blue star for each of the cluster.



## c) Applying K-Means Algorithm with k = 3 and ploting it in a single graph and interpret it carefully.


## Applying Kmeans Clustering with k = 3
scaled_kmeans_clust <- kmeans(scaled_data, centers = 3, nstart = 20)

scaled_kmeans_clust$cluster

## We have used centers = 2 so we have 2 clusters. These two clusters explain 86.75% of the point variability.


plot(scaled_data, col = (scaled_kmeans_clust$cluster + 1),
     main = "K-Means Clustering with K=3",
     xlab = "",
     ylab = "",
     pch = 20, cex = 2)

### From this graph we can clearly see that the three groups separated by our clustering algorithm. 
### One of the group is in green color whereas the other group is in red color and the last group is in blue color. 
### Some of the data points of green and red color are overlapped.
### The right side of cluster for k=2 and k=3 are same but the left side of cluster is broken down into another cluster.


# d) Add cluster centers for the plot of clusters formed with k = 3 and interpret it carefully.


## Visualizing clusters

y_kmeans <- scaled_kmeans_clust$cluster

cluster_centroids <- scaled_kmeans_clust$centers

library(cluster)
clusplot(x = scaled_data[,c("Assault", "UrbanPop")],
         y_kmeans,
         main = "Clustering using k= 3 with their centroids",
         color = TRUE,
         labels = 0,
         xlab = '',
         ylab = '')

# Add cluster centroids
points(cluster_centroids, col = c('red', 'blue', 'green'), pch = 8, cex = 2)

## We can clearly see two different clusters with their centroid located with red star and blue star and green star for each of the cluster.



# QN 10


head(iris)
ir_label <- iris$Species
ir_data <- iris[,-5]
head(ir_data)

#a
# sd.data <- scale(ir_data)
data.dist <- dist(ir_data)
plot(hclust(data.dist,method = "single"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Single Linkage")

#b
plot(hclust(data.dist,method = "complete"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Complete Linkage")

#c
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

#d
# Best hierarchical model

plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

abline(h = 1.85, col = "red")


hc.out1 <- hclust(dist(ir_data),method = "single")
hc.out2 <- hclust(dist(ir_data),method = "complete")
hc.out3 <- hclust(dist(ir_data),method = "average")

hc.clusters1 <- cutree(hc.out1,3)
hc.clusters2 <- cutree(hc.out2,3)
hc.clusters3 <- cutree(hc.out3,3)


table(hc.clusters1, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters2, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters3, ir_label)
# only few of the virginica is incorrectly clustered as versicolor which is better than other methods.

plot(hc.out3, labels = ir_label,main = "Average Linkage (Best HCA model)")
abline(h = 1.85, col = "green")

# since the number of correctly represented data in dendrogram is formes in average method we prefer average method.


# exam Q7

data<-airquality
head(data)

# a
# suggestive plot for normal distribution
qqnorm(data$Temp)
qqline(data$Temp)
# from the q-q plot we can see many data points are in qqline so the data set seem to be normally distributed.

hist(data$Temp)
# histogram shows that the data seem to be normally distributed although not perfect.

str(data)
# conformative test
# ks_test_result <- ks.test(data$BMI, "pnorm", mean = mean(data$BMI), sd = sd(data$BMI))
# ks test if n>100
ks_test_result <- ks.test(data$Temp, "pnorm",mean = mean(data$Temp), sd = sd(data$Temp))
ks_test_result
# if p value is greater than 0.05 it follows normal distribution.


# b
# for equality of variance
library(car)
library(ggplot2)
head(data)
str(data)

#Suggestive plot
ggplot(data=data,mapping=aes(y=factor(Month),x=Temp))+
  geom_boxplot()

boxplot(Temp ~ Month, data = data, main = "Temp by Month")
# since the length of whiskers of the boxplot are not same the variance of Temp  with Month donot seem to be equal.


# Conformitary test
data$Month=as.factor(data$Month)
data$Temp=as.numeric(data$Temp)
(leveneTest(Temp ~Month, data = data))
str(data)
# since the value of Pr is less than 0.05 the variance of Temp across month is not equal.


# c
# if Pr(>F) is less than 0.05 for more than two groups we use welch_anova
# if Pr(>F) is greater than 0.05 for more than two groups we use standard one way anova


# d
(welch_anova <- oneway.test(data$Temp~factor(data$Month), var.equal = FALSE))
# since p value is less than 0.05 means of Temp across month are not equal.


# if Pr(>F) is greater than 0.05 for more than two groups we use standard one way anova
welch_anova <- oneway.test(aq$Temp~factor(aq$Month), var.equal = TRUE)
welch_anova


(anova_model <- aov(Temp ~ Month, data = data))


# Apply TukeyHSD to the ANOVA model
tukey_result <- TukeyHSD(anova_model)
print(tukey_result)
# the pairs in  which p value is less than 0.05 ie. 6-5 has difference in mean temperature.
# the pairs in  which p value is less than 0.05 ie. 8-7 has no difference in mean temperature.



x <- 1:15
x <- c(1:15)
x <- seq(1,15)

'Do The following in R Studio with R script so that it can be knitted as PDF:
Prepare a column vector of miles per gallon (mpg) variable with random range between 10 to 50 of 500
values, do not forget to use your exam roll number as random seed to replicate the result
Plot histogram of this "mpg" variable and interpret it carefully
Refine the histogram by filling the bars with "blue" color and changing number of bins to 8
Add a vertical abline at the arithmetic mean of the mpg variable
Plot Q-Q plot of mpg variable, add normal Q-Q line of red color on it and interpret it carefully
'
library(car)

# setting random seed with my roll number to replicate the result
set.seed(22)

# creating a mpg variable according to question
mpg <- sample(c(10:50), size = 500, replace = TRUE)

# Plot histogram of mpg variable
hist(mpg)

# From the given histogram I can say that most of the cars or vehicles has around 10 to 15 mpg mileage, 
# second highest milage range is around 15 to 20 miles per gallon. The graph looks like a uniform distribution as most
# of the interval has almost similar milage.

# Refine the histogram by filling the bars with blue color and changing color of bins to 8.

hist(mpg, col = "blue", breaks = 8)

# Add a vertical abline at the arithmetic mean of the mpg variable

abline(v=mean(mpg), col = 'red')

# Plot Q-Q plot of mpg variable, add normal Q-Q line of red color on it and interpret it carefully

qqnorm(mpg, main = "QQ Plot of mpg variable with normal QQ-line in red color")

qqline(mpg, col = 'red', lwd = 2)

# Most of the data points lie in the qqline but still many points do not seem to lie on this line so we can 
# say that the mpg variable is not normally distributed.

# Plot density plot of mpg variable without the border, fill it with yellow color and interpret

dens <- density(mpg)
plot(dens, main = "Density plot of mpg")
polygon(dens, col = "yellow", border = NA)

# Upon analyzing the distribution plot, it seems to form bell shape curve but it is not a perfect bell shaped curve.
# So, we can say that the mpg variable does not follow normal distribution.




'
Define the first layer of the ggplot object with diamond data, carat as x-axis and price as y-axis
Add layer with geometric aesthetic as "point", statistics and position as "identity"
Add layers with scale of y and x variables as continuous
Add layer with coordinate system as Cartesian
Add layer with appropriate title and interpret the resulting graph carefully
'

library(ggplot2)
library(caret)

ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_point(stat = 'identity', position = 'identity') +
  scale_x_continuous() + scale_y_continuous() +
  coord_cartesian() +
  labs(title = "Relationship between carat and price")


# Layered version of code
ggplot(data = diamonds, mapping = aes(carat, price)) +
  layer(geom = 'point', stat = 'identity', position = 'identity') +
  scale_x_continuous() + scale_y_continuous() +
  coord_cartesian()

# ALternative layer version code
ggplot() + layer(data = diamonds, mapping = aes(x = carat, y = price),
                 geom = "point", stat = "identity",
                 position = "identity") +
  scale_x_continuous() + scale_y_continuous() +
  coord_cartesian()







'
Do the following in R Studio with R script so that it can be knitted as PDF:
Prepare a data with 100 random observations and two variables: miles per gallon (mpg) with random
range between 10 to 50 and transmission gears (gear) as random binary variable
(3 = three gear, 4=four gear and 5-five gears), do not forget to use your class roll number as random seed to replicate the result)
Perform goodness-of-fit test on miles per gallon (mpg) variable to check if the variances are equal or not on gears variable categories
Perform the best 1-way analysis of variance test based on goodness-of-fit results with justification.
Can you use this test for this data? Interpret the result carefully, if applicable.
'

set.seed(22)
mpg <- sample(c(10:50), size = 100, replace = T)
gears <- as.factor(sample(c(3, 4, 5), size = 100, replace = T))

mpg_data <- data.frame(mpg = mpg, gears = gears)
head(mpg_data)

# Performance goodness-of-fit test on mpg to check if variances are equal or not on gears variable
levene_result <- leveneTest(mpg~gears, data = mpg_data)

levene_result

# Since, pvalue is greater than 0.05, we can say that the variances are equal on gears variable.

# Normality check for mpg variable across each categories
normality_check_category <- function(data)
{
  result <- tapply(data$mpg, data$gears, shapiro.test)
  return(result)
}

table(mpg_data$gears)
# Since each category contains values less than 30, we can apply shapiro test of normality.

shapiro_test_results <- normality_check_category(data = mpg_data)
shapiro_test_results

# Since p-value is greater than 0.05 for two gears namely 3 and 5, the mpg variable follows normal distribution across those variables but
#  mpg variable does  not follow normal distribution across gear 4 as p value is less than 0.05 in this case.

# Since data is not normally distributed, we must choose non parametric test rather than parametric one-way anova test.
# So, kruskal wallis test is a good test in this case.

test_result <- kruskal.test(mpg~gears, data = mpg_data)

print(test_result)

# Since, p value is greater than 0.05, which means that there is no significant difference in the median of three groups.

# If there is a significant difference in the median of mpg variables across various gear groups, we can use dunn's test for doing post-hoc analysis.

# Post Hoc Test
install.packages('dunn.test')

library(dunn.test)
# Perform Dunn's test
dunn_result <- dunn.test(mpg_data$mpg, mpg_data$gears,  method="bonferroni")

# Print the results
print(dunn_result)

# Since adjusted p-values for all three groups is greater than 0.05, which means that there is no significant difference in the median of the three groups.




'
Do the followings in R Studio using R script so that it can be knitted as PDF:
b) Prepare a data with 200 random observations and four variables: miles per gallon (mpg) with random range between 10 to 50;
transmission (am) as random binary variable (0=automatic, 1=Manual), weight (wt) with random range of 1 to 10 and 
horse power (hp) with random range of 125 and 400, do not forget
to use your exam roll number as random seed to replicate the result
c) Divide this data into train and test datasets with 70:30 random splits with your exam roll number as random seed for replication
d) Fit a supervised linear regression model for the train data
e) Explain the model fit and BLUE coefficients for the fitted model
f) Predict the mpg variable in the test data, get fit indices and interpret them carefully
'
set.seed(22)
df <- data.frame(mpg = sample(c(10:50), size = 200, replace = T),
                 am = as.factor(sample(c(0, 1), size = 200, replace = T)),
                 wt = sample(c(1:10), size = 200, replace = T),
                 hp = sample(c(125:400), size = 200, replace = T)
)

head(df)

set.seed(22)
index<- sample(2, size = nrow(df), replace = T, prob = c(0.7, 0.3))

train_df <- df[index == 1, ]
test_df <- df[index ==2, ]

print(nrow(train_df))
print(nrow(test_df))


# Fit a supervised linear regression with training data
linear_reg <- lm(formula = mpg ~ ., data = train_df)

# Checking vif scores to see if there is any multicollinearity present in the dataset
vif(linear_reg)

# Since vif score less than 10, we can say that the features are not correlated with each other to a higher degree.
print(summary(linear_reg))


# From this we can say that the variables am, wt and hp are statistically significant features.

normalize_func <- function(x) {
  scaled_values <- ((x-min(x))/ (max(x) - min(x)))
  return(scaled_values)
}

scaled_train_df <- train_df
scaled_train_df$wt <- normalize_func(scaled_train_df$wt)
scaled_train_df$hp <- normalize_func(scaled_train_df$hp)

scaled_test_df <- test_df
scaled_test_df$wt <- normalize_func(scaled_test_df$wt)
scaled_test_df$hp <- normalize_func(scaled_test_df$hp)


# Fit a supervised linear regression with training data
scaled_linear_reg <- lm(formula = mpg ~ ., data = scaled_train_df)

# Checking vif scores to see if there is any multicollinearity present in the dataset
vif(scaled_linear_reg)

# Since vif score less than 10, we can say that the features are not correlated with each other to a higher degree.
print(summary(scaled_linear_reg))

# From the given summary, we can notice an adjusted R-squared of less than 0 which means the model is not a good fit for this data 
# since R2 is smaller than 0.5.

new_df <- df
new_df$am <- as.integer(df$am)

# Finding correlations
cor(new_df)

# All three variables do not have a strong correlation with the target variable.

# Plot to see linear relationship exists between mpg and wt variable
plot(new_df$mpg, new_df$wt)

# Since there is not a linear relationship exists between these data points.

# Check If Intercept only model is better than linear model.

# Intercept only model
intercept_only_model <- lm(mpg ~ 1, data = scaled_train_df)
full_model <- lm(mpg~., data = scaled_train_df)


# Perform an F-test to compare the models
anova(intercept_only_model, full_model)

# From this we can see that the p value is greater tha n 0.05 which concludes that predictors in the full model does not
# provide a better fit than the intercept only model.
library(car)

density <- density(train_df$mpg)
plot(density)
polygon(density, col = 'red')

# From the figure also, it does not look like a gausian or a bell shaped curve.

# SInce all the assumptions of a BLUE Estimate is not satisfied, we can say that the given predictions can not provide a better fit.


# Fit the model on the test dataset and get the indices and interpret them
predictions <- predict(scaled_linear_reg, scaled_test_df)

library(caret)



indices <- data.frame(
  R2 = R2(predictions, scaled_test_df$mpg),
  RMSE = RMSE(predictions, scaled_test_df$mpg),
  MAE = MAE(predictions, scaled_test_df$mpg)
)

# R2 is less than 0.5 so we can say that this is not a good model.


"
Do the following in R Studio with R script so that it can be knitted as PDF:

a) Prepare a data with four random variables and 300 observations: miles per gallon (mpg) with random
range between 10 to 50; transmission (am) as random binary variable (0-automatic, I-Manual), weight
(wt) with random range of 1 to 10 and horse power (hp) with random range of 125 and 400, do not forget
to use your exam roll number as random seed to replicate the result
b) Divide this data into train and test datasets with 80:20 random splits with your exam roll number as

random seed for replication
c) Fit a supervised logistic regression model on train data with transmission (am) as dependent variable and
miles per gallon (mpg), horse power (hp) and weight (wt) as independent variable

d) Predict the transmission variable in the test data and interpret the predicted result carefully

e) Get the confusion matrix, sensitivity, specificity of the predicted model and interpret them carefully
"

set.seed(22)
data <- data.frame(mpg = sample(c(10:50), size = 300, replace = T),
                   am = as.factor(sample(c(0, 1), size = 300, replace = T)),
                   wt = sample(c(1:10), size = 300, replace = T),
                   hp = sample(c(125:400), size = 300, replace = T))


library(ggplot2)
library(grid)
library(gridExtra)

create_cust_plot <- function(data, ind_feat, target_feat) {
  ggplot(data = data, mapping = aes_string(x = target_feat, y = ind_feat)) +
    geom_point(stat = 'identity', position = 'identity', col = 'red')
}

plot1 <- create_cust_plot(data = data, ind_feat = "mpg", target_feat = "am")
plot2 <- create_cust_plot(data = data, ind_feat = "wt", target_feat = "am")
plot3 <- create_cust_plot(data = data, ind_feat = "hp", target_feat = "am")

grid.arrange(plot1, plot2, plot3, nrow = 3, ncol = 1)

# No linear relationship between dependent and independent feature
head(data)

set.seed(22)
index <- sample(2, nrow(data), replace = T, prob = c(0.8, 0.2))
train_data <- data[index ==1, ]
test_data <- data[index ==2, ]



# Fitting a logistic regression on the test dataset.
log_model <- glm(formula = am ~ ., data = train_data, family = 'binomial')

summary(log_model)


# Check vif for this model if multicollinearity exist and is affecting the model
vif(log_model)
# Since the vif value for all these variables are less than 1 we can say that there is no multicollinearity issue in the dataset.

# Make predictions on the test dataset
predictions <- predict(log_model, test_data, type = "response")

predictions <- ifelse(predictions > 0.5, 1, 0)

# Predictions dataframe

pred_df <- data.frame(actual_value = test_data$am, 
                      predicted_value = as.factor(predictions))

head(pred_df)


library(caret)

# Confusion Matrix
confusionMatrix(as.factor(predictions), test_data$am)

# Accuracy is around 53%, sensitivity is around 56% and specificity is around 50%.
# The model is not that of a great model.



"10. Do as follows using 'mtcars' dataset in R studio with R script so that it can be knitted as PDF:

a) Check the head and the structure of the dataset

b) Create a 'cars scale' using the Principal Component Analysis (PCA) model based on nine numerical
variables with centering and scaling of the variables

c) Based on the PCA summary result, how many components must be extracted? Why?

d) Get the bi-plot of the fitted model and interpret it carefully

e) Improve the fitted model with VARIMAX process and interpret the results carefully
"
data <- mtcars
# Checking the head of the dataset
head(data)

# Checking the structure of the dataset
str(data)

# Create a 'cars scale' using the Principal Component Analysis (PCA) model based on nine numerical variables with centering and scaling of the variables
## Scaling the data before applying PCA
scaled_data <- scale(data)

library(factoextra)
library(FactoMineR)

cars_scale <- PCA(scaled_data)

# Summarizing the PCA result
summary(cars_scale)
# Finding the eigen values of the result
cars_scale$eig

# By analyzing the summary we can see that there are two eigenvalue namely Dim.1 and Dim.2 greater than 1 so we can choose these two components.
# These two components or variables can explain more than 84% of the total variance. So, the principal componenets are these two variables.

cars_scale_pca <- prcomp(scaled_data)
summary(cars_scale_pca)

## From here also, we can see that PC1 and PC2 have standard deviations greater than 1 and have explained more than 84% of total variance.
# THus, based on the summary obtained we can say that two principal componenets can be extracted.

library(psych)

pca_cars_scale <- psych::principal(scaled_data, nfactors = 2, rotate = 'none')


biplot(pca_cars_scale, labels = rownames(data))
# From the given biplot I can say that PC1 explains the most variation than PC2.
# Looking at the variable arrows, we can see that variables like 'cyl' (number of cylinders), 
# 'wt'(weight), seem to have a positive correlation on PC1. This suggests that cars with higher values on these variables tend to have higher scores on PC1.
# On the other hand, 'drat' (drag ratio), mpg seems to have a negative correlation with PC1, indicating an opposite relationship. Cars with higher drag ratios tend to have lower scores on PC1.

# e) Improve the fitted model with VARIMAX process and interpret the results carefully

pca_cars_scale_varimax <- psych::principal(scaled_data, nfactors = 10, rotate = 'varimax')

print(pca_cars_scale_varimax)

# After applying varimax rotation, we can see RC1, RC2, RC3 and RC4 eigen values are greater than 1 so there are four componenet as PCA after applying varimax rotation.


'Do as follows using "USArrests" dataset in R studio with R script so that it can be knitted as PDF:
a) Get dissimilarity distance as state.dissimilarity object
b) Fit a classical multidimensional model using the state dissimilarity object
c) Get the summary of the model and interpret it carefully
d) Get the plot of the model and interpret it carefully
e) Compare this model with the first two components from principal component analysis in this data
'
# a) Get dissimilarity distance as state.dissimilarity object
data <- USArrests
state.dissimilarity <- dist(data, method = 'euclidean')

# b) Fit a classical multidimensional model using the state dissimilarity object
model <- cmdscale(d = state.dissimilarity, k = 2, eig = TRUE)

# c) Get the summary of the model and interpret it carefully
summary(model)

mdm_coordinates <- model$points

eigenvalues <- model$eig

variance_explained <- eigenvalues / sum(eigenvalues) * 100

variance_explained
# Interpretation: The summary includes the eigenvalues, which indicate the amount of variance captured.

# d) Get the plot of the model and interpret it carefully


plot(mdm_coordinates, main = "Classical Multi dimensional Model Of USArrests Datasets",
     xlab = "Coordinate 1", ylab = "Coordinate 2")
text(mdm_coordinates, labels = rownames(mdm_coordinates), col = "blue")

# Nevada and New York are close to each other, similarly Texas and Colorado are close to each other.

# e) Compare this model with the first two components from principal component analysis in this data

library(psych)
scaled_data <- scale(data)

pr_comp_model <- prcomp(scaled_data)

summary(pr_comp_model)

# THe following pca model yields two eigen values for the given dataset.

# Biplot interpretation
pca_model<- psych::pca(scaled_data, nfactors = 4, rotate = "none")

print(pca_model)

# 50 % variance is explained by PCA1 and remaining 50% is explained by PCA 2.
biplot(pca_model, labels = rownames(mdm_coordinates),
       main = "PCA of two principal components")

# From the given biplot I can say that PC2 explains the most variation than PC2.
# Looking at the variable arrows, we can see that variables like 'cyl' (number of cylinders), 
# 'wt'(weight), seem to have a positive correlation on PC1. This suggests that cars with higher values on these variables tend to have higher scores on PC1.
# On the other hand, 'drat' (drag ratio), mpg seems to have a negative correlation with PC1, indicating an opposite relationship. Cars with higher drag ratios tend to have lower scores on PC1.


'
Do the following in R Studio with R script:
a) Create a dataset with following variables: age (18-99 years), sex (male/female), educational levels (No
education/Primary/Secondary/Beyond secondary), socio-economic status (Low, Middle, High) and body
mass index (14-38) with 150 random cases of each variable. Your exam roll number must be used to
set the random seed.
b) Show a sub-divided bar diagram of body mass index variable by sex and socio-economic variables
separately with interpretations.
c) Show multiple bar diagram of age variable withsexand educational level variablesand interpret
carefully.
d) Show boxplots of age and body mass index variable separately and interpret the results carefully
e) Create histogram of age and body mass index variable separately and interpret the results carefully
'

set.seed(22)
dataset <- data.frame(age = sample(c(18:99), size = 150, replace = T),
                      sex = as.factor(sample(c('male', 'female'), size = 150, replace = T)),
                      education_levels = as.factor(sample(c('No education', 'Primary', 'Secondary', 'Beyond Secondary'), size = 150, replace = T)),
                      socio_economic_status = as.factor(sample(c('Low', 'Middle', 'High'), size = 150, replace = T)),
                      bmi = sample(c(14:38), size = 150, replace = T))

head(dataset)


nrow(dataset)

'
b) Show a sub-divided bar diagram of body mass index variable by sex and socio-economic variables
separately with interpretations.
'
## Stacked Barplot Of Bodymass Index & Sex

sex_bmi_table <- table(dataset$sex, dataset$bmi)
sex_bmi_matrix <- as.matrix(sex_bmi_table)

barplot(sex_bmi_matrix,beside = F,  main= "distribution of body mass index with respect to sex.",
        xlab = "body mass index", ylab = "frequency count",
        col = c('red', 'green'))
legend("topright", legend = unique(dataset$sex), fill = c("red", "green"), border = NA, cex = 0.5)


# Multiple Bar diagram of age with sex and education levels are

barplot(sex_bmi_matrix,beside = T,  main= "distribution of body mass index with respect to sex.",
        xlab = "body mass index", ylab = "frequency count",
        col = c('red', 'green'))
legend("topright", legend = unique(dataset$sex), fill = c("red", "green"), border = NA, cex = 0.5)


## Stacked Barplot Of Socio_Economic_Staus & Education Status
socioeco_education_table <- table(dataset$socio_economic_status, dataset$education_levels)
socioeco_education_matrix <- as.matrix(socioeco_education_table)
barplot(socioeco_education_matrix, beside= FALSE, main="Rel Study of education levels and socio-economic status",
        ylab = "Frequency", xlab = "Education Levels", col = c('red', 'green', 'blue', 'black'),
        legend.text = TRUE
)
legend("topright", legend = unique(dataset$socio_economic_status), fill = c("red", 'green', 'blue', 'orange'))



# c) Show multiple bar diagram of age variable withsexand educational level variablesand interpret carefully.
barplot(socioeco_education_matrix, beside = T, main = "Relationship between socio economic status and education level using
        multiple bar graph",
        xlab = "Education level", ylab = "Frequency",
        col = c("red", 'green', 
                'blue', 'orange'))

legend("topright", legend = unique(dataset$socio_economic_status), fill = c("red", 'green', 
                                                                            'blue', 'orange'))


# d) Show boxplots of age and body mass index variable separately and interpret the results carefully

boxplot(dataset$age, col = 'red', main = "Boxplot of age variable",
        ylab = "age")

# From this box plot we can say that the age variable has a median value around 60.
# There are no outliers in this age variable.

boxplot(dataset$bmi, col = 'green', main = "Boxplot of age variable",
        ylab = "age")

# From this box plot we can say that the bmi variable has a median value of 25 and 30. 


# e) Create histogram of age and body mass index variable separately and interpret the results carefully

hist(dataset$age, col = 'red', xlab = "age", main = "Histogram of age variable")

# From the given histogram, we can say that the age variable does not follow normal distribution.

hist(dataset$bmi, col = 'blue', xlab = "bmi", main = "Histogram of variablle bmi")
# From the given histogram, we can say that bmi does not follow normal distribution.
# The highest no of people has a bmi around 15. More than 20 people have bmi around that range.




'
Do the following in a studio and with R script to run RTMS output:
a) Define an object "rating" with 9, 2, 5, 8, 6, 1, 3, 2, 8, 4, 6, 8, 7, 1, 2, 6, 10, 5, 6, 9, 6, 2, 4, 7 values.
b) Replicate the given table obtained from SPSS software for the rating object in R.
'
rating <- c(9, 2, 5, 8, 6, 1, 3, 2, 8, 4, 6, 8, 7, 1, 2, 6, 10, 5, 6, 9, 6, 2, 4, 7)

rating_df <- as.data.frame(table(rating))

names(rating_df) <- c('Valid', 'Frequency')


total_freq <- sum(rating_df$Frequency)

rating_df$Percent <- round((rating_df$Frequency / total_freq) * 100, 1)


rating_df$ValidPercent <- rating_df$Percent


rating_df$CumulativePercent <- cumsum(rating_df$ValidPercent)


rating_df


total_row <- data.frame(
  Valid = "Total",
  Frequency = total_freq,
  Percent = 100.0,
  'ValidPercent' = 100.0,
  'CumulativePercent' = ""  # No cumulative percentage for the total row
)

rating_df <- rbind(rating_df, total_row)


library(gt)
library(dplyr)

rating_df %>% gt() %>% 
  tab_header(title = "rating")



'
Do the following in a studio with R script:
a) Create a dataset with following variables: age (18-99 years), sex (male/female), educational levels (No
education/Primary/Secondary/Beyond secondary), socio-economic status (Low, Middle, High) and body
mass index (14-38) with 250 random cases of each variable. Your exam roll number must be used to
set the random seed.
b) Create a scatterplot of age and body mass index variable and interpret it carefully.
c) Which correlation coefficient must be used based on the interpretation of the scatterplot? Why?
d) Compute the best correlation coefficient identified from the scatterplot and interpret it carefully.
e) Test whether this correlation coefficient is statistically valid or not and justify its value
'
set.seed(22)
dataset <- data.frame(age = sample(c(18:99), size = 250, replace = T),
                      sex = as.factor(sample(c('male', 'female'), size = 250, replace = T)),
                      education_level = as.factor(sample(c('No education', 'Primary', 'Secondary',
                                                           'Beyond Secondary'), size = 250, replace = T)),
                      socio_economic_status = sample(c('Low', 'Middle', 'High'), size = 250, replace = T),
                      body_mass_index = sample(c(14:38), size = 250, replace = T)
)

head(dataset)

nrow(dataset)

# b) Create a scatterplot of age and body mass index variable and interpret it carefully.

library(ggplot2)

ggplot(data = dataset, mapping = aes(x= age, y = body_mass_index)) +
  geom_point(stat = 'identity', position = "identity", col = 'red') +
  coord_cartesian() +
  labs(title= "Scatterplot to show the relationship between age and body mass index variables")
theme_classic() 

# The relationship between age and body mass index variable can not be identified from the graph alone. 
# So, need to check the correlation for better confirmation about their relationship.

#  c) Which correlation coefficient must be used based on the interpretation of the scatterplot? Why?

# Based on the graph, we can say that there is a non linear relationship between the age and body mass index so we should 
# not use pearson correlation but instead use spearman rank correlation.

# d) Compute the best correlation coefficient identified from the scatterplot and interpret it carefully.
cor(dataset$age, dataset$body_mass_index, method = "spearman")

# From this, we can say that there is a weak positive correlation between age and body mass index in the dataset.
# A unit change in age value will make 0.07 unit change in body mass index value.


# e) Test whether this correlation coefficient is statistically valid or not and justify its value
cor.test(dataset$age, dataset$body_mass_index, method = "spearman")

# Since pvalue is greater than 0.05 and correlation value is 0.07, we can say that there is no linear relationship between age and body mass index.
# Also, this correlation coefficient is not statistically valid.




'
Do the following in a studio with R script:
a) Create a dataset with following variables: age (18-99 years), sex (male/female), educational levels (No
education/Primary/Secondary/Beyond secondary), socio-economic status (Low, Middle, High) and body
mass index (14-38) with 250 random cases of each variable. Your exam roll number must be used to
set the random seed.
b) Check if body mass index variables follows normal distribution for sex variable using suggestive plot and confirmatory test and interpret the results carefully.
c) Check if body mass index variables have equal variance for sex variable using suggestive plot and confirmatory test and interpret the results carefully.
d) Which independent sample t-test must be used to compare body mass index by sex?
e) Perform the independent sample t-test identified above and interpret it carefully.
'
set.seed(22)
dataset <- data.frame(age = sample(c(18:99), size = 250, replace = T),
                      sex = as.factor(sample(c('male', 'female'), size = 250, replace = T)),
                      education_level = as.factor(sample(c('No education', 'Primary', 'Secondary',
                                                           'Beyond Secondary'), size = 250, replace = T)),
                      socio_economic_status = sample(c('Low', 'Middle', 'High'), size = 250, replace = T),
                      body_mass_index = sample(c(14:38), size = 250, replace = T)
)

head(dataset)
nrow(dataset)

boxplot(dataset$body_mass_index)



# Create distribution plot
# Set up the plotting area
par(mfrow = c(1, 2))  # 1 row, 2 columns

qqnorm(dataset[dataset$sex == 'male',]$body_mass_index, main = "QQ Plot of Sample Data")
qqline(dataset[dataset$sex == 'male',]$body_mass_index, col = "red")

qqnorm(dataset[dataset$sex == 'female',]$body_mass_index, main = "QQ Plot of Sample Data")
qqline(dataset[dataset$sex == 'female',]$body_mass_index, col = "red")

# From the above qqplot and qqline, we can say that most of the points fall in the qqline but not perfectly fit on all lines.
# Need to do confirmative test for normality
new_dataset <- dataset

new_dataset$sex <- ifelse(new_dataset$sex == "male", 1, 0)


female_bmi <- new_dataset[new_dataset$sex ==0, ]$body_mass_index
male_bmi <- new_dataset[new_dataset$sex ==1, ]$body_mass_index


ks.test(female_bmi, "pnorm", mean(female_bmi), sd(female_bmi))
ks.test(male_bmi, "pnorm", mean(male_bmi), sd(male_bmi))

# Since pvalue for male and female is both greater than 0.05, we can say that the bmi follows normal distribution among two groups.

# Load necessary libraries
library(ggplot2)


# Create a box plot
ggplot(dataset, aes(x = sex, y = body_mass_index)) +
  geom_boxplot(fill = "lightblue", color = "blue") +
  labs(title = "Box Plot of Bodymass Index by sex", x = "sex", y = "body mass index")

# From the given box plot, we can see there is a small difference in the mean bmi for male and female. 
# But is that difference in median significant? Need to conduct a confirmative test to see it. Levene's test is required.

library(car)


# Performance goodness-of-fit test on mpg to check if variances of bmi are equal or not on sex variable
levene_result <- leveneTest(body_mass_index~sex, data = dataset)

levene_result

# Since the pvalue for levene's test is 0.64 which is less than 0.05, that means bmi has equal variance across two sex categories.


# Equal variances assumed (Student's t-test)
# Unequal variances assumed (Welch's t-test)

# Independent samples t-test should be used in this case as we are comparing the variances of two independent groups (male and feamle)
t.test(body_mass_index~sex, data= dataset)
# Here we can see that mean bmi in male group is 25.91 whereas mean bmi in female groups is 25.70 and pvalue is greater than
# 0.05 so we can say that there is an equal variances among each group in their bmi values.


'
Exercise 9: Do the following in a studio using "mtcars" dataset with a script:
Divide the inputs data into train and test datasets with 70/30 random inputs.
Fit a supervised logistic regression model and naïve bayes classification models on train data with transmission (am) as dependent variable and miles per gallon, displacement (disp), horse power (hp) and weight (wt) as independent variable.
Predict the transmission (am) variable in the test data for both the models and interpret the result carefully.
Get the confusion matrix, sensitivity, specificity of both the models using predicted transmission variable on test data and interpret them carefully.
Which supervised classification model is the best for doing prediction? Why?
'

dataset <- mtcars

index <- sample(2, size = nrow(dataset), replace = T, prob = c(0.7, 0.3))
train_data <- dataset[index ==1, ]
test_data <- dataset[index ==2, ]

print(nrow(train_data))
print(nrow(test_data))

head(dataset)

# Fit a supervised logistic regression model and naïve bayes classification models on train data with transmission (am) as dependent variable and miles per gallon, displacement (disp), horse power (hp) and weight (wt) as independent variable.
library(ggplot2)

linearity_check <- function(data, ind_var, dep_var, col) {
  ggplot(data = data, mapping = aes_string(dep_var, ind_var)) +
    geom_point(stat = 'identity', position = 'identity', col = col) +
    coord_cartesian() +
    theme_classic()
}


plot1 <- linearity_check(data = dataset, ind_var = 'mpg', dep_var = 'am', col = 'red')
plot2 <- linearity_check(data = dataset, ind_var = 'disp', dep_var = 'am', col = 'blue')
plot3 <- linearity_check(data = dataset, ind_var = 'hp', dep_var = 'am', col = 'green')
plot4 <- linearity_check(data = dataset, ind_var = 'wt', dep_var = 'am', col='orange')


library(gridExtra)


grid.arrange(plot1, plot2, plot3, plot4, nrow = 2, ncol = 2)

# From this figure we can see that there is a non linear relationship between the independent and target variable.

train_dataset <- train_data[, c('am', 'mpg', 'disp', 'hp', 'wt')]
test_dataset <- test_data[, c('am', 'mpg', 'disp', 'hp', 'wt')]

# convert dependent variable as factor variable
train_data$am <- as.factor(train_data$am)
test_data$am <- as.factor(test_data$am)


# Fitting logistic regression
log_reg <- glm(formula = am ~ ., data = train_data, family = "binomial")

# Check vif values or multicollinear features
vif(log_reg)

# Since vif values for mpg is greater than 2, removing that feature
train_data <- train_data[, -which(names(train_data) == 'mpg')]
test_data <- test_data[, -which(names(test_data) == 'mpg')]

# checking vif again
log_reg <- glm(formula = am ~ ., data = train_data, family = 'binomial')

vif(log_reg)

# vif for disp is greater than 7 and around 8 removing it, 
train_data <- train_data[, -which(names(train_data) == 'disp')]
test_data <- test_data[, -which(names(test_data) == 'disp')]

# checking vif again
log_reg <- glm(formula = am ~ ., data = train_data, family = 'binomial')

vif(log_reg)


# Since vif values for hp is greater than 2 so removing any one of them.
train_data <- train_data[, -which(names(train_data) == 'hp')]
test_data <- test_data[, -which(names(test_data) == 'hp')]

# Fitting logistic regression model again
log_reg <- glm(formula = am ~ ., data = train_data, family = 'binomial')


# Fitting logistic regression 

log_reg <- glm(formula = am~., data = train_dataset, family = 'binomial')


# Make predictions on the test dataset
predictions <- predict(log_reg, test_dataset, type = 'response')


predictions <- ifelse(predictions > 0.5, 1, 0)


library(caret)


confusionMatrix(as.factor(predictions), as.factor(test_dataset$am))

# Accuracy of 81.82%, Sensitivity of around 71%, and a specificity of 100%.


# Applying naive bayes algorithm
library(e1071)

# Fit a naive bayes model
nb_model <- naiveBayes(am ~ ., data = train_dataset)

# Make predictions on the test dataset
predictions <- predict(nb_model, test_dataset)



confusionMatrix(predictions, as.factor(test_dataset$am))

# Upon applying naive bayes algorithm, we achieve an accuracy of around 72%, sensitivity of around 71% and a specificity of 
# around 75%.

# Upon reviewing the performance metrics of both the models, we can say that accuracy of logistic regression model is slightly higher than that of naive bayes algorithm model.


'
Use the first four variables of "iris" data file into R Studio and do as follows with R script:

a) Fit a k-means clustering model in the data with (k=2) and (k=3)

b) Plot the clusters formed with (k=3) in the single graph and interpret them carefully.

c) Add cluster centers for the plot of clusters formed with (k=3) above and interpret it carefully.

d) Compare the (k=3) cluster variable with Species variable of iris data using confusion matrix and interprete the result carefully.
'

dataset <- iris

head(dataset)

# removing the target label from the dataset
preprocessed_dataset <- dataset[, -which(names(dataset) == "Species")]

# scaling processed dataset
preprocessed_dataset <- scale(preprocessed_dataset)


head(preprocessed_dataset)



clust_model_2 = kmeans(preprocessed_dataset, nstart = 20, centers = 2)

summary(clust_model_2)

# centers of cluster model 
clust_model_2$centers

# FItting a model with 3 clusters
clust_model_3 <- kmeans(preprocessed_dataset, nstart = 20, centers = 3)

summary(clust_model_3)

clust_model_3$cluster

clust_model_3$centers


# Plot the graph

plot(preprocessed_dataset, col = (clust_model_3$cluster + 1),
     main = "K means clustering with 3 clusters",
     xlab = "",
     ylab = "",
     pch = 0.5)

# We can clearly see three clusters are separated properly. The one in right color is far away from the blue and green clusters.
# THe blue and green clusters are closer to each other with some points overlapping each other cluster.

library(cluster)
cluster_centroids <- clust_model_3$centers
clusplot(preprocessed_dataset[, c("Sepal.Length", "Petal.Length")], clust_model_3$cluster,
         color = TRUE,
         xlab = "",
         ylab = "",
)
points(cluster_centroids, col = c('red', 'blue', 'orange'), pch=10, cex = 2)

# THe three clusters with their centroid position is clearly seen in the given plot.



# d) Compare the (k=3) cluster variable with Species variable of iris data using confusion matrix and interprete the result carefully.
library(caret)


# Convert Species to numeric labels
dataset$Species_converted <- as.numeric(factor(iris$Species, levels = c("setosa", "virginica", "versicolor")))


confusionMatrix(as.factor(clust_model_3$cluster), as.factor(dataset$Species_converted))

# The species are converted as 'setosa', 'virginica' and 'versicolor'.
# Upon converting the species as this, we get an accuracy of around 83%, and the model can accurately classify setosa species.



'
a) Get this data in R and compute dissimilarity distance as city.dissimilarity object.
b) Fit a classical multidimensional scaling model using the city.dissimilarity object.
c) Get the summary of the model and interpret it carefully.
d) Get the bi-plot of the model and interpret it carefully.
e) Compare this model with the first two components from principal component analysis model in this
data.
'

data <- data.frame(
  City = c('Atlanta', 'Chicago', 'Denver',
           'Houston', 'LosAngeles', 'Miami',
           'NewYork', 'SanFrancisco', 'Seattle',
           'WashingtonDC'),
  Atlanta = c(0, 587, 1212, 701, 1936, 604, 748, 
              2139, 2182, 543),
  Chicago = c(587, 0, 920, 940, 1745, 1188, 713,
              1858, 1737, 597),
  Denver = c(1212, 920, 0, 879, 831, 1726, 1631,
             949, 1021, 1494),
  Houston = c(701, 940, 879, 0, 1374, 968, 1420, 
              1645, 1891, 1220),
  LosAngeles = c(1936, 1745, 831, 1374, 0, 2339, 
                 2451, 347, 959, 2300),
  Miami = c(604, 1188, 1726, 968, 2339, 0, 1092, 
            2594, 2734, 923),
  NewYork = c(748, 713, 1631, 1420, 2451, 1092, 
              0, 2571, 2408, 205),
  SanFrancisco = c(2139, 1858, 949, 1645, 347, 2594, 
                   2571, 0, 678, 2442),
  Seattle = c(2182, 1737, 1021, 1891, 959, 2734, 
              2408, 678, 0, 2329),
  WashingtonDC = c(543, 597, 1494, 1220, 2300,
                   923, 205, 2442, 2329, 0)
)

head(data)

rownames(data) <- data$City

data <- data[, -which(names(data) == "City")]

head(data)

city.dissimilarity <- dist(data, method = "euclidean")

city.dissimilarity

# b) Fit a classical multidimensional scaling model using the city.dissimilarity object.
mdm_model <- cmdscale(city.dissimilarity, k = 2, eig = TRUE)

# Variance explanation

variance_explained <- mdm_model$eig/sum(mdm_model$eig)

variance_explained

summary(mdm_model)


# THe summary of the model contains the eigen values of the model which can be used to find the total variance captured by the model in the data.

mdm_coordinates <- mdm_model$points

plot(mdm_coordinates, type = 'p', xlab = 'coordinate1', ylab = 'coordinate2',
     main = "Classical Multidimensional Model For US Cities")
text(mdm_coordinates, labels = rownames(data), col = 'red')

# Chicago and Atlanta are closer to each other,
# Los Angeles and San Franciso are also closer to each other. NewYork and Seatle are far from each other.


# e) Compare this model with the first two components from principal component analysis model in this data.

# Applying PCA
library(factoextra)
library(FactoMineR)

pca_model <- PCA(mdm_coordinates)

print(pca_model$eig)

# Both componenets of the model has eigen values greater than 2 and they both explain 50% of variance in the model, summing up to 100% variance explained.

library(psych)


pca_model_psych <- psych::pca(mdm_coordinates, nfactors = 2, rotate = 'none')


pca_model_psych

# THese two components explaining 50-50% of the variance and both have eigen values greater than 1.

biplot(pca_model_psych, labels = rownames(mdm_coordinates))



