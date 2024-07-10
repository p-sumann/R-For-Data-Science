


library(tidyverse)
library(ggplot2)


ggplot(data = diamonds, mapping = aes(carat, price)) +
  geom_point(stat ='identity', position = 'identity') +
  scale_x_continuous() + scale_y_continuous() + coord_cartesian() + ggtitle('Carat vs Title')

# to create binary categorical variable
rbinom(n = 100, size = 3)
sample(c(3, 4, 5), size = 100, replace = TRUE, prob = c(0.2, 0.5, 0.3))



# to fit the linear model using ggplot
ggplot(data = mpg, aes(x=displ, 
                       y=hwy)) + 
  geom_point() +
  stat_smooth(method = 'lm', se = F)
# 
# The plot shows a negative relationship between engine size (displ) 
# and fuel efficiency (hwy). 
# • In other words, cars with big engines use more fuel (claim).

# There is high degree of linear negative correlation between … (this is 
#                                                                descriptive analysis)

# Since p-value is < 0.05, we accept H1.
# It means that the linear correlation coefficient is not zero i.e. it is a valid estimate\

# facet wrap
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# facet grid
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# pie chart
ggplot(data=mpg, mapping = aes(cty, model)) + geom_col() + coord_polar(theta = 'y')

# scatter plot + line
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# multi level clustered chart
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")



# Unit 4
# Measures of Central Tendency – mean, median, mode, geometric 
# mean, harmonic mean
# • Measure of Dispersion – standard deviation, inter-quartile range, 
# range
# • Moments – mean, standard deviation, skewness, kurtosis
# • Relative position – percentile, quartiles and z-score


# geometric mean 
# Better for summarizin simple rates,
# ratios and proportions.
# exp(mean(log(x)))

# harmonic mean 
# Better for summarizing 
# instantaneous rates!
# harmonic.mean(x)

# moments
# Skewness – symmetricity
# Skewness measures the asymmetry of the distribution.
# Kurtosis measures the "peakedness" or "flatness" of the distribution.


# percentile and quintile
quantile()



# two variable independent sample test

# normality check
with(mtcars, shapiro.test(mpg[am==0]))
with(mtcars, shapiro.test(mpg[am==1]))

# equal variance
var.test(mpg~am, data = mtcars)


# now we can use sample student t-test
t.test(mpg~am, data = mtcars, var.equal=T)

# conclusion milage is statistically different amoung cars with automatic and manual transmission sytem

# Conclusion: This means that there 
# are equal proportion of automatic 
# and manual transmission vehicles 
# in the sample i.e. “mtcars” data

prop.test(x=c(19,13), n=c(32,32), 
          alternative="one.sided")

prop.test(x=c(19,13), n=c(32,32), 
          alternative="two.sided", correct=F)


# assumptions of one way anova

# var.test is not useful for > 2  groups

library(car)

with(mtcars, shapiro.test(mpg[gear==3]))

with(mtcars, shapiro.test(mpg[gear==5]))

with(mtcars, shapiro.test(mpg[gear==4]))

# so we can we classical 1 way anova can be used

summary(aov(mpg~gear, data = mtcars))
# sicne p value is less than 0.05 we have to do post hoc test

TukeyHSD (aov(mpg ~ as.factor(gear), data = mtcars))


summary(lm(mpg~gear, data=mtcars))
        


leveneTest(mpg~as.factor(gear), data=mtcars)




plot(mtcars$wt, mtcars$mpg, )

cov(mtcars$wt, mtcars$mpg)

cor.test(mtcars$wt, mtcars$mpg)
# 
# This means the true linear correlation 
# coefficient is NOT zero so computed 
# sample estimate of this correlation 
# coefficient as -0.87 is a valid estimate 
# (Conclusion)

# linear regresion


# how to assess it

# for L: Linearity
# graphical 
# scatterplot of residual
# plot(lm1,which=1,col=c('blue'))
# If the LOESS line lies in the zero line of the y-axis then residuals are linear
# confirmative
# summary(lm1$residuals)
# If the mean of the residuals is zero then the residuals are linear

