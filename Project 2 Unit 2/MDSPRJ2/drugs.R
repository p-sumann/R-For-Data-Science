library(readxl)
library(tidyverse)

mr_drugs <- read_xlsx("MR_Drugs.xlsx")

inco <- mr_drugs %>% select(starts_with('inco'))

d <- mr_drugs %>% select(starts_with('inco')) %>%
  colSums() %>%
  enframe("income", "N") %>%
  mutate(Percent = round(N / sum(N) * 100, 1))

d

income_frequencies <-
  apply(inco, 2, table) %>% t() %>% as.data.frame()
income_frequencies

d <- d %>% 
  mutate(`Percent of Cases` = round(d$N / (d$N + income_frequencies[, 1]) * 100, 1))


# final version of calculated table
data <- d %>% add_row(
  income = "Total",
  N = sum(d$N),
  Percent = round(sum(d$Percent),2),
  "Percent of Cases" = round(sum(d$`Percent of Cases`),2),
)



data$Percent <- paste0(sprintf("%.1f", data$Percent),"%")
data$`Percent of Cases` <- paste0(sprintf("%.1f", data$`Percent of Cases`),"%")

library(gt)
data %>% gt(rowname_col = 'income') %>% 
  tab_spanner(label='Response',columns = c('N','Percent')) %>% 
  cols_align(align = "center",columns = c("Percent", "N")) %>% 
  tab_header(title = md("$Income Frequencies")) %>% 
  tab_footnote(footnote = "a. Dichotomy group tabulated at value 1") %>%  tab_style(
    style = cell_borders(
      sides = c("left", "right","top","bottom"),
      color = "#d3d3d3",
      weight = px(1.5),
      style = "solid"
    ),
    locations = cells_body()
  )


