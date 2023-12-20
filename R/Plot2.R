# Plot2: Logistic Regression
# Author: Gareth Burns
# Creation Date: 04/12/2023
# Description: Plot showing proportion of good deeds accounts for Nice list


# Load Libraries ----------------------------------------------------------
library(ggplot2)

# Load Local Data ---------------------------------------------------------

ChristmasColours <- source(here("data", "ChristmasColours.R"))


# Create Data -------------------------------------------------------------

NaughtyNiceList <-
  data.frame(Prop = seq(from = 0, to = 1, by = 0.05))
NaughtyNiceList$List <-  ifelse(NaughtyNiceList$Prop < 0.5,  0, 1)


# Data Modelling ----------------------------------------------------------

my_fit <-
  glm(List ~ Prop,
      data = NaughtyNiceList,
      na.action = na.exclude,
      family = "binomial")
pred <- predict(my_fit, type = "response")
pred_df <- data.frame(Prop = NaughtyNiceList$Prop, List = pred)

# Create Plot -------------------------------------------------------------

theme_set(theme_minimal(base_size = 15, base_family = "mountains-of-christmas"))

theme_update(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.title.x = element_text(
    color = ChristmasColours$White,
    margin = margin(t = 7),
    size = 25,
    face = "bold"
  ),
  axis.title.y = element_blank(),
  axis.text.x = element_text(
    color = ChristmasColours$White,
    face = "bold",
    size = 25
  ),
  axis.text.y = element_text(
    color = ChristmasColours$White,
    face = "bold",
    size = 25
  ),
  axis.ticks.x =  element_line(color = ChristmasColours$White, linewidth = 1),
  axis.ticks.y =  element_line(color = ChristmasColours$White, linewidth = 1),
  axis.line.x = element_line(color = ChristmasColours$White, linewidth = 1),
  axis.line.y = element_blank(),
  legend.position = "none",
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.margin = margin(rep(20, 4)),
  plot.background = element_rect(fill = ChristmasColours$Red)
)


# Create Plot -------------------------------------------------------------

ggplot(NaughtyNiceList, aes(x = Prop, y = List)) +
  geom_point(
    aes(fill = ChristmasColours$White),
    size = 5,
    color = ChristmasColours$White,
    alpha = 0.8,
    shape = 21
  ) +
  geom_smooth(
    method = "glm",
    method.args = list(family = "binomial"),
    se = FALSE,
    colour = ChristmasColours$White,
    size = 1.5
  ) +
  geom_point(
    data = pred_df,
    aes(x = Prop, y = List),
    colour = ChristmasColours$White,
    size = 2.5
  ) +
  xlab("Good deeds") +
  scale_y_continuous(
    breaks = c(0, 1),
    labels = c("Naughty", "Nice"),
    limits = c(-0.3, 1.1)
  ) +
  scale_x_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1),
                     limits = c(0, 1))
