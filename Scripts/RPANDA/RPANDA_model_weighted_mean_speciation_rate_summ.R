######
rm(list=ls())
library("tidyverse")
ff <- list.files(".", pattern="_17_order_Rate_AkaikeWeight.csv$", full.names = T)

title <- c("9k-tip", "20k-tip", "100k-tip")
#### 9k-tip tree ####
dd.9k <- read_csv(ff[4], col_names = T)
ww.9k <- read_csv("result/Whole_tree/RPANDA_model_4g_Rate_AkaikeWeight.csv", col_names = T)
ww.9k$Clade <- "Whole tree"
dd.9k <- rbind.data.frame(dd.9k, ww.9k)
Rate_mwm.9k <- dd.9k %>% mutate(tmp_9k=abs(lamda)*AW) %>% group_by(Clade) %>% summarise(sum(tmp_9k))
#the speciation rate needs to be interpreted as abs value

#### 20k-tip tree ####
dd.20k <- read_csv(ff[5], col_names = T)
ww.20k <- read_csv("result/Whole_tree/RPANDA_model_5g_Rate_AkaikeWeight.csv", col_names = T)
ww.20k$Clade <- "Whole tree"
dd.20k <- rbind.data.frame(dd.20k, ww.20k)
Rate_mwm.20k <- dd.20k %>% mutate(tmp_20k=abs(lamda)*AW) %>% group_by(Clade) %>% summarise(sum(tmp_20k))

#### 100k-tip tree ####
dd.100k <- read_csv(ff[6], col_names = T)
ww.100k <- read_csv("result/Whole_tree/RPANDA_model_otl_Rate_AkaikeWeight.csv", col_names = T)
ww.100k$Clade <- "Whole tree"
dd.100k <- rbind.data.frame(dd.100k, ww.100k)
Rate_mwm.100k <- dd.100k %>% mutate(tmp_100k=abs(lamda)*AW) %>% group_by(Clade) %>% summarise(sum(tmp_100k))

aa <- left_join(Rate_mwm.9k, Rate_mwm.20k, by="Clade")
Table <- left_join(aa, Rate_mwm.100k, by="Clade")
names(Table) <- c("Clade", "9k-tip tree", "20k-tip tree", "100k-tip tree")
write.csv(Table, "result/RPANDA_17_rosid_order_model_weighted_mean_speciation_rate.csv", row.names = F, quote=F)