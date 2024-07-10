# group b

# question number 6

# load the necessary library
library(igraph, warn.conflicts = F)
# library(Rgraphviz, warn.conflicts = F)

# define the graph object
# a
g1 <- graph(c("R","S","S","T","T","R","R","T","U", "S"))


# b
plot(g1, vertex.color='green',vertex.size=30,edge.size=5,edge.color='red')

# c
# degree
igraph::degree(g1)

# closeness
closeness(g1,mode = 'in')

# betweeness
betweenness(g1)

#d
# Identify hubs in the graph
hubs <- which(degree(g1) == max(degree(g1)))
hubs
#Hubs in a graph refer to nodes with high connectivity or degree that
# serve as central points of the network.

# Find communities in the graph
communities <- cluster_walktrap(g1)
cat("Number of communities: ", length(communities), "\n")

# Visualize the graph with communities highlighted
plot(communities, g1)
#Communities in a graph represent groups of nodes that are more densely connected
#within the group compared to connections between groups

# Interpretation

# plotted a graph with all of the node color as green and node size as 30, edge color as red and link size as 5, 
# got the degree which show the adjacent edges between nodes,
# got the closeness which shows how many steps are required to access each vertex from given, here I have taken ‘in’
# got the betweenness which shows the numbers paths going thorough one particular vertex
# Communities in a graph represent groups of nodes that are more densely connected
#within the group compared to connections between groups

# question number 7

library(ggplot2, warn.conflicts = F)
library(dplyr, warn.conflicts = F)
data <- airquality

# answer a
data <- data %>%
  mutate(Temp = ifelse(is.na(Temp), mean(Temp, na.rm = TRUE), Temp))

# b
class_intervals <- data %>%
  mutate(Temp_class = cut(Temp, breaks = seq(min(Temp), max(Temp), by = 5), include.lowest = TRUE)) %>%
  group_by(Temp_class) %>%
  summarize(count = n()) %>%
  na.omit()

# b
ggplot(class_intervals, aes(x = Temp_class, y = count)) +
  geom_bar(stat = "identity") +
  labs(title = "Frequency Distribution of Temperature Class Intervals",
       x = "Temperature Class",
       y = "Count") +
  theme_minimal()

# c
ggplot(class_intervals, aes(x = "", y = count, fill = Temp_class)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Pie Chart of Temperature Class Intervals",
       fill = "Temperature Class") +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        panel.grid = element_blank())

# d 
# Create a scatter plot of the corrected Temp and wind variables
ggplot(data, aes(x = Temp, y = Wind)) +
  geom_point() +
  labs(title = "Scatter Plot of Corrected Temperature and Wind",
       x = "Corrected Temperature",
       y = "Corrected Wind") +
  theme_minimal()

# Interpretation:
# a. there seems to be no outliers in the data.
# b. created the class interval of the given using cut and break with bin size 10, 
# and showed plotted the frequency distribution. the distribution seems to be normal
# c. created the pie chart of class variable that was created in b.
# d. created the scatter plot of Temp and wind variable, it is seen that there tends to be somewhat
# negative correlation meaning increase in wind tends the lower the Temperature


# question number 8

data <- airquality

# a
# confirmative test
qqnorm(data$Wind)
qqline(data$Wind)

#  the seem to follow the normal distribution
# suggestive test
shapiro_test_result <- shapiro.test(data$Temp)
shapiro_test_result

# if p > 0.05 it follows the normal distribution and since p < 0.05 it we can confirm that it doesnot follows normal distribution

# b

bartlett_test <- bartlett.test(Wind~Month, data = data)
# and since p value is greater than 0.05 we can say that the variances of wind are not significantly different between month

# c
library(car)
library(caret)

anova_model <- aov(Wind ~ as.factor(Month), data = data)
summary(anova_model)

#### Since the p-value (0.00879) is less than the common significance level of 0.05, we reject the null hypothesis.
#### This suggests that there is a statistically significant difference in mean wind speed across different months.


