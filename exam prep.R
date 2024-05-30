


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
