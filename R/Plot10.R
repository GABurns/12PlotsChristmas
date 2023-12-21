# Plot6: Number of chimneys visited by santa
# Author: Emily Rogan
# Creation Date: 06/12/2023

# Load Libraries ----------------------------------------------------------

library(ggplot2)
library(lubridate)
library(ggimage)
library(gganimate)
library(extrafont)
library(showtext)

# Read image of Santa in chimney ---------------------------------------------------------

img <- readJPEG("istockphoto-187862766-612x612.jpg")

# Load Christmas fonts ---------------------------------------------------------
#https://r-coder.com/custom-fonts-r/?utm_content=cmp-true

font_paths()
font_import() #imports all .ttf fonts from computer
font_add(family = "Christmas", regular = "MountainsofChristmas-Regular.ttf")
font_add_google(name = "Mountains Of Christmas", family = "mountains-of-christmas")
loadfonts(device = "win", quiet = TRUE)

# Generate Number of Chimneys and Time Data ---------------------------------------------------------

set.seed(5555)

# Before Santa leaves ----------------------------------------------------------

# Create an empty data frame with two columns and 141 rows
df_before <- data.frame(Time = c(1:16), Chimneys = 0)

# Define the start and end times for the first day and the second day
start_time_day20 <- as.POSIXlt("2023-12-20 00:00:00")
end_time_day20 <- as.POSIXlt("2023-12-20 23:59:59")  # Last second of the day
start_time_day21 <- as.POSIXlt("2023-12-21 00:00:00")
end_time_day21 <- as.POSIXlt("2023-12-21 23:59:59")  # Last second of the day
start_time_day22 <- as.POSIXlt("2023-12-22 00:00:00")
end_time_day22 <- as.POSIXlt("2023-12-22 23:59:59")  # Last second of the day
start_time_day23 <- as.POSIXlt("2023-12-23 00:00:00")
end_time_day23 <- as.POSIXlt("2023-12-23 23:59:59")  # Last second of the day

# Generate sequences for each day #before Santa Leaves

time_sequence_day20 <- seq(from = start_time_day20, to = end_time_day20, by = "6 hours")
time_sequence_day21 <- seq(from = start_time_day21, to = end_time_day21, by = "6 hours")
time_sequence_day22 <- seq(from = start_time_day22, to = end_time_day22, by = "6 hours")
time_sequence_day23 <- seq(from = start_time_day23, to = end_time_day23, by = "6 hours")

#combine the sequences
time_values_combined_before <- c(time_sequence_day20,time_sequence_day21,time_sequence_day22,time_sequence_day23)

df_before$Time <- time_values_combined_before

# After Santa Leaves -----------------------------------------------------------

# Create an empty data frame with two columns and 141 rows
df_after <- data.frame(Time = c(1:61), Chimneys = rexp(61,11.24))

# Calculating the maximum value of the generated data
max_value <- max(df_after$Chimneys)

# Rescaling the values to have the maximum value as desired (395,830,485)
df_after$Chimneys <- df_after$Chimneys * (396 / max_value)

df_after <- df_after[order(df_after$Chimneys), ]

# Generate sequences for each day #after Santa Leaves
start_time_day24 <- as.POSIXlt("2023-12-24 00:00:00")
end_time_day24 <- as.POSIXlt("2023-12-24 23:59:59")  # Last second of the day
start_time_day25 <- as.POSIXlt("2023-12-25 00:00:00")  # Start of the next day
end_time_day25 <- as.POSIXlt("2023-12-25 06:00:00")

time_sequence_day24 <- seq(from = start_time_day24, to = end_time_day24, by = "30 min")
time_sequence_day25 <- seq(from = start_time_day25, to = end_time_day25, by = "30 min")

# Combine the sequences
time_values_combined_after <- c(time_sequence_day24,time_sequence_day25)

df_after$Time <- time_values_combined_after

# Complete dataset -------------------------------------------------------------

df <- rbind(df_before, df_after)

# Create Plot ------------------------------------------------------------------

theme_set(theme_minimal(base_size = 15, base_family = 'Mountains of Christmas'))

theme_update(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks.x =  element_line(color = "White", linewidth = 1),
  axis.ticks.y =  element_line(color = "White", linewidth = 1),
  axis.line.x = element_line(color = "White", linewidth = 1),
  axis.line.y = element_line(color = "White", linewidth = 1),
  legend.position = "none",
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.margin = margin(2, 0.5, 6.5, 2.5, "cm"),
  plot.background = element_rect(fill = NA)
)

# Create Plot -------------------------------------------------------------

plot <- ggplot(data = df, aes(x = Time, y = Chimneys)) +
  geom_line(colour = "White", linewidth = 1.5) +
  geom_image(size = 0.2, image = "santa_chimney.png") +
  ylab("Chimneys Visited (Million) ") +
  scale_x_datetime(date_breaks = "1 day", date_labels = "%d %b") +
  coord_cartesian(clip = "off", ylim = c(-10, 420))

# Create Animation --------------------------------------------------------

plot <- plot +
  transition_reveal(Time)

animation <- animate(plot, fps = 25, duration = 10, end_pause = 80, rewind = FALSE, bg = 'transparent')

anim_save("chimney_30.gif", animation = animation)