# for I: Independence
# graphical 
# Autocorrelation Function Plot (ACF) of residual
# acf(lm1$residuals)
# If the plot shows “ups” and “down” bars on x-axis then no autocorrelation
# confirmative
# library(car)
# durbinWatsonTest(lm1)

# for I: Independence
# graphical 
# Histogram/Normal Q-Q plot of residual
# plot(lm1, which=2, col=c("blue"))
# IIf histogram is bell-shaped or values line in the diagonal like of the Q-Q plot 
# then residuals are normally distributed
# confirmative
# library(car)
# shapiro.test(lm1$residuals)
# If the p-value > 0.05, residuals follow the normal distributio

# for I: Independence
# graphical 
# Equal variance of residual
# plot(lm1, which=3, col=c("blue"))
# If the values are distributed randomly in the plot then homoscedasticity
# then residuals have equal variance
# confirmative
# library(lmtest)
# bptest(lm1)

library(tidyverse)
library(caret)
library(car)
titanic <- read_csv("titanic.csv")
data <- titanic[,-3]
data$Pclass <- as.factor(data$Pclass)
data$Sex <- as.factor(data$Sex)
model.full <- glm(Survived ~., 
                  data=data, family = binomial)
summary(model.full)

# Intercept and first five 
# variables are statistically significant!
exp(coef(model.full))


ibrary(ggplot2)
ggplot(data, aes(x=Age, 
                 y=Survived)) + geom_point() + 
  stat_smooth(method="glm", 
              family="binomial", se=FALSE)
library(car)
vif(model.full)

# predictons

predict <- predict(model.full, 
                   type="response")

predcted.fm <- as.numeric(ifelse(predict>0.5,1,0))

(cm <- table(predcted.fm, 
             data$Survived))

(accuracy <- sum(diag(cm))/sum(cm))
(error <- (1 - accuracy))


(sensitivity <- cm[1,1]/(cm[1,1]+cm[2,1]))
(FNR <- 1 - sensitivity)

(specificity <- cm[2,2]/(cm[2,1]+cm[2,2]))
(FPR <- 1 - specificity)


library(caret)

predicted <-
  factor(ifelse(predict>0.5,1,0))
reference <- factor(data$Survived)
confusionMatrix(predicted, reference)

library(ROCR)
ROCRpred <- prediction(predict, 
                       data$Survived)
ROCRperf <-
  performance(ROCRpred, 
              'tpr','fpr')

plot(ROCRperf, colorize = TRUE, text.adj = c(-0.2,1.7))
library(pROC)
predicted <-
  as.numeric(predicted)


roc1 <- roc(reference, predicted)

# roc1\




# data sience approach

ind <- sample(2, nrow(data), 
              replace = T, prob = c(0.7, 0.3))
train <- data[ind==1,]
test <- data[ind==2,]
model.train <- glm(Survived ~., 
                   data=train, family = binomial)
summary(model.train)
predict.train <-
  predict(model.train, 
          type="response")


(cm <-
    table(predicted.train,train$Survived))


predicted.train <- factor(ifelse(predict.train>0.5,1,0
))
reference.train <- factor(train$Survived)
confusionMatrix(predicted.train, 
                  reference.train)


# naive bais

set.seed(33)
library(e1071)
library(tidyverse)
library(caret)
titanic <- read_csv('titanic.csv')

ind <- sample(2, nrow(titanic), 
              replace = T, prob = c(0.7, 0.3))

train <- titanic[ind==1,]
test <- titanic[ind==2,]
model.nb <- naiveBayes(Survived~., data=train)


model.nb

y_pred <- predict(model.nb, 
                  newdata = test)


cm <- table(test$Survived, 
            y_pred)

library(caret)
confusionMatrix(cm)


model.svm <- svm(formula = Survived ~ ., data = 
                   train, type = "C-classification", 
                kernel = "linear")
model.svm

