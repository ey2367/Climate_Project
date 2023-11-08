# NEED TO DOWNLOAD 2 EXCEL FILES: all.xlsx and left.xlsx
#install.packages(c("readxl", "ggplot2", "tidyverse"))
library(readxl)
library(ggplot2)
library(tidyverse)

# Reading the Excel file
data <- read_excel("all.xlsx") 

# Reshaping the data from wide to long format
data_long <- data %>% pivot_longer(cols = -ID, names_to = "Month", values_to = "Value")

# Creating a color vector to represent the values 0-17
colors <- c("white", "chartreuse", "chartreuse", "darkgreen", "darkorange", "cadetblue1", "khaki1",
            "lightgreen", "darkorchid1", "lightpink", "lightgoldenrod1", "red", "darkorange3", "forestgreen",
            "darkred", "antiquewhite", "darksalmon", "darkseagreen1","blue4") # Change colors as per need

# Convert 'Value' to a factor
data_long <- data_long %>% 
  mutate(Value = as.factor(Value))

# Set the order of the y-axis categories
y_order <- c("Season", "Impact 1", "Impact 2", "Impact 3", "Impact 4", "Forecast triggers", 
             "Readiness Trigger (OND)", "Readiness Trigger (DJF)", "Activation Trigger (OND)", 
             "Activation Trigger (DJF)", "Anticipatory Actions", "Intervention 1", "Intervention 2", 
             "Intervention 3", "Intervention 4", "M&E", "Baseline (optional)", "Outcome PDM/Endline", 
             "After Action Review", "Final M&E Report")
data_long$ID <- factor(data_long$ID, levels = rev(y_order))

# Create the Gantt chart
plot <- ggplot(data_long, aes(x = Month, y = ID, fill = Value)) +
  geom_tile(color = "gray48") +
  scale_fill_manual(values = colors) +
  theme_minimal() +
  scale_x_discrete(limits = unique(data_long$Month[order(data_long$ID)]), position = "bottom") + # Position the x-axis labels at the bottom
  scale_y_discrete(limits = rev(y_order)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), # Adjust angle and hjust for better visibility
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 8),
        legend.position = "none")

print(plot)


# Read the new Excel file
data_left <- read_excel("left.xlsx")

# Create a new dataframe matching the shape of data_long
data_left_long <- data.frame(
  ID = data_left$ID,
  Month = rep("right", length(data_left$ID)),
  Value = factor(rep(0, length(data_left$ID))) # Assuming a value of 0 for these cells
)

# Swap the order of the plots by changing the 'Month' values in the dataframes
# For the original plot, change "right" to "left"
data_long$Month <- ifelse(data_long$Month == "right", "left", data_long$Month)

# For the left plot, change "left" to "right"
data_left_long$Month <- ifelse(data_left_long$Month == "left", "right", data_left_long$Month)

# Combine the original data with the new data
data_combined <- rbind(data_left_long, data_long)

# Create the combined Gantt chart
plot_combined <- ggplot(data_combined, aes(x = Month, y = ID, fill = Value)) +
  geom_tile(color = "gray48") +
  scale_fill_manual(values = colors) +
  theme_minimal() +
  scale_x_discrete(limits = unique(data_combined$Month[order(data_combined$ID)]), position = "bottom") + # Position the x-axis labels at the bottom
  scale_y_discrete(limits = rev(y_order)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), # Adjust angle and hjust for better visibility
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 8),
        legend.position = "none")

# Display the combined Gantt chart inside RStudio
print(plot_combined)