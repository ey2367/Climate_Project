library(plotly)
library(dplyr)
tasks <- c("Season", "Impact 1", "Impact 2", "Impact 3")
start_dates <- as.Date(c("2023-10-01", "2023-11-01", "2023-12-01", "2024-01-01"))
durations <- c(10, 5, 7, 8)
impact_type <- c("Drought", "Food Security", "Drought", "Food Security")

gantt_data <- data.frame(tasks, start_dates, durations, impact_type)     
fig <- plot_ly(gantt_data, x = ~start_dates, xend = ~start_dates + durations, y = ~tasks, type = 'bar', orientation = 'h', text = ~impact_type) %>%
  layout(
    title = "Gantt Chart of ONDJ",
    xaxis = list(title = "Timeline"),
    yaxis = list(title = "Tasks"),
    barmode = "stack"  # This stacks bars for different impacts
  )

fig
