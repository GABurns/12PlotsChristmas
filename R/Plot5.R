# Plot5: Christmas Tree Distribution
# Author: Gareth Burns
# Creation Date: 06/12/2023
# Description:


# Load Libraries ----------------------------------------------------------

library(ggplot2)
library(emojifont)
library(dplyr)
library(tidyr)


# User-created variables --------------------------------------------------

# Look up rnorm ?rnorm if you're not familiar with generating random data in R.
# I wanted lots of data so it fitted a nice normal distribution with low
# monte-carlo error.
data <- data.frame(Height = rnorm(100000, 175, 2.5))

# Load Local Data ---------------------------------------------------------
ChristmasColours <- source(here("data", "ChristmasColours.R"))


# Plot --------------------------------------------------------------------


# At this stage I experimented with a lot to get the effect of individuals being
# simulated. I thought a modified dotplot whereby each dot represents a count
# within a bin. I couldn't find a way to modify the dotplot to use an image\icon
# so settled a hacky approach....using geom_fontawesome from the emojifont package
# It relies ALOT of playing about with attributes of the plot to get the nice
# overlapping effect - with my developer hat on, it's very poor code with a lot
# of hard-coding but I learnt a lot and a few new tricks to wrangle data


# Data Wrangling ----------------------------------------------------------

# geom_fontawesome takes an x and a y so now I need to do some data wrangling to
# achieve this values. The x is the height interval - i.e. I want everyone with a
# 160 cm height into the same bin. In ecology this is often known as length/height
# frequency.

# This approach was very iterative where I went back and forward to see looked
# aesthetically pleasing. In my plot each icon represents 5 individuals within a
# 2cm bin - i.e. in my plot the icon doesn't represent an individual you could.

iconData <- data %>%
  mutate(Interval = cut_width(Height, width = 0.20, boundary = min(Height))) %>%
  group_by(Interval) %>%
  summarise(n = n()) %>%
  mutate(Height = substr(Interval, 2, 4))# Presentation label for plot

# The next step was to get the number individuals I wanted my icons to
# represent in the plot. If you want each icon to represent an individual these
# 2 steps aren't needed. Just round your data to what you see fit

iconData <-  iconData %>%
  mutate(iconCount = floor(n / 750)) # The ceiling was the effect I wanted
# Could use floor or consider the size of your icon

# Uncounting
# A common issue in ecology is we collect frequency tallies but when using the
# data we want an individual row per sample/individual - so it's inverse of count
# function in dplyr. For the y - we want the position on the y axis and
# this is quite subjective as it'll depend on the size of your plot, the max value
# of the frequency density and the size of your icons.
# As a rule of thumb you want the max density / max number of icons in a bin

iconData <- iconData %>%
  uncount(iconCount) %>%
  group_by(Height) %>%
  mutate(y = row_number() * 0.2) # Modify this value to change spacing between
# icons.

starData <- data.frame(x = median(as.numeric(iconData$Height)),
                       y = max(iconData$y) + 0.3)

# Plotting Icons ----------------------------------------------------------

theme_set(theme_minimal())

theme_update(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.title.x = element_text(color = ChristmasColours$Green, margin = margin(t = 7), size = 30, family = "mountains-of-christmas"),
  axis.title.y = element_blank(),
  axis.text.x = element_text(color = ChristmasColours$Green, face = "bold", size = 20, family = "mountains-of-christmas"),
  axis.text.y = element_blank(),
  axis.ticks.x =  element_line(color = ChristmasColours$Green, linewidth = 1),
  axis.ticks.y =  element_blank(),
  axis.line.x = element_line(color = ChristmasColours$Green, linewidth = 1),
  axis.line.y = element_blank(),
  legend.position = "none",
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.margin = margin(rep(20, 4))
)

plot <- ggplot(data, aes(x = Height)) +
  labs(x = "Height (cm)") +
  geom_fontawesome(
    alias = "fa-tree",
    x = as.numeric(iconData$Height),
    y = as.numeric(iconData$y),
    size = 6, # Modify the size of
    color = ChristmasColours$Green,
    alpha = 0.2
  ) +
  geom_fontawesome(
    alias = "fa-tree",
    x = as.numeric(iconData$Height),
    y = as.numeric(iconData$y),
    size = 5, # Modify the size of
    color = ChristmasColours$Green
  ) +
  geom_fontawesome(
    alias = "fa-star",
    x = as.numeric(starData$x),
    y = as.numeric(starData$y),
    size = 11, # Modify the size of
    color = "black",
    alpha = 0.2
  )+
  geom_fontawesome(
    alias = "fa-star",
    x = as.numeric(starData$x),
    y = as.numeric(starData$y),
    size = 10, # Modify the size of
    color = "yellow"
  )

