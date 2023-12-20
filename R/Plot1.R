# Plot1: Nations Favorite Christmas Song
# Author: Gareth Burns
# Creation Date: 04/12/2023
# Description: Bump plot of nations favorite Christmas song
# Requires installation of Google Font "mountains-of-christmas"


# Load Libraries ----------------------------------------------------------

library(ggplot2)
library(ggrepel)
library(dplyr)
library(tidyr)
library(here)


# Load Local Data ---------------------------------------------------------

data <- read.csv(file = here("data", "charts.csv"), stringsAsFactors = TRUE)
ChristmasColours <- source(here("data", "ChristmasColours.R"))

# Data Wrangling ----------------------------------------------------------

data <- data %>%
  gather("Year", "Rank", -Artist, -Song) %>%
  mutate(Year = as.integer(sub(".", "", Year)))


# Creating Plot -----------------------------------------------------------

# Set theme ---------------------------------------------------------------

# I set the theme elements using theme_update as I intended to share the theme
# across multiple plots
theme_set(theme_minimal(base_size = 15, base_family = "mountains-of-christmas"))

theme_update(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_text(color = ChristmasColours$Green, face = "bold", size = 25),
  axis.text.y = element_text(color = ChristmasColours$Green, face = "bold", size = 25),
  axis.ticks.x =  element_line(color = ChristmasColours$Green, linewidth = 1),
  axis.ticks.y =  element_blank(),
  axis.line.x = element_blank(),
  axis.line.y = element_blank(),
  legend.position = "none",
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.margin = margin(rep(20, 4)),
  plot.background = element_rect(fill = ChristmasColours$White),
  plot.title = element_text(color = ChristmasColours$Green, face = "bold", size = 25, hjust = 0.5)
)


plot <-
  ggplot(data, aes(
    x = Year,
    y = Rank,
    color = Song,
    fill = Song
  )) +
  geom_line(size = 1.5) +
  geom_line(size = 3, alpha = 0.2) +
  geom_point(size = 4) +
  geom_point(size = 6, alpha = 0.2) +
  geom_text_repel(
    data = data,
    family = "mountains-of-christmas",
    aes(x = Year, y = Rank,
        label = Song),
    force             = 0.5,
    nudge_x           = 0.7,
    direction         = "y",
    hjust             = 0,
    min.segment.length = Inf,
    size = 5,
    fontface = "bold"
  ) +
  scale_x_continuous(
    labels = seq(2012, 2022, 2),
    breaks = seq(2012, 2022, 2),
    limits = c(2013, 2026)
  ) +
  scale_y_reverse(labels = 1:7, breaks = 1:7) +
  scale_color_brewer(palette = "Set2")


# Creating Animation ------------------------------------------------------

plot <- plot +
  ggtitle("{frame_along}") +
  transition_reveal(Year)

animation <- animate(plot, fps = 20, duration = 8, width = 900, height = 500, rewind = FALSE, start_pause = 10)

anim_save("NationFavSong.gif", animation = animation)
