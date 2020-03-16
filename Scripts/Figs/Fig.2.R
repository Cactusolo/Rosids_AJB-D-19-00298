library(ggridges)
library(viridis)
library(tidyverse)


Date <- read_csv("rosid_clade_9k_20k_100k_age.csv")

# clean1 <- function(x){
#   m <- gsub("^[0-9]+k-tip_", "", x)
#   return(m)
# }

clean2 <- function(x){
  mm <- gsub("_OTL|_treePL", "", x)
  return(mm)
}

clean3 <- function(x){
  ss <- gsub("_", " ", x)
  return(ss)
}

Date2 <- Date %>% na.omit(Date) %>% filter(Trees!="9k-tip_PATHd8" & Trees !="20k-tip_PATHd8") %>% mutate_at("Trees", clean2) %>% mutate_at("Trees", clean3)

color <- c("#f4320c","#10a674","orange", "#910951")

pdf("../../Figure/Fig.2.rosid_clade_age_distribution_from_9k_20k_100k_trees_ggridges.pdf", width = 5, height = 5)
  
ggplot(Date2, aes(x = Age, y = Trees, fill=Trees)) + 
    geom_density_ridges2(scale=1.5, rel_min_height = 0.01) +
    scale_fill_cyclical(values = c("blue", "orange"), guide = "legend") +
    geom_vline(xintercept = c(0,50,100, 125), linetype = "dashed", color="#cc79a7") +
    # labs(title = "Age Distribution for Major Rosids Clades from Each Calibrated Trees", x ="Age (Myr)") +
    labs(x ="Age (Myr)") +
    theme_ridges(grid = FALSE, center_axis_labels = TRUE) +
    scale_x_continuous(expand = c(0.01, 0)) +
    scale_y_discrete(expand = c(0.01, 0)) +
    theme(legend.position = "none", axis.line.x.bottom = element_line(colour = "black", size = 0.5, linetype = "solid"))

dev.off()
