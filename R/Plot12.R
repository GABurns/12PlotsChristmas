# Plot12: Santa Names Word Cloud
# Author: Gareth Burns
# Creation Date: 15/12/2023
# Links: Source https://www.santadanshort.com/2020/10/names-for-santa/


# Load Libraries ----------------------------------------------------------
library(wordcloud2)
library(here)

# Set Local Variables -----------------------------------------------------
set.seed(51616) # For reproducibility

# Load Local Data ---------------------------------------------------------
ChristmasColours <- source(here("data", "ChristmasColours.R"))
SantaNames <- source(here("data", "SantaNames.R"))

# Data Wrangling ----------------------------------------------------------

SantaNames <- data.frame(word = SantaNames)
SantaNames$freq <- runif(nrow(SantaNames), 0.8, 1.5)
SantaNames$colour <- sample(unlist(ChristmasColours[c("Red", "Green")]), nrow(SantaNames), replace = TRUE)

# Hard coding of names I want bigger
SantaNames$freq[SantaNames$word == "Santa"] <- 5
SantaNames$freq[SantaNames$word == "Father Christmas"] <- 3

# Create Plot -------------------------------------------------------------


figPath <-  "https://creazilla-store.fra1.digitaloceanspaces.com/silhouettes/7938746/sleigh-silhouette-000000-md.png"

wordcloud2(data = SantaNames, widgetsize = c(1280,795), size = 0.8, figPath = figPath,  backgroundColor="white", color = SantaNames$colour,  fontFamily = "Poor Richard")
# set widgetsize to the same aspect ratio as your image. Here I've done a smaller size than the original png but with the same ratio
# adjust size of words etc. to suit your santa name data

# use "Show in new window" to open the viewer in a browser and then refresh your browser and the words in the shape of the image should appear. It may require multiple refreshes
# refreshing will update the layout of the words so keep doing it until you find a layout you like
# right click and "save image as"

# there's a tutorial for using `cowplot` and `ggplot2` to annotate the wordcloud with a title and captions etc. to finalise the image:
# https://spencerschien.info/post/data_viz_how_to/dense_word_clouds/
