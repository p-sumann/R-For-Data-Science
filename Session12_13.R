
# load
gd <- as.data.frame(VADeaths)
barplot(gd$`Rural Male`)

barplot(
  gd$`Rural Male`,
  names.arg = c('50-54', '55-59', '60-64', '65-69', '70-74'))

# title and x and y axis labael
barplot(
  gd$`Rural Male`,
  names.arg = c('50-54', '55-59', '60-64', '65-69', '70-74'),
  main = "Death Rate in Virginia, USA",xlab = 'Age Group',ylab = 'Rate')

# horiz and color
barplot(
  gd$`Rural Male`,
  names.arg = c('50-54', '55-59', '60-64', '65-69', '70-74'),
  horiz = T,
  main = "Death Rate in Virginia, USA",
  xlab = 'Age Group',
  ylab = 'Rate',
  col = "#FD625E",
  border = "red"
)

# add values of range for x axis
# normal barchart
barplot(
  gd$`Rural Male`,
  names.arg = c('50-54', '55-59', '60-64', '65-69', '70-74'),
  horiz = T,
  main = "Death Rate in Virginia, USA",
  xlab = 'Age Group',
  ylab = 'Rate',
  col = "#FD625E",
  border = "red",
  xlim = c(0,70),cex.axis = .80,
  )

# sub divide /stacked bar diagram:
# stacked barchart
# barplot(gd,col = c('lightblue','mistyrose','lightcyan','lavender','cornsilk',legend=rownames(gd)))
my_color <- c('lightblue','mistyrose','lightcyan','lavender','cornsilk')

gdm <- as.matrix(gd)
barplot(gdm, col = my_color)
legend("topleft",legend = rownames(gdm),fill = my_color,box.lty = 0, cex = 0.8)


# bargraph for multiple or group bar diagram
# barplot(gd,col = c('lightblue','mistyrose','lightcyan','lavender','cornsilk',legend=rownames(gd)))
my_color <- c('lightblue','mistyrose','lightcyan','lavender','cornsilk')

gdm <- as.matrix(gd)
barplot(gdm, col = my_color,beside = T,)
legend('topleft', legend = rownames(gdm),box.lty = 0,cex = 0.5,fill = my_color)


# Histogram, Q-Q and Desntity plots;
# usedd to represent continous variavble graphically
# converts continuous data into calssclass intervarl which R calls breaks


gdcar <- as.data.frame(cars)
hist(gdcar$speed,main = "Speed Distribution",ylim = c(0,20),col = "#01B8AA")

hist(gdcar$speed,main = "Speed Distribution",ylim = c(0,20),col = "#01B8AA",breaks = 10)

# use mean if data is normally distributed
# if S.D if you are using mean
# use median if data is skewed
# use IQR, Q1 and Q2 if using median

# qq plot with qq line to assess normaliity

qqnorm(gdcar$speed)

qqline(gdcar$speed,col="green")


# use density plot 
density(cars$speed)
plot(
  density(cars$speed),
  frame = FALSE,
  col = 'steelblue',
  main = "Density Plot of MPG"
)
polygon(density(cars$speed),col = 'steelblue')



# piechart

pie(gd$`Rural Male`,labels = rownames(gd),raidus=1)
pie(
  gd$`Rural Male`,
  labels = rownames(gd),
  raidus = 1,
  col = c('#324341', '#487533', '#988272', '#762722', '#327462'),
  
)

gd$pie_percent <- round(100*gd$`Rural Male`/sum(gd$`Rural Male`),1)
pie(
  gd$`Rural Male`,
  labels = gd$pie_percent, main = '%Deaths by Age groups for Rural Male',
  col=rainbow(length(gd$`Rural Male`)))
legend("topright",
       c(
         '50-54',
         '55-59',
         '60-64',
         '65-69',
         '70-74'),
         cex = 0.8,
         fill = rainbow(length(gd$`Rural Male`))
       )



# line chart
# line charts are created for time series data!

plot(cars$speed)
plot(cars$speed)


# using scatterplot

plot(cars$speed,cars$dist)

# use pearson

# use if not linear
# spearedman corelation coefficients()

# box plot

boxplot(mpg ~ cyl, data = mtcars)

# boxplot in R shows outlier
# tukey boxplot
boxplot(mpg ~ cyl, data = mtcars,xlab = 'Number of Cylinders',ylab = 'Miles Per Gallon',main='Milaage Data')


# graph from data frame

barplot(mtcars$mpg)
hist(mtcars$mpg)
plot(density(mtcars$mpg))


# hist is based on density
# barplot is based on frequency

hist(mtcars$mpg,col = 'steelblue')
abline(v=median(mtcars$mpg),lwd=3,lty=2)


hist(mtcars$mpg,col = 'steelblue')
abline(v=(3*median(mtcars$mpg)-2*mean(mtcars$mpg)),lwd=3,lty=2)


# scatter plot iwht horizontal abline

plot(mtcars$mpg, mtcars$wt,pch=16,xlab='MPG',ylab='Wieght')
abline(h=2,col='blue',lwd=2)
abline(h=4,col='blue',lwd=2)

plot(mtcars$mpg, mtcars$wt,pch=16,xlab='MPG',ylab='Wieght')
abline(v=15,col='red',lwd=2)
abline(v=30,col='red',lty=2)

plot(mtcars$wt, mtcars$mpg,pch=16,xlab='MPG',ylab='Wieght')
abline(h=mean(mtcars$mpg),col='red',lwd=2)
abline(h=mean(mtcars$mpg)+sd(mtcars$mpg),col='blue',lwd=2, lty=2)
abline(h=mean(mtcars$mpg)-sd(mtcars$mpg),col='blue',lwd=2, lty=2)



# scatter plot with albine from a model

plot(mtcars$wt,mtcars$mpg, main = 'Scatter Plot wiht abline', xlab='weight', ylab = 'MPG')
reg_mod <- lm(mtcars$mpg ~ mtcars$wt)
abline(reg_mod, col='red')

plot(mtcars$wt,mtcars$mpg, main = 'Scatter Plot wiht abline', xlab='weight', ylab = 'MPG')
reg_mod <- lm(mtcars$mpg ~ mtcars$wt)
abline(reg_mod, col='red')
lines(lowess(mtcars$wt,mtcars$mpg),col='blue',lwd=3)

plot(df$hp, df$disp, main =
       "Scatterplot with model abline",
     xlab = "Horse power", ylab =
       "Displacement")
abline(lm(df$disp ~ df$hp))
lines(lowess(df$hp, df$disp), col =
        "red", lwd = 3)
lines(lowess(df$hp, df$disp, f=1),
      col = "purple", lwd = 3)
lines(lowess(df$hp, df$disp, f=0.1),
        col = "blue", lwd = 3)
