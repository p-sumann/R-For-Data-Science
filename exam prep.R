
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
# It means that the linear correlation coefficient is not zero i.e. it is a valid estimate