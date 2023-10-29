# Load required libraries
library(ggplot2)
library(dplyr)
library(readr)

# Read the CSV file
data <- read_csv("FoodSecurity Data.csv")

# Check the structure of the dataset
str(data)

# Convert the "ReportedDate" column to a Date format
data$reporting_date <- as.Date(data$reporting_date)

# Map numerical values to severity labels
data$value <- factor(data$value, levels = c(1, 2, 3), labels = c("Minimal", "Stressed", "Crisis"))

# Create a line plot to show the severity over time
ggplot(data, aes(x = reporting_date, y = value)) +
  geom_line(aes(color = value)) +
  scale_y_discrete(limits = c("Minimal", "Stressed", "Crisis")) +
  labs(
    title = "Food Security of Lesotho Over Time",
    x = "Reporting Date",
    y = "Severity"
  ) +
  theme_minimal()
