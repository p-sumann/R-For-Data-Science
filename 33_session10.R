library(tidyverse)
library(nycflights13)
library(DBI)


iris_db <- src_sqlite('iris_dbsqlite3',create=TRUE)

iris_sqlite <- tbl(iris_db, 'iris')


con <- DBI::dbConnect(duckdb::duckdb(), dbdir = "duckdb")

con

d <- data.frame(x= rnorm(10000), y=rnorm(10000))

ggplot(d, mapping = aes(x,y))

