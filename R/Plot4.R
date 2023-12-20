# Plot4: Step Plot of Birds of Christmas
# Author: Gareth Burns
# Creation Date: 05/12/2023
# Description:

# Load Libraries ----------------------------------------------------------

library(ggplot2)

# Load Local Data ---------------------------------------------------------
ChristmasColours <- source(here("data", "ChristmasColours.R"))

# Create Data -------------------------------------------------------------

DaysOfChristmas <-
  data.frame(Day = seq(1:12),
             Birds = c(1, 2, 3, 4, 0, 6, 7, 0, 0, 0, 0, 0))


birds <- sapply(seq(12), function(day, DaysOfChristmas) {
  DaysOfChristmas <- DaysOfChristmas[1:day,]

  cumlativeBirds <- sum(DaysOfChristmas$Birds)

}, DaysOfChristmas = DaysOfChristmas)


DaysOfChristmas <-
  data.frame(Day = seq(1:12),
             Birds = birds)

DaysOfChristmas$Birds <- cumsum(DaysOfChristmas$Birds)

# Create Plot -------------------------------------------------------------
theme_set(theme_minimal())

theme_update(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.title.x = element_text(
    color = ChristmasColours$Green,
    margin = margin(t = 7),
    size = 30,
    family = "mountains-of-christmas"
  ),
  axis.title.y = element_text(
    color = ChristmasColours$Green,
    margin = margin(t = 7),
    size = 30,
    family = "mountains-of-christmas"
  ),
  axis.text.x = element_text(
    color = ChristmasColours$Green,
    face = "bold",
    size = 20,
    family = "mountains-of-christmas"
  ),
  axis.text.y = element_text(
    color = ChristmasColours$Green,
    face = "bold",
    size = 20,
    family = "mountains-of-christmas"
  ),
  axis.ticks.x =  element_line(color = ChristmasColours$Green, linewidth = 1),
  axis.ticks.y =  element_line(color = ChristmasColours$Green, linewidth = 1),
  axis.line.x = element_line(color = ChristmasColours$Green, linewidth = 1),
  axis.line.y = element_line(color = ChristmasColours$Green, size = 1),
  legend.position = "none",
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.margin = margin(rep(20, 4))
)

ggplot(data = DaysOfChristmas, aes(x = Day, y = Birds)) +
  geom_step(colour = ChristmasColours$Red, linewidth = 2) +
  geom_step(colour = ChristmasColours$Red,
            linewidth = 3,
            alpha = 0.2) +
  geom_point(colour = ChristmasColours$Red, size = 3) +
  geom_point(colour = ChristmasColours$Red,
             size = 5,
             alpha = 0.2) +
  scale_x_continuous(limits = c(0.5, 12), breaks = seq(1:12)) +
  ylab("Number of Birds")
