# Plot3: Time Series Animation of
# Author: Gareth Burns
# Creation Date: 05/12/2023
# Description:
# Links: https://trends.google.com/trends/explore?date=2022-01-01%202022-12-31&geo=GB&q=Brussel%20Sprout&hl=en-GB

# Load Libraries ----------------------------------------------------------

library(ggplot2)
library(lubridate)
library(ggimage)
library(gganimate)
library(here)

# Load Local Data ---------------------------------------------------------
data <- read.csv(here("data", "brusselsprouts.csv"))
ChristmasColours <- source(here("data", "ChristmasColours.R"))

# Data Wrangling ----------------------------------------------------------
data$Week <- dmy(data$Week)

# Create Plot -------------------------------------------------------------
theme_set(theme_minimal(base_size = 15, base_family = "mountains-of-christmas"))

theme_update(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_text(color = ChristmasColours$Green, face = "bold", size = 25, angle = 90),
  axis.text.x = element_text(color = ChristmasColours$Green, face = "bold", size = 25),
  axis.text.y = element_text(color = ChristmasColours$Green, face = "bold", size = 25),
  axis.ticks.x =  element_line(color = ChristmasColours$Green, linewidth = 1),
  axis.ticks.y =  element_line(color = ChristmasColours$Green, linewidth = 1),
  axis.line.x = element_line(color = ChristmasColours$Green, linewidth = 1),
  axis.line.y = element_line(color = ChristmasColours$Green, linewidth = 1),
  legend.position = "none",
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.margin = margin(rep(20, 4)),
  plot.background = element_rect(fill = ChristmasColours$White)
)


# Create Plot -------------------------------------------------------------

plot <- ggplot(data = data, aes(x = Week, y = Popularity)) +
  geom_line(colour = ChristmasColours$Green, linewidth = 1.5) +
  geom_line(colour = ChristmasColours$Green, linewidth = 2.5, alpha = 0.1) +
  geom_image(size = 0.1, image = "brussel.png") +
  ylab("Search Popularity") +
  transition_reveal(Week)


# Create Animation --------------------------------------------------------

plot <- plot +
  transition_reveal(Week)


animation <- animate(plot, fps = 25, duration = 10, width = 750, height = 500, end_pause = 100, rewind = FALSE)

anim_save("brussel.gif", animation = animation)
