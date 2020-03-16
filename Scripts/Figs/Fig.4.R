rm(list=ls())
library("ggplot2")
library("ggpmisc")
library("viridis")
data <- read.csv("./Datasets/DR_9kvs20k_samplingfraction_rate_ratio_update.csv", header=TRUE)

#note this figure need to adjust via Inkscape to better show p-values and R2 after plotting.

pdf("../Fig.4.Rosid_4g5g_samplingfraction_rate_ratio_diversification_comparion.pdf", width = 8, height = 6)
ggplot(data = data, aes(x=sampling_ratio, y=Ratios, color=Type, group = Type))+
  geom_point(aes(colour=Type, alpha = 0.3)) +
  ylim(0,3) +
  geom_smooth(method = "lm", aes(colour=Type), se = T) +
  stat_poly_eq(aes(label = paste(..rr.label..)), 
               label.x.npc = "right", label.y.npc = 0.15,
               formula = "y ~ x", parse = TRUE, size = 3) +
  stat_fit_glance(method = 'lm',
                  method.args = list(formula = "y ~ x"),
                  geom = 'text',
                  aes(label = paste("P-value = ", signif(..p.value.., digits = 4), sep = "")),
                  label.x.npc = "right", label.y.npc = "top", size = 3) +
  scale_color_viridis(discrete=TRUE, direction=-1, end=0.75, option = "D") +
  theme_bw()
dev.off()

