# Plot5: Lego Logo Mosaic
# Author: Gareth Burns
# Creation Date: 08/12/2023
# Description:

# Load Libraries ----------------------------------------------------------

library(ggplot2)
library(brickr)
library(jpeg)

# User-created variables --------------------------------------------------

data <-
  data.frame(
    colour = c("Red", "Black", "Blue", "Green"),
    number = c(100, 75, 25, 10)
  )

# Plot --------------------------------------------------------------------

mosaic <- jpeg::readJPEG(source = "exploristics_logo.jpg") %>%
  image_to_mosaic(img_size = 75) #Length of each side of mosaic in "bricks"
