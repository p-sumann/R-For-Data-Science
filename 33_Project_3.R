library(ggplot2)

data(airquality)

n <- nrow(airquality)

R = 97 - 56
I = round(sqrt((R)))
ggplot(as.data.frame(airquality$Temp), aes(x = x)) +
  geom_line(aes(y = y_lt), color = "blue", size = 1) +
  geom_line(aes(y = y_mt), color = "red", size = 1) +
  labs(title = "Less Than and More Than Ogives",
       x = "Temperature",
       y = "Cumulative Frequency") +
  theme_minimal()





# SNA
library(igraph)
library(graph)
sna_data <- read.csv('sna.csv')


sna_data <- sna_data[,1:2]

net <- graph_from_data_frame(sna_data,directed = T)


