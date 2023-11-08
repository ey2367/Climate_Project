library(ggplot2)
library(readxl)
library(lubridate)

# Read the data from the Excel file
data <- read_excel("foodinsecurity.xlsx")

# Convert 'reporting_date' to a date format
data$reporting_date <- ymd(data$reporting_date)

# Define colors for the categories
colors <- c("minimal" = "green", "stressed" = "orange", "crisis" = "red")

# Create a scatter plot with enhanced aesthetics
ggplot(data, aes(x = reporting_date, y = factor(value), color = factor(value))) +
  geom_point(alpha = 0.7) +  # Adjust point transparency
  scale_color_manual(values = colors, guide = "legend") +  # Exclude size from legend
  labs(
    x = "Reporting Date",
    y = "Value",
    title = "Reported Food Insecurity of Lesotho Over Time",
    color = "Category"
  ) +
  scale_y_discrete(labels = c("1" = "minimal", "2" = "stressed", "3" = "crisis")) +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10, color = "gray20"),
    axis.title = element_text(size = 12, face = "bold"),
    plot.title = element_text(size = 16, hjust = 0.5, vjust = 1, face = "bold"),
    legend.position = "top",
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90", size = 0.5),
    panel.background = element_rect(fill = "white"),
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 10)
  )