# d

# Apply TukeyHSD to the ANOVA model

tukey_result <- TukeyHSD(anova_model,conf.level = 0.95)
print(tukey_result)

#### Since, adjusted p value for june and may (6-5) is 0.53 which is greater than 0.05, that means the
#### there is no significant difference in windspeed betweeen these two months.
#### From the above table, we can say that there is a significant difference in windspeeds in
#### July-May (7-5) and August-May(8-5) but in all other months there is no such difference in windspeeds.

#


# Question Number 9

# Load the data
df <- USArrests

index <- sample(2, size=nrow(df), replace = T, prob = c(0.7,0.3))

train_df <- df[index == 1, ]
test_df <- df[index ==2, ]

print(nrow(train_df))
print(nrow(test_df))


# Fit a supervised linear regression with training data
linear_reg <- lm(formula = UrbanPop ~ ., data = train_df)

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
scale_test_df <- test_df

scaled_train_df$Murder <- normalize_func(scaled_train_df$Murder)
scaled_train_df$Assault <- normalize_func(scaled_train_df$Assault)
scaled_train_df$Rape  <- normalize_func(scaled_train_df$Rape)

scale_test_df$Murder <- normalize_func(scale_test_df$Murder)
scale_test_df$Assault <- normalize_func(scale_test_df$Assault)
scale_test_df$Rape  <- normalize_func(scale_test_df$Rape)


# Fit a supervised linear regression with training data
scaled_linear_reg <- lm(formula = UrbanPop ~ ., data = scaled_train_df)

# Checking vif scores to see if there is any multicollinearity present in the dataset
vif(scaled_linear_reg)

# Since vif score less than 10, we can say that the features are not correlated with each other to a higher degree.
print(summary(scaled_linear_reg))

# Fit the model on the test dataset and get the indices and interpret them
predictions <- predict(scaled_linear_reg, scale_test_df)

library(caret)


indices_linear <- data.frame(
  R2 = R2(predictions, scale_test_df$UrbanPop),
  RMSE = RMSE(predictions, scale_test_df$UrbanPop),
  MAE = MAE(predictions, scale_test_df$UrbanPop)
)
indices_linear
# the r2 value is less < 0.5, so the predictive power of the model is not good.

# KNN

knn_model <- knnreg(formula = UrbanPop ~ ., data = train_df)



# Make predictions on the testing set
predictions <- predict(knn_model, newdata = scale_test_df)
indices_knn <- data.frame(
  R2 = R2(predictions, scale_test_df$UrbanPop,na.rm = T),
  RMSE = RMSE(predictions, scale_test_df$UrbanPop, na.rm = T),
  MAE = MAE(predictions, scale_test_df$UrbanPop, na.rm = T)
)
indices_knn

# based on the results from the model, I can conclude that Liner Regression Performs Well.




# question number 10:

iris_data<-iris
head(iris_data)
ir_label <- iris_data$Species
ir_data <- iris_data[,-5]
head(ir_data)
data<-dist(ir_data)
data.dist <- dist(ir_data)
#a

plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

# plotted the cluster using average linkage

#b
# Best hierarchical model

plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

abline(h = 1.9, col = "red")




sd.data <- scale(iris-5)
hc.out <- hclust(dist(sd.data))
hc.clusters <- cutree(hc.out, 4)



# the best value for cluster is 3
hc.out <- hclust(dist(sd.data))
hc.clusters <- cutree(hc.out, 4)
#c
kmeans.c3<-kmeans(ir_data,centers = 3,nstart = 20)
kmeans.c3

# the output K-means clustering has 3 clusters with sizes 50, 62, 38
#d
cm<-table(iris$Species,kmeans.c3$cluster)
cm

# from the result the true positive cases for setosa, versicolor and virginicia is 50, 48, 36

(accuracy<-
    sum(diag(cm))/sum(cm))
    
# 
# the accuracy of the fitted model is 0.89 percent
