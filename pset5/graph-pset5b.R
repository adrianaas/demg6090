# Load the required libraries
library(ggplot2)
library(readxl)

# Read the data from Excel files, specifying column names
data1 <- read_excel("graph-pset5b.xlsx", col_names = TRUE, range = "A1:B21")
data2 <- read_excel("graph-pset5b.xlsx", col_names = TRUE, range = "D1:E16")

# Create a plot with custom x-axis
plot <- ggplot() +
  geom_line(data = data1, aes(x = `Mid-Period`, y = `Period TFR`, color = "Dataset 1")) +
  geom_line(data = data2, aes(x = `Fertility Cohort`, y = `Cohort TFR`, color = "Dataset 2")) +
  geom_point(data = data1, aes(x = `Mid-Period`, y = `Period TFR`), color = "blue", size = 2) +
  geom_point(data = data2, aes(x = `Fertility Cohort`, y = `Cohort TFR`), color = "red", size = 2) +
  labs(x = "Year", y = "TFR", color = "Dataset") +
  scale_color_manual(values = c("Dataset 1" = "blue", "Dataset 2" = "red"), 
                     labels = c("Period TFR", "Cohort TFR"))  # Add legend labels

# Show the plot
print(plot)
