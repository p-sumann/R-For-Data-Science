library(readr)
library(reshape2)
library(tidyverse)
library(RColorBrewer)


# Load the data
df <- read_csv("Sales.csv")

# Print the shape of the data
dim(df)
head(df)


# Check column info of the data
str(df)
spec(df)

# Check for missing values
colSums(is.na(df))
# print(heatmap(is.na(df), col = "hot"))

# now missing values for invoice
impute_invoice <- function() {
  x <- sample(c(100:999), 10, replace = T)
  y <- sample(c(10:99), 10, replace = T)
  z <- sample(c(100:999), 10, replace = T)
  a <- paste0(x, "-", y, "-", z)
  return (a)
}


df[is.na(df$'Invoice ID'),1] <- impute_invoice()
df

colSums(is.na(df))

# now missing values for unit price
df[is.na(df$'Unit price'),c('Unit price','Total','Tax 5%','Quantity')]
df$'Unit price' <- ifelse(is.na(df$'Unit price'), (df$Total - df$'Tax 5%') / df$Quantity, df$'Unit price')


# missing values for Quantity
head(df[is.na(df$'Quantity'),])
df$'Quantity' <- ifelse(is.na(df$'Quantity'), (df$Total - df$'Tax 5%') %/% df$'Unit price', df$'Quantity')
colSums(is.na(df))

# missing values for Total
df[is.na(df$'Total'),c('Unit price','Total','Tax 5%','Quantity')]
df$'Total' <- ifelse(is.na(df$'Total'), (df$'Unit price' * df$'Quantity') + df$'Tax 5%', df$'Total')
colSums(is.na(df))

# missing values for Tax 5%
df[is.na(df$'Tax 5%'),c('Unit price','Total','Tax 5%','Quantity')]
df$'Tax 5%' <- ifelse(is.na(df$'Tax 5%'), (df$'Total' - (df$'Unit price') * df$'Quantity'), df$'Total')
colSums(is.na(df))

# missing values for Time
df[is.na(df$Time),c('Date', 'Time')]
random_time <- as.character(sample(df$Time,1))
df[is.na(df$Time),'Time'] <- random_time
df$Time <- gsub(":00", "",df$Time)

# missing values for Payment
df[is.na(df$Payment),]
unique(df$Payment)

most_payment <-  names(which.max(table(df$Payment)))
df[is.na(df$Payment),'Payment'] <- most_payment

# missing values for Payment

df[is.na(df$'gross margin percentage'),
       c('Total', 'gross income', 'gross margin percentage')]
df[,c('Total', 'gross income', 'gross margin percentage')]

df[is.na(df$'gross margin percentage'),'gross margin percentage'] <- unique(df$'gross margin percentage')[1]

colSums(is.na(df))

# # Convert the date column to datetime format
df$Date <- as.Date(mdy(df$Date))

# Plot the distribution of different branches


branch_counts <- table(df$Branch)

# Choose a color palette
colors <- brewer.pal(length(branch_counts), "Paired")


explode <- rep(0, length(branch_counts))
explode[which.max(branch_counts)] <- 0.1

ggplot(data.frame(Branch = names(branch_counts), Count = as.numeric(branch_counts)), aes(x = "", y = Count, fill = Branch)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(Count / sum(branch_counts) * 100, 1), "%")), 
            position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = colors) +
  theme_void() +
  theme(legend.position = "right",
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 12)) +
  labs(title = "Branch Distribution")

# Plot the distribution of different cities
ggplot(df, aes(x = City, fill = City)) +
  geom_bar(width = 0.6, color = "white") +
  scale_fill_manual(values = brewer.pal(length(unique(df$City)), "Paired")) +
  labs(title = "Distribution of Different Cities",
       x = "City",
       y = "Count") +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, size = 3.5) +
  ylim(0, 400) +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        axis.title = element_text(size = 12),
        legend.position = "right",
        legend.title = element_blank())

# Plot the distribution of customer types
ggplot(df, aes(x = df$`Customer type`)) + 
  geom_bar(width = 0.5, color = "white", fill='#B33F62') +
  labs(title = "Distribution of customer types", x = "Customer type", y = "Count") + 
  geom_text(stat = "count", aes(label = comma(..count..)), vjust = -0.5, size = 3.5) +
  ylim(0,600) + 
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        axis.title = element_text(size = 12),
        legend.position = "right",
        legend.title = element_blank())
  
  

# Plot the distribution of genders
ggplot(data.frame(Gender = names(table(df$Gender)), Count = as.numeric(table(df$Gender))), aes(x = "", y = Count, fill = Gender)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(Count / sum(branch_counts) * 100, 1), "%")), 
            position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = colors) +
  theme_void() +
  theme(legend.position = "right",
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 12)) +
  labs(title = "Gender Distribution")

  
# Product Line

table(df$`Product line`)

ggplot(df, aes(x = df$`Product line`, fill = df$`Product line`)) +
  geom_bar(width = 0.6, color = "white") +
  scale_fill_manual(values = brewer.pal(length(unique(df$`Product line`)), "Paired")) +
  labs(title = "Distribution of Different Cities",
       x = "City",
       y = "Count") +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, size = 3.5) +
  ylim(0, 200) +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        axis.title = element_text(size = 12),
        legend.position = "right",
        legend.title = element_blank())


# Plot the distribution of unit prices
plot(density(df$`Unit price`,na.rm = T), main = 'Distribution of Unit Price')

# plot scatterplot between total and rating with respect to Branch
ggplot(data=df, aes(x= Total, y= Rating))+
  geom_point(aes(color=Branch, shape=Branch))



# Hypothesis testing: Does gross income increase when total sales increase?
cor.test(df$Total, df$`gross income`)
# it is indeed true, and is statistically significant

# Plot the relationship between total sales and gross income
ggplot(df, aes(x = Total, y = `gross income`)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship between Total and Gross Income",
    x = "Total",
    y = "Gross Income"
  ) +
  theme_classic() +
  xlim(0,1200) + ylim(0,60)

# Plot the relationship between customer type and total sales
ggplot(df, aes(x = Total, color = `Customer type`)) + 
  geom_density() + 
  labs(title = "Relationship between customer type and total sales", x = "Total sales", y = "Density")


# Which branch sales has the highest ratings?
df %>% 
  group_by(Branch) %>% 
  summarise(mean_rating = mean(Rating)) %>% 
  arrange(desc(mean_rating))

# which product is used by different group of Gender

product_usage <- df %>%
  group_by(Gender, `Product line`) %>%
  summarize(Count = n()) %>%
  arrange(desc(Count))


ggplot(product_usage, aes(x = `Product line`, y = Count, fill = Gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Product Usage by Gender",
    x = "Product Line",
    y = "Count",
    fill = "Gender"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.3),
    legend.position = "right"
  )


product_usage_city <- df %>%
  group_by(City, `Product line`) %>%
  summarize(Count = n()) %>%
  arrange(desc(Count))

# Create the plot
ggplot(product_usage_city, aes(x = `Product line`, y = Count, fill = City)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Product Usage by City",
    x = "Product Line",
    y = "Count",
    fill = "City"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.3),
    legend.position = "right"
  ) + ylim(0,80)
