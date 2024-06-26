
# Work 1: Use “airquality” data of R and locate median of “Temp” variable graphically

# Determine the class intervals using a statistical rule, such as Sturges' rule
intervals <- ceiling(log2(length(airquality$Temp)) + 1)

# Create class intervals using cut() function
temp_intervals <- cut(airquality$Temp, breaks = intervals)


# Get the frequencies in each class interval
temp_freq <- table(temp_intervals)
# Calculate cumulative frequencies for each interval
cum_freq_more_than <- cumsum(temp_freq)
cum_freq_less_than <- rev(cumsum(rev(temp_freq)))
cum_freq_more_than


h <- hist(airquality$Temp, breaks = intervals, main = "Histogram with Cumulative Frequency Curves",
          xlab = "Temperature", ylab = "Frequency", border = "white")
abline(v = median(airquality$Temp), col = 'black', lty = 2, xlim = c(50, 110))
par(new=TRUE)
with (h, {plot(cum_freq_more_than, col = "blue", type = "o", lwd = 2, lty = 2, axes = FALSE,
               xlab = "", ylab = "")
  lines(cum_freq_less_than, type = "o", col = "red", lwd = 2, lty = 2)
})
# Add legend
legend("topright", legend = c("Median", "Less Than Ogive", "More Than Ogive"),
       col = c("black", "blue", "red"), lty = c(2, 2, 2), cex=0.6)


# Work 2: Use “airquality” data of R and locate mode of “Temp” variable graphically

# Histogram of Temperature (Temp) variable
my_histogram <- hist(airquality$Temp,
                     main = "Histogram Of Temperature (Temp) Variable",
                     xlab = "Temperature",
                     ylab = "Frequency",
                     col = 'white')

# Find the location of the highest bar
max_bar_my_histogram <- which.max(my_histogram$counts)

# Get the leftmost and rightmost values of the highest bar
max__left_value_my_histogram <- my_histogram$breaks[max_bar_my_histogram]
max__right_value_my_histogram <- my_histogram$breaks[max_bar_my_histogram + 1]

# Get the highest count value
max_value_hist <- my_histogram$counts[max_bar_my_histogram]

# Get the locations of the left and right adjacent bars
loc_left_adj <- max_bar_my_histogram - 1
loc_right_adj <- max_bar_my_histogram + 1

# Get the rightmost frequency count value for the left adjacent bar and the leftmost frequency count value for the right adjacent bar
left_adj_bar_rightmost_count <- my_histogram$counts[loc_left_adj]
right_adj_bar_leftmost_count <- my_histogram$counts[loc_right_adj]

# Calculate the slopes for the left and right diagonals
slope_1 <- (max_value_hist - left_adj_bar_rightmost_count) / (max__right_value_my_histogram - max__left_value_my_histogram)
slope_2 <- (right_adj_bar_leftmost_count - max_value_hist) / (max__right_value_my_histogram - max__left_value_my_histogram)

# Calculate the equations of the left and right diagonals
eqn_1_line1 <- paste("y -", left_adj_bar_rightmost_count, "=", slope_1, "(x -", max__left_value_my_histogram, ")", sep="")
eqn_2_line2 <- paste("y -", max_value_hist, "=", slope_2, "(x -", max__left_value_my_histogram, ")", sep="")

# Calculate the constants for the left and right diagonals
constants_1 <- left_adj_bar_rightmost_count - slope_1 * max__left_value_my_histogram
constants_2 <- max_value_hist - slope_2 * max__left_value_my_histogram

# Calculate the intersection point
x_intersect <- (constants_2 - constants_1) / (slope_1 - slope_2)
y_intersect <- slope_1 * x_intersect + constants_1

# Draw the diagonals and the intersection point
segments(max__right_value_my_histogram, max_value_hist, max__left_value_my_histogram, left_adj_bar_rightmost_count, col = "orange")
segments(max__left_value_my_histogram, max_value_hist, max__right_value_my_histogram, right_adj_bar_leftmost_count, col = "red")
abline(v = x_intersect, col = 'brown', lty = 2)

calculate_mode <- function(x) {
  unique_values <- unique(x)
  frequencies <- tabulate(match(x, unique_values))
  mode <- unique_values[which.max(frequencies)]
  return(mode)
}

# Calculate and draw the mode and median
mode <- calculate_mode(airquality$Temp)
abline(v = mode, col = 'purple', lty = 2)
median_temp <- median(airquality$Temp)
abline(v = median_temp, col = '#543533', lty = 2)

