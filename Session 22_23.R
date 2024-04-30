# simple linear regression

# gradient descent 

lm1 <- lm(mpg~wt, data=mtcars)

mse <- mean(lm1$residuals^2)

data <- data.frame(pred=predict(lm1), actual=mtcars$mpg)

head(data)

mean((data$actual-data$pred)^2)

rmse <- sqrt(mean(lm1$residuals^2))

mae <- abs(lm1$residuals)

library(caret)

R2 <- R2(data$pred, data$actual)
# weight alone variable alone can explain 75% of the variance by the linear model.

RMSE <- RMSE(data$pred, data$actual)

MAE <- MAE(data$pred, data$actual)

MAPE <- MAPE(data$pred, data$actual)

mean(abs((data$pred - data$actual) / data$actual)) * 100

new.wt <- data.frame(wt=6)

predict(lm1, newdata = new.wt)

# validation and cross-validation for predictive modelling including linear model

# validation/cross validation can be done with:
  
# validation set(data split)

# leave one out cross validation (LOOCV)
# k fold cross validation
# repeated k fold validation

# here the full data in randomly divided into two sets:
# training set
# testing set (validation set)

data <- mtcars

set.seed(1234)

ind <- sample(2, nrow(mtcars), replace = T, prob = c(0.7, 0.3))

# data partition
train.data <- data[ind==1,]
test.data <- data[ind==2,]

lm4 <- lm(mpg~wt, data=train.data)

library(dplyr)

predictions <- lm4 %>% predict(test.data)

# model accuray of train data

summary(lm4)

# model accuracy of test data data
R2 <- R2(predictions, test.data$mpg)
RMSE <- RMSE(predictions, test.data$mpg)
MAE <- MAE(predictions, test.data$mpg)


# LOOCV
train.control <- trainControl(method='LOOCV')

#train the model

model1 <- train(mpg~wt, data=mtcars, method='lm',trControl=train.control)

prediction1 <- model1 %>% predict(test.data)

df <- data.frame(R2=R2(prediction1,test.data$mpg),RMSE=RMSE(prediction1,test.data$mpg),
                 MAE=MAE(prediction1,test.data$mpg))


set.seed(123)

train.control <- trainControl(method = 'cv', number=10)

model2 <- train(mpg~wt, data=mtcars, method='lm',trControl=train.control)
model2

prediction2 <- model2 %>% predict(test.data)

df2 <- data.frame(
  R2 = R2(prediction2, test.data$mpg),
  RMSE = RMSE(prediction2, test.data$mpg),
  MAE = MAE(prediction2, test.data$mpg)
)

set.seed(123)
train.control <- trainControl(method='repeatedcv', number=10, repeats = 3)

model3 <- train(mpg~wt, data=mtcars, method='lm', trControl=train.control)

prediction3 <- model3 %>% predict(test.data)

df3 <- data.frame(R2=R2(prediction3,test.data$mpg),
                  RMSE=RMSE(prediction3, test.data$mpg),
                  MAE=MAE(prediction3,test.data$mpg))

# multiple linear regression:
# It is an extension of the simple lienar regression

mlr <- lm(mpg~., data=mtcars)
summary(mlr)

library(car)

vif(mlr)

mlr1 <- lm(mpg~cyl+hp+drat+wt+qsec+am+gear+carb, data=mtcars)
summary(mlr)

vif(mlr1)


mlr2 <- lm(mpg~hp+drat+wt+qsec+am+gear+carb, data=mtcars)
summary(mlr2)

vif(mlr2)

summary(mlr2)



# raw polynomial 

set.seed(123)

ind <- sample(2, nrow(boston),replace = T, prob=c(0.8,0.2))

train.data <- boston[ind==1,]
test.data <- boston[ind==2,]

# training set with scaling
train_x <- train.data[,-14]
train_x <- scale(train_x)[,]
train_y <- train.data[,14]

# testing set witb scaling
test_x <- test.data[,-14]
test_x <- scale(test.data[,-14])[,]
test_y <- test.data[,14]

library(caret)
knnmodel <- knnreg(train_x, train_y)
str(knnmodel)

pred_y <- predict(knnmodel, data.frame(test_x))


pred <- data.frame(test_y,pred_y)

R2(test_y, pred_y)


# single layer feed foward neutral netwoek

data <- Suman_paudel_covnep_252days_Suman_paudel_covnep_252days


