# # Task 1
# 
# # Part 1
# 
# covnep_252days <- read.csv('covnep_252days.csv')
# 
# responses <- c("Strongly agree", "Agree", "Neither", "Disagree", "Strongly disagree")
# counts <- c(270, 1338, 735, 187, 41)
# 
# # Convert to a data frame
# data <- data.frame(Valid = "", Responses = responses, Frequency = counts)
# 
# # Calculate percentages and cumulative percentages
# data$Percent <- round(data$Frequency / sum(data$Frequency) * 100, 1)
# data$Cumulative_Percent <- cumsum(data$Percent)
# 
# # Print the result
# result <- data
# names(result) <- c("Valid", "Frequency", "Percent", "Valid Percent", "Cumulative Percent")
# 
# 
# 
# 
# 
# gt_tbl <-
#   gtcars |>
#   dplyr::select(model, year, starts_with("hp"), msrp) |>
#   dplyr::slice(1:4) |>
#   gt(rowname_col = "model") |>
#   tab_spanner(label = "performance",
#               columns = starts_with("hp"))
# 
# gt_tbl |> tab_info()
# 
# 
# 
# 
# 
# 
# pizzaplace |>
#   dplyr::group_by(type, size) |>
#   dplyr::summarize(
#     sold = dplyr::n(),
#     income = sum(price),
#     .groups = "drop"
#   ) |>
#   gt(rowname_col = "size", groupname_col = "type") |>
#   tab_header(title = "Pizzas Sold in 2015") |>
#   fmt_integer(columns = sold) |>
#   fmt_currency(columns = income) |>
#   summary_rows(
#     fns = list(label = "All Sizes", fn = "sum"),
#     side = "top",
#     fmt = list(
#       ~ fmt_integer(., columns = sold),
#       ~ fmt_currency(., columns = income)
#     )
#   ) |>
#   tab_options(
#     summary_row.background.color = "gray95",
#     row_group.background.color = "#FFEFDB",
#     row_group.as_column = TRUE
#   ) |>
#   tab_stub_indent(
#     rows = everything(),
#     indent = 2
#     
#     
#     
#     
#     
#     
#     
#     
#     
#     sp500 |>
#       dplyr::filter(date >= "2015-01-05" & date <= "2015-01-16") |>
#       dplyr::arrange(date) |>
#       dplyr::mutate(week = paste0("W", strftime(date, format = "%V"))) |>
#       dplyr::select(-adj_close, -volume) |>
#       gt(
#         rowname_col = "date",
#         groupname_col = "week"
#       ) |>
#       summary_rows(
#         fns = list(
#           "max",
#           list(label = "avg", fn = "mean")
#         ))
#     
#     # Load the necessary libraries
#     library(gt)
#     library(dplyr)
#     
#     # Create a data frame with the existing data
#     result_df <- data.frame(
#       Level = c("Strongly agree", "Agree", "Neither", "Disagree", "Strongly disagree"),
#       Frequency = c(270, 497, 702, 383, 2571),
#       Percent = c(10.50175, 19.331, 27.30455, 14.89693, 100),
#       Valid_Percent = c(10.50175, 19.331, 27.30455, 14.89693, 100),
#       Cumulative_Percent = c(10.50175, 19.331, 27.30455, 14.89693, 100)
#     )
#     
#     # Create a gt table
#     result_table <- result_df %>%
#       gt(rowname_col = "Level", groupname_col = 'Vali') %>%
#       summary_rows(
#         fns = list(Total = "sum"))
#       )
#     result_table
#     
#     
#     sp500 |>
#       dplyr::filter(date >= "2015-01-05" & date <= "2015-01-16") |>
#       dplyr::arrange(date) |>
#       dplyr::mutate(week = paste0("W", strftime(date, format = "%V"))) |>
#       dplyr::select(-adj_close, -volume) |>
#       gt(
#         groupname_col = "week"
#       ) |>
#       summary_rows(
#         fns = list(
#           "min",
#           "max",
#           list(label = "avg", fn = "mean")
#         )
#       )
#     
#     
# 
#     




