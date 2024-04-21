aq <- airquality

hist(aq$Ozone)
plot(density(aq$Ozone,na.rm=T))
qqnorm(aq$Ozone)
qqline(aq$Ozone, col=2)
shapiro.test(aq$Ozone)

hist(aq$Solar.R)
plot(density(aq$Solar.R,na.rm=T))
qqnorm(aq$Solar.R)
qqline(aq$Solar.R, col=2)
shapiro.test(aq$Solar.R)

# testing normality for wind
hist(aq$Wind)
plot(density(aq$Wind,na.rm=T))
qqnorm(aq$Solar.R)
qqline(aq$Solar.R, col=2)
shapiro.test(aq$Wind)

# testing normality for wind
# goodness of fit
hist(cars$speed)
plot(density(cars$speed,na.rm=T))
qqnorm(cars$speed)
qqline(cars$speed,col=2)
shapiro.test(cars$speed)


# test of normality: types
# sekwness and kurtosis based
# # jarque-bera test of normality

# larges sample based
# kolmogorav-smirnov test of normality
# ks.test(cars$speed)

# small sample based 
# shapiro wil test of normality


# multiple graph in single wind

x <- rnorm(500)
y <- x + rnorm(500)


my_ts <-
  ts(
    matrix(x,
    nrow = 500,
    ncol = 1),
    start = c(1950, 1),
    frequency = 12
  )

my_dates <- seq(as.Date("2005/1/1"),by="month",length=50)


my_factor <- factor(mtcars$cyl)

fun <- function(x) x^2

par(mfrow=c(2,3))
plot(x,y,main="Scatterplot")
plot(my_factor,main="Scatterplot")
plot(my_factor, rnorm(32), main="Boxplot")
plot(my_ts, main="Time Series")
plot(my_dates, rnorm(50), main= "Time Base plot")
plot(fun, 0, 10, main="Plot a function")
par(mfrow=c(1,1))
plot(trees[,1:3], main="Correlation Plot")

# if linear use pearson coeffiecent
# if not linear use spearman coeffiecent


# bi serial 
# for testing both categorical and continuous  

j <- 1:20
k <- j
par(mfrow=c(1,3))

plot(j,k,type="l",main="type = 'I'")

plot(j,k,type="s",main="type = 's'")
plot(j,k,type="p",main="type = 'p'")

par(mfrow=c(1,3))

plot(j,k,type="o",main="type = 'o'")

plot(j,k,type="b",main="type = 'b'")
plot(j,k,type="h",main="type = 'h'")


r <- c(sapply(seq(5, 25, 5), function(i) rep(i,5)))

t <- rep(seq(25, 5, -5), 5)

plot(r, t, pch=1:25, cex=3, yaxt="n", xaxt="n",ann=F,xlim=c(3,27),lwd=1:3)

plot(
  r,
  t,
  pch = 21:25,
  cex = 3,
  yaxt = "n",
  xaxt = "n",
  ann = F,
  xlim = c(3, 27),
  lwd = 1:3,
  col = rainbow(25)
)


plot(x,y, pch=21, bg="red",col="blue",cex=3,lwd=3)
# why values in the scatterplot lie in the range of -4 to 4
# x <- rnom(5)

plot(x,y, main=latex2exp::TeX('$\\beta^3,\\beta\\in 1 \\ | dots 10$'))


# networks
# graph analysis

# Session 15
# SNA Basics
library(graph)
library(igraph)
library(Rgraphviz)

g <- graph((c(1,2)))
plot(g)
plot(g, vertex.color='green',vertex.size=40,edge.color='red', edge.size=20)


g <- graph(c(1,2,2,3,3,4,4,1))
plot(g, vertex.color='green',vertex.size=40,edge.color='red', edge.size=20)


g <- graph(c(1,2,2,3,3,4,4,1),directed = F)
plot(g, vertex.color='green',vertex.size=40,edge.color='red', edge.size=20)

g <- graph(c(1, 2, 2, 3, 3, 4, 4, 1), directed = F, n = 7)
plot(g, vertex.color='green',vertex.size=40,edge.color='red', edge.size=20)


# defining nodes with text data

g1 <- graph(c("Sita","Ram","Ram","Rita","Rita","Sita","Sita","Rita","Anju","Ram"))
plot(g1, vertex.color='green',vertex.size=40,edge.color='red', edge.size=20)

igraph::degree(g1)

igraph::degree(g1, mode="in")

diameter(g1, directed = F)

edge_density(g1, loops = F)


# edge density
ecount(g1) / (vcount(g1)*(vcount(g1-1)))

reciprocity(g1)

closeness(g1, mode='all', weights=NA)

betweenness(g1, directed = T, weights = NA)

