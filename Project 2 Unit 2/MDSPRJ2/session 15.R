library(tidyverse)

ggplot(diamonds, aes(carat, price)) + geom_point() + scale_x_continuous() +
  scale_y_continuous()


ggplot()
layer(
  data = diamonds,
  mapping = aes(x = carat, y = price),
  geom = 'point',
  stat = 'identity',
  position = 'identity') +
  
  scale_y_continuous() + scale_x_continuous() + coord_cartesian()


qplot(carat, price, data = diamonds)


ggplot(diamonds, aes(carat, price)) + geom_point() +
  stat_smooth(method=lm)+scale_x_log10()+scale_y_log10()
# log transformation changes the value into percent

qplot(carat, price, data = diamonds, geom = c('point','smooth'), method = "lm",
log = "xy")


ggplot(data = diamonds, mapping = aes(price)) + geom_histogram(stat = 'bin',
                                                               position = 'identity')


ggplot(diamonds, aes(price)) + geom_histogram()

qplot(price, data = diamonds , geom = 'histogram')


ggplot(diamonds, aes(x="",fill=clarity)) + geom_bar(width = 1) + coord_polar(theta = 'y')

ggplot(diamonds, aes(x="",fill=clarity)) + geom_bar(width = 1) + coord_polar(theta = 'y')+theme_void()

str(mpg)





ggplot(data=mpg) + aes(x=displ, y = hwy) + geom_point() + stat_smooth(method = 'lm', se = FALSE)

ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y = hwy))
                                                                      

cor(mpg$displ, mpg$hwy)


# test of correalation 


ggplot(data=diamonds) + aes(x=carat, y = price) + geom_point() + stat_smooth(method = 'lm', se = FALSE) + scale_x_log10() + scale_y_log10()
cor.test(mpg$displ, mpg$hwy)
# t = -18.151, df = 232, p-value < 2.2e-16

# formula 
# r * sqrt(n-2) / sqrt(1-r^2)


cor(diamonds$price, diamonds$carat)

cor.test(diamonds$price, diamonds$carat)

# linear use pearson
# non linear spearman

# to convert into linear data if data is not linear use log 10

ggplot(mpg, aes(displ, hwy, color=class)) + geom_point()

ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y = hwy, alpha=class))

ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y = hwy, shape=class))

ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y = hwy, size=as.factor(class)))


ggplot(data=mpg) + 
  geom_point(mapping = aes(displ, y = hwy), color='blue')

ggplot(data=mpg) + 
  geom_point(mapping = aes(displ, y = hwy)) + facet_wrap(~class, nrow=2)

ggplot(data = mpg) + geom_point(mapping = aes(displ, hwy)) + facet_grid(drv~cyl)

ggplot(data = mpg) + geom_point(mapping = aes(displ, hwy)) + facet_grid(drv~ .) #horizontal

ggplot(data = mpg) + geom_point(mapping = aes(displ, hwy)) + facet_grid(. ~ cyl) #vertical

ggplot(data = mpg, mapping = aes(displ, hwy)) + geom_point() + geom_smooth()


# use smooth if data is not linear use polynomial fit


ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y = hwy, color=class)) + geom_smooth()

ggplot(data=mpg, mapping = aes(displ, hwy)) + geom_point(mapping = aes(color=class)) + geom_smooth()


ggplot(data=mpg, mapping = aes(displ, hwy)) + geom_point(mapping = aes(color =class))+
  geom_smooth(data=filter(mpg,class=='subcompact'),se=FALSE)

ggplot(diamonds) + stat_count(mapping = aes(x=cut))

ggplot(diamonds) + geom_bar(mapping = aes(x=cut))


ggplot(diamonds) + stat_summary(
  mapping = aes(cut, depth),
  fun.min = min,
  fun.max = max,
  fun = median)



ggplot(diamonds) + geom_bar(mapping = aes(cut,color=cut))

ggplot(diamonds) + geom_bar(mapping = aes(x=cut, fill = cut))

ggplot(diamonds) + geom_bar(mapping = aes(cut,fill=clarity))


ggplot(data=diamonds, mapping = aes(x=cut, color=clarity)) + geom_bar(fill=NA, position = 'identity')

ggplot(data=diamonds, mapping = aes(x=cut, fill=clarity)) + geom_bar(position = 'dodge')


