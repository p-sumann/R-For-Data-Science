data <- c(1,15,12,5,18,11,12,15,18,25)



exp(mean(log(data)))

library(psych)

data = data.frame(col1=c(12,2,3,4),
          col2=c(34,32,1,0),
          col3=c(2,45,3,2))

print(data)

data$col1

harmonic.mean(data$col1)

# goermtic mean use for percatge
# harmonic mean for rate of change per unit

# first moment

kurtosi(data$col1)

skew(data$col1)