y_pred.svm <-
  predict(model.svm, newdata = test)

cm.svm <-
  table(y_pred.svm,test$Survived)

confusionMatrix(cm.svm)
confusionMatrix(predict_lr.test, factor(test_lr$am))



# decision tree control mmechanism
library(party)
tree1 <- ctree(NSPF ~ LB+AC+FM, 
               data=train, controls = 
                 ctree_control(mincriterion=0.99, 
                               minsplit=500))
# bagging
library(ipred)

library(randomForest)


tuneRF()

# PCA
data <- USArrests

library(dplyr)

USArrests.1 <- USArrests[,-3] %>% 
  scale

pca.1 <- prcomp(USArrests.1)
summary(pca.1)


library(psych)
fa.1 <- psych::principal(USArrests.1, nfactors = 3, rotate = "none")
fa.1

biplot(fa.1, labels = rownames(USArrests.1))


library(factoextra)
library(FactoMineR)

str(USArrests)

pca.data <- USArrests[,-3]

res.pca <- PCA(pca.data, graph=F)
res.pca$eig


fa.2 <- psych::principal(USArrests.1, 
                         nfactors = 3, rotate = "varimax")

biplot(fa.2, labels = rownames(USArrests.1))


var_explained = pca.1$sdev^2 / sum(pca.1$sdev^2)

library(ggplot2)
qplot(c(1:3), var_explained) + 
  geom_line() + 
  xlab("Principal Component") + 
  ylab("Variance Explained") +
  ggtitle("Scree Plot") +
  ylim(0, 1)

fa.3 <-
  psych::principal(USArrests.1, 
                   nfactors = 2, rotate = "none")

biplot(fa.3, labels = rownames(USArrests.1))


# MDS

USArrests.1 <- scale(USArrests[,-3])
state.disimilarity <- dist(USArrests.1)
mds.1 <- cmdscale(state.disimilarity)
summary(mds.1)

plot(mds.1, pch = 19)
abline(h=0, v=0, lty=2)
text(mds.1, pos = 4, labels = rownames(USArrests.1), col = 'tomato')

mds.2 <-
  MASS::sammon(state.disimilarity, trace = FALSE)

plot(mds.2$points, pch = 19)
abline(h=0, v=0, lty=2)
text(mds.2$points, pos = 4, 
     labels = rownames(USArrests.1))


arrows(
   x0 = mds.2$points[,1], y0 = 
    mds.2$points[,2], 
   x1 = pca.1$x[,1], y1 = 
    pca.1$x[,2], 
   col='red', pch=19, cex=0.5)


# kmeans

set.seed (2)
x <- matrix(rnorm (50 * 2), ncol = 2)
x[1:25, 1] <- x[1:25, 1] + 3
x[1:25, 2] <- x[1:25, 2] - 4


km.out <- kmeans(x, 2, nstart = 20)


plot(x, col = (km.out$cluster + 1),
     main = "K-Means Clustering 
Results with K = 2",
     xlab = "", ylab = "", pch = 20, cex = 
       2)

set.seed (4)
km.out <- kmeans(x, 3, nstart = 20)

plot(x, col = (km.out$cluster + 1),
     main = "K-Means Clustering 
Results with K = 3",
     xlab = "", ylab = "", pch = 20, cex = 
       2)


par(mfrow = c(1, 2))
plot(x, col = (km.out$cluster + 1),
     main = "K-Means Clustering 
Results with K = 2",
     xlab = "", ylab = "", pch = 20, cex = 
       2)

set.seed (4)
km.out <- kmeans(x, 3, nstart = 20)

plot(x, col = (km.out$cluster + 1),
     main = "K-Means Clustering 
Results with K = 3",
     xlab = "", ylab = "", pch = 20, cex = 
       2)


par(mfrow = c(1, 1))



set.seed (4)
 km.out <- kmeans(x, 3, nstart = 
                     1)
 km.out$tot.withinss
 
 km.out <- kmeans(x, 3, nstart = 
                    20)
  km.out$tot.withinss