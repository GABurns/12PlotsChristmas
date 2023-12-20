# Plot6: fa la la bar plot
# Author: Emily Rogan
# Creation Date: 11/12/2023


# Load Libraries ----------------------------------------------------------

library(ggplot2)
library(extrafont)
library(showtext)
library(ggpattern)

# Load Libraries ----------------------------------------------------------

loadfonts(device = "win", quiet = TRUE)

# generate data -------------------------------------------------------------

df <- as.data.frame(c("Fa", rep("La", 8)))
df_2 <- as.data.frame(table(df))
colnames(df_2) <- c("Lyric", "Count")

# Create Plot ------------------------------------------------------------------

theme_set(theme_minimal(base_size = 15, base_family = 'Mountains of Christmas'))

theme_update(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  title = element_text(color = "#c11132",face="bold", size = 25,angle = 0),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_text(color = "#c11132",face="bold", size = 20,angle = 0),
  axis.text.y = element_text(color = "#c11132",face="bold", size = 20),
  axis.ticks.x =  element_blank(),
  axis.ticks.y =  element_blank(),
  axis.line.x = element_line(color = "#c11132", linewidth = 1),
  axis.line.y = element_line(color = "#c11132", linewidth = 1),
  legend.position = "none",
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.margin = margin(2, 3, 2, 3, "cm"),
  plot.background = element_rect(fill = NA)
)

# Create and save plot -------------------------------------------------------------

png('FaLaLaLaLaLaLaLaLa.png')

ggplot(df_2, aes(x = Lyric, y = Count)) +
  coord_cartesian(clip = "off") +
  geom_col_pattern(
    aes(),
    width = 0.4,
    pattern = 'stripe',
    fill    = 'white',
    colour  = '#c11132',
    pattern_colour  = '#c11132',
    pattern_fill  = '#c11132'
  ) +
  ggtitle("'Tis the season to be jolly...")

dev.off()


