# obe wat anova

# Hnot: mu1 = mu2 = mu3

# assumptions of  way anova

# same as two smpels ttest:


# dependent variable must be normmally distributed for each categories

 # variance acreoss categories must bsample

# normally distributed
# tes of normatlity by each categorical values

# Assumption of One Way ANOVA
# sample should random sample
# variance across categories must be same
# dependent variable must be normally distributed for each categories

# nomra

# table 
table(mtcars$gear)

with(mtcars, shapiro.test(mpg[gear == 3]))


# FISHer -> Least Signicant Different LSD
# TUkey -> HSD Honestly Sigificant Different\
# Bonforrianan
mtcars[mtcars$gear==3]



# lr uses fischer test rather than tuckey test
# takes first value as reference

# porportion test

# hnot 
# h1 atleast one of the propotion pair are not equal

# measure of linear relationship
# lr model scatter plot for linear relationship + test test
# two continous variables have linear or tentative 

# covariance
# problem with maginitute
# 

# never use covarince to measure liear realtionship

cor(mtcars$wt, mtcars$mpg)
# there is high degree of negative linear co relationship

# rho is population 


# tehre is no lieanr realtion between wt and mpg rho = 0
# tehre is  lieanr realtion between wt and mpg rho != 0

# Y = a + bX + u

# BLUE best linear unbaised estimate

# regression models y hat must be in LINE
# L - Linear
# I - Independent
# N - normal distn
# E - equal variance 

# linear regression algorithm

shapiro.test(mtcars$mpg)
# the data is distn

cor.test(mtcars$wt, mtcars$mpg)
# there is relationship

lm1 <- lm(mtcars$mpg~mtcars$wt)
lm1

# coefficient of determination R^2 is 0.752 which is > 0.5

# because ANOVA is less than 0.05 that's why fitted model is valid model

# linear regression with OLS method 
 
# L -  sugesstive (scaterplot(x=yhat, y=residual)) and confirmative (summary(lm1$residuals))
# I - independence of residual it only works only time series data/ cross sectional data
acf()
# auto corelation absest means independence while present means not independence

# normality

# equal variance
# pattern should be randomly distributed else regressoion models fails

# since mean is 0 that;s why it's linear

# if line is valid after blue then we can predict

p <- as.data.frame(6)
colnames(p) <- "wt"


# outliers, leverage points, and influential obeservation in Linear Model

