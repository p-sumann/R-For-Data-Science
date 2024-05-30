


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



