# Load the necessary library
library(ggplot2)

# Read the CSV data
data <- read.csv("lesotho_pop_short1.csv")

# Create a bar chart to visualize the total population by district
ggplot(data, aes(x = adm1_name, y = Total, fill = adm1_name)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Total), vjust = -0.5, size = 3) +  # Add population labels
  labs(
    title = "Population by District in Lesotho",
    x = "District",
    y = "Total Population"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_discrete(name = "District") +
  guides(fill = FALSE)  # Remove the legend
