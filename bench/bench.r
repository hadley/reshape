# Data from http://www4.uwm.edu/FLL/linguistics/dialect/maps.html

bd <- read.csv("dialects.csv.bz2", stringsAsFactors = FALSE, 
  strip.white = TRUE)

system.time(bdm <- melt(bd, id = 1:4))
# Reshape1: 
#   user  system elapsed 
# 28.695  20.052  49.802 

names(bdm) <- c("subject", "city", "state", "zip", "question", "response")
bdm <- subset(bdm, response != 0)

system.time(dcast(bdm, ... ~ question))
# Reshape1: 
#   gave up after 40 minutes

dcast(bdm, question ~ state)