rm(list=ls())
library("ggplot2")
library("tidyverse")
library(ggridges)
library(viridis)

#data

############################
#RPANDA lamda
############################

# defined a function for caculate AkaikeWeight
AKW <- function(x){
  Delta.AIC <- x -min(x)
  AkaikeWeight <- BMhyd::AkaikeWeight(Delta.AIC)
  return(AkaikeWeight)
}

file <- "genus_level_10fitbd/summary/Genus_10_RPADNA_model_AW.csv"
cat("Clade", "Model", "lamda", "AICc", "AW\n", file=file, sep=",")

files <- list.files("genus_level_10fitbd", pattern = ".csv", full.names = TRUE)
matrix <- NULL
for (i in 1:length(files)){
  table <- read_csv(files[i]) %>% mutate(AW=AICc)%>% mutate_at("AW", AKW)
  write.table(table, sep=",", file, row.names=F, col.names=F, append=T, quote=F)
  #best model for each tree [each tree has nine models]
  sum_result <- table %>% filter(AW==max(AW))
  matrix <- rbind(matrix, sum_result)
}

#write out best model for each tree [each tree has nine models]
write.table(matrix, sep=",", "genus_level_10fitbd/summary/Genus_10_RPADNA_best_model_tree_AW.csv", row.names=F, quote=F)

#recalculate the AW
result <- matrix[,-5] %>% mutate(AW=AICc)%>% mutate_at("AW", AKW) %>% filter(AW==max(AW))
write.csv(result, "genus_level_10fitbd/summary/Genus_10_RPADNA_best_one_AW.csv", row.names = FALSE, quote=FALSE)

#####################################
#DR tip rate
#####################################
files <- list.files("genus_level_10DR", pattern = ".csv", full.names = TRUE)
matrix <- NULL
for (i in 1:length(files)){
  table <- read_csv(files[i])
  name <- gsub("_DR.csv", "", basename(files[i]))
  matrix <- rbind(c(name, mean(table$DRrate)), matrix)
}

matrix <- as.data.frame(matrix)
names(matrix) <- c("Trees", "MeanDR")
write.csv(matrix, "genus_level_10DR/summary/Cucurbitaceae_10genus_meanDR.csv", row.names=F, quote=F)


#####################################
#BAMM global sampling
#####################################
#tiprates
files <- list.files("genus_level_10BAMM/result", pattern = "_TipRates.csv", full.names = TRUE)
Rates <- list()

for(i in 1:length(files)){
  name <- gsub("_BAMM_TipRates.csv", "", basename(files[i]))
  data <- read_csv(files[i])
  Rates[[name]] <- mean(data$Rate)
}

matrix <- plyr::ldply(Rates, cbind)

names(matrix) <- c("tree_id", "Mean_tiprate")

write.csv(matrix, "genus_level_10BAMM/result/Cucurbitaceae_genus10_global_mean_tipRate.csv", row.names=F, quote = F)

#speciation_rate##
files <- list.files("genus_level_10BAMM/result", pattern = "_median_speciation_rates.csv", full.names = TRUE)
Rates <- list()

for(i in 1:length(files)){
  name <- gsub("_BAMM_median_speciation_rates.csv", "", basename(files[i]))
  data <- read_csv(files[i])
  Rates[[name]] <- mean(data$median.rate)
}

matrix <- plyr::ldply(Rates, cbind)

names(matrix) <- c("tree_id", "sprate")

write.csv(matrix, "genus_level_10BAMM/result/Cucurbitaceae_genus10_global_mean_SpeciationRate.csv", row.names=F, quote = F)

#####################################
#BAMM clade-specific sampling
#####################################
files <- list.files("genus_level_10BAMM/result_fraction", pattern = "_TipRates.csv", full.names = TRUE)
Rates <- list()

for(i in 1:length(files)){
  name <- gsub("_BAMM_TipRates.csv", "", basename(files[i]))
  data <- read_csv(files[i])
  Rates[[name]] <- mean(data$Rate)
}

matrix <- plyr::ldply(Rates, cbind)

names(matrix) <- c("tree_id", "Mean_tiprate")

write.csv(matrix, "genus_level_10BAMM/result_fraction/Cucurbitaceae_genus10_specific_mean_tipRate.csv", row.names=F, quote = F)

#speciation_rate##
files <- list.files("genus_level_10BAMM/result_fraction", pattern = "_median_speciation_rates.csv", full.names = TRUE)
Rates <- list()

for(i in 1:length(files)){
  name <- gsub("_BAMM_median_speciation_rates.csv", "", basename(files[i]))
  data <- read_csv(files[i])
  Rates[[name]] <- mean(data$median.rate)
}

matrix <- plyr::ldply(Rates, cbind)

names(matrix) <- c("tree_id", "sprate")

write.csv(matrix, "genus_level_10BAMM/result_fraction/Cucurbitaceae_genus10_specific_mean_SpeciationRate.csv", row.names=F, quote = F)



#########################################################
fit <- aov(lamda ~ treatment, data = result)
summary(fit)
tukey <- TukeyHSD(fit)

lapply(tukey, function(x) write.table(data.frame(x), "Cucurbitaceae_5g_family_level/Fam_40_random_drop_addin/RPANDA_fam_40/Cucurbitaceae_random_dropaddin_RPADNA_10305075TukeyHSD.txt", quote = FALSE, append= TRUE, sep='\t' ))
R.rapanda <- read.csv("genus_level_10fitbd/summary/genus_level_10RPANDA_All_model_AW.csv", header = TRUE)
# length(R.rapanda$lamda)
Rate.rpd <- cbind.data.frame(Type=rep("rateRpanda", length(R.rapanda$lamda)), Rate=R.rapanda$lamda)




#DR
R.DR <- read.csv("genus_level_10DR/MeanDR_for_each_tree.csv", header = TRUE)
Rate.DR <- cbind.data.frame(Type=rep("rateDR", length(R.DR$MeanDRrate)), Rate=R.DR$MeanDRrate)

#BAMM rate
files <- list.files("genus_level_10BAMM/result", pattern = "_BAMM_mean_tip&speciation_rates.csv", full.names = TRUE)

R.sp.BAMM <- NULL
R.tip.BAMM <- NULL

for(i in 1:length(files)){
  data <- read.csv(files[i], header = FALSE)
  data <- data[-1,]
  R.sp.BAMM <- rbind(R.sp.BAMM,data[2,])
  R.tip.BAMM <- rbind(R.tip.BAMM,data[1,])
}
colnames(R.sp.BAMM) <- c("Type", "Rate")
colnames(R.tip.BAMM) <- c("Type", "Rate")

All.Rates <- bind_rows(list(Rate.rpd,Rate.DR, R.sp.BAMM, R.tip.BAMM))
All.Rates$Type <- as.factor(All.Rates$Type)

# dir.create("RPANDA_sum_plots")

# pdf("RPANDA_sum_plots/RPANDA_17order_3datasets_lamda.pdf", width = 6, height = 6)
ggplot(data = data_all, aes(x=Clade, y=lamda, colour=datasets, group = datasets)) +
  geom_point() +
  geom_line() +
  theme(axis.text.x=element_text(size=2.5))
# dev.off()

# pdf("RPANDA_sum_plots/RPANDA_4g5gotl_17order_datasets_boxplot.pdf", width = 6, height = 6)
ggplot(data = All.Rates, aes(x=Type, y=Rate, fill=Type, group = Type)) +
  geom_boxplot() +
  theme(legend.position="none")
# dev.off()




ggplot(All.Rates, aes(x = Rate, y = Type , fill = ..x..)) + 
  geom_density_ridges_gradient(rel_min_height = 0.001) +
    scale_fill_viridis(name = "Rate", option = "C") +
    labs(title = "Rates for genus tree") +
    theme_ridges(grid = FALSE, center_axis_labels = TRUE) +
    scale_x_continuous(expand = c(0.01, 0)) +
    scale_y_discrete(expand = c(0.01, 0))