# Add legend
legend('topleft', legend = c("Left Diagonal", "Right Diagonal", "Intersection Point", "Mode", "Median"),
       col = c("orange", "red", "brown", 'purple', "#543533"), lty =c(1,1,2,2,2), cex = 0.6)


# Work 3

library(igraph)
library(readr)

# load the data from the current workspace in the object sna then 
sna <- read.csv('sna.csv')
head(sna)

# since selecting first and column from the dataframe
sna <- sna[,1:2]
head(sna)

# now saving network graph data object “net” with directed = T argument
net <- graph_from_data_frame(sna, directed = TRUE)
net


# check number of the vertices, edges. degree of the 'net' and interpret the carefully

# number of vertices
vcount(net)

# number of edges
ecount(net)

## degree
degree(net)

# create histogram of net degree and interpret it carefully
hist(degree(net), main = "Histogram of Net Degree",
     xlab = "Degree of vertices", ylab = "Number Of Nodes",
     col = 'steelblue')

# Interpretation: The histogram shows the distribution of vertex degrees in the network.
# Most nodes have a degree between 0 and 10, indicating that they are connected to a small number of other nodes. 
# There are fewer nodes with higher degrees, indicating that there are some nodes that serve as hubs or connectors within the network.
# Get network diagram of “net” and interpret it carefully


plot(net, edge.size = 15, edge.color = 'red',
     vertex.size = 10, vertex.color = 'green',edge.arrow.size = 0.1 )

# Interpretation: The network diagram shows the connections between nodes in the network. 
# Nodes are represented as circles (vertices), and edges between them represent connections. 
# The size and color of vertices and edges can be adjusted for better visualization. 
# Here, edges are in red, and vertices are in green.


# Get network diagram of “net” with kamada.kawai layout and interpret it carefully
plot(net, edge.size = 10, edge.color = 'red',
     vertex.size = 20, vertex.color = 'green',
     layout = layout.kamada.kawai)

# Interpretation: The Kamada-Kawai layout algorithm positions the nodes in the graph based on the strength of 
# their connections. Nodes that are more closely connected are placed closer together, while nodes with weaker 
# connections are positioned farther apart. This layout can help reveal the overall structure and 
# clustering of the network.


# Get hubs using hubs score and interpret it carefully
# Get hubs using hubs score and interpret it carefully
hubs <- hub_score(net)$vector
hubs

# Interpretation: The hubs scores represent the centrality of each node in the network, 
# indicating how important or central each node is in terms of connecting to other nodes. 
# Higher hub scores suggest nodes that act as hubs or connectors within the network.


# Get authority using authority score and interpret it carefully
authority <- authority_score(net)$vector
authority

# lets plot 2 network diagram side by side
# with 1 row and 2 column
#
# plot for hubs
par(mfrow=c(1, 2))
set.seed(123)
plot(net,
     vertex.size=10, 
     main = "Hubs",
     vertex.color = rainbow(52),
     edge.arrow.size=0.1,
     layout = layout.kamada.kawai)

# plot for authorities
plot(net,
     vertex.size=10, 
     main = "Authorities",
     vertex.color = rainbow(52),
     edge.arrow.size=0.1,
     layout = layout.kamada.kawai)


# Interpretation: The authority scores represent the level of expertise or influence of each node in the network. 
# Nodes with higher authority scores are considered more authoritative or influential within the network.
# Get community using the a special network diagram parameter and interpret it carefully

# Perform community detection using Louvain method
communities <- cluster_walktrap(net)
communities

# Get the membership vector indicating which community each node belongs to
membership <- membership(communities)
membership

# Plot the network with communities highlighted
par(mfrow=c(1, 1))
plot(communities, net, edge.size = 10, edge.color = 'red', vertex.size = 20, vertex.color = 'green')


# Interpretation
# The plot will display the network with nodes colored according to their community membership.
# Nodes belonging to the same community will have the same color, helping to visually identify distinct
# communities within the network.
# You can also get information about the communities themselves
# Number of communities
num_communities <- length(communities)
num_communities

# Sizes of communities
community_sizes <- sizes(communities)
community_sizes

# Average modularity of the partition
modularity <- modularity(communities)
modularity

# Interpretation
# The number of communities gives you an idea of how fragmented or cohesive the network is. 
# Larger networks may naturally have more communities.
# Community sizes indicate the distribution of nodes among the communities. 
# You might have some dominant communities and some smaller ones.
# Modularity measures how well the network is divided into communities. 
# Higher modularity values indicate a better division, with nodes more densely connected within communities and sparsely connected between communities.



