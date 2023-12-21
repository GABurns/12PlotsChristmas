# Plot9: Christmas Gifts
# Author: Gareth Burns
# Creation Date: 15/12/2023
# Description: Bump plot of nations favorite Christmas song
# Requires installation of Google Font "mountains-of-christmas"

# Load Libraries ----------------------------------------------------------

library(ggpattern)
library(ggplot2)
library(here)

# Load Local Data ---------------------------------------------------------

ChristmasColours <- source(here("data", "ChristmasColours.R"))

# Input Data  -------------------------------------------------------------

# Data source is https://www.finder.com/uk/christmas-shopping-statistics
# Accessed on: 15DEC2023

df <- data.frame(Year = c('2019', '2020', '2021', '2022', '2023'),
                 Average_Spend = c(513, 476, 548, 430, 602)
)

# Dataframe for labels data to create bows in center on bars as using geom_text
bows <- data.frame(left = rep(20, 5),
                   right = 19:23,
                   x = df$Year,
                   y = df$Average_Spend)

# Data Processing  --------------------------------------------------------
theme_set(theme_minimal(base_size = 15, base_family = "mountains-of-christmas"))

theme_update(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),

  axis.title.x = element_blank(),
  axis.title.y = element_text(color = ChristmasColours$Red, margin = margin(t = 7, r = 20), size = 25, face = "bold", angle = 90),
  axis.text.x = element_blank(),
  axis.text.y = element_text(color = ChristmasColours$Red, face = "bold", size = 25),
  axis.ticks.x =  element_blank(),
  axis.ticks.y =  element_line(color = ChristmasColours$Red, linewidth = 2),
  axis.line.x = element_blank(),
  axis.line.y = element_line(color = ChristmasColours$Red, linewidth = 1),
  legend.position = "none",
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.margin = margin(rep(20, 4)),
  plot.background = element_blank()
)





ggplot(df, aes(x=Year, y = Average_Spend)) +
  geom_col_pattern(
    aes(fill = Year),
    pattern = c("stripe", "circle", "stripe", "circle", "stripe"),

    colour          = "black",
    pattern_spacing = c(0.1, 0.05, 0.1, 0.05, 0.1),
    pattern_density = c(0.1, 0.5, 0.5, 0.5, 0.1),
    pattern_fill    = 'white',
    pattern_colour  = c("black", "white","black", "white", "black"),
    pattern_angle   = 45,
  ) +
  geom_text(data = bows, aes(x = x, y = y, label = left), nudge_x = -0.09, nudge_y = 30, angle = -45, size = 9, family = "mountains-of-christmas", colour = ChristmasColours$Red, fontface = "bold",) +
  geom_text(data = bows, aes(x = x, y = y, label = right), nudge_x = 0.09, nudge_y = 30, angle = 45, size = 9, family = "mountains-of-christmas", colour = ChristmasColours$Red, fontface = "bold") +
  scale_y_continuous(limits = c(0, 650)) +
  ylab("Average Spend (£)") +
  labs(caption = "Data | https://www.finder.com/uk/christmas-shopping-statistics") +
  geom_segment(data = df, aes(x = Year, y = rep(0, 5), xend = Year, yend = Average_Spend), colour = ChristmasColours$Red, linewidth = 4) +
  scale_fill_manual(values = c("#147878", "#4557B8","#e87d87", "#D4B06A", "#bdd2d2"))

