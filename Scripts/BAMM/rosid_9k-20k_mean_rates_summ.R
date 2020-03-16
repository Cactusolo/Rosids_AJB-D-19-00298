rm(list=ls())

Order <- c("Brassicales","Celastrales","Crossosomatales","Cucurbitales","Fabales","Fagales","Geraniales","Huerteales","Malpighiales","Malvales","Myrtales","Oxalidales","Picramniales","Rosales","Sapindales","Vitales","Zygophyllales")

file <- "Rosids_9k20k_mean_Tip&specation_rates_17order.csv"
cat("Order,mean_4g,mean_5g,tip_4g_no,tip_4g,tip_5g_no,tip_5g\n", file=file)

m1 <- NULL
# dir.create("plots")
for (i in 1:length(Order)){
  # BAMM_plot <- function(i){
  clade <- Order[i]
  data_4g <- read.csv(paste0("result/", clade, "_4g_BAMM_median_speciation_rates.csv", sep=""), header=TRUE)
  data_5g <- read.csv(paste0("result/", clade, "_5g_BAMM_median_speciation_rates.csv", sep=""), header=TRUE)
  tip_4g <- read.csv(paste0("result/", clade, "_4g_BAMM_TipRates.csv", sep=""), header=TRUE)
  tip_5g <- read.csv(paste0("result/", clade, "_5g_BAMM_TipRates.csv", sep=""), header=TRUE)
  write.table(paste0(clade, ",", mean(data_4g$median.rate), ",", mean(data_5g$median.rate), ",", length(tip_4g$Tip_label), ",", mean(tip_4g$Rate), ",", length(tip_5g$Tip_label), ",", mean(tip_5g$Rate), sep=""), file=file, row.names=F, col.names=F, append=T)
}

#######################

m1 <- NULL
m2 <- NULL
m3 <- NULL
m4 <- NULL
# dir.create("plots")
for (i in 1:length(Order)){
  # BAMM_plot <- function(i){
  clade <- Order[i]
  data_4g <- read.csv(paste0("result/", clade, "_4g_BAMM_median_speciation_rates.csv", sep=""), header=TRUE)
  m1 <- c(m1, data_4g$median.rate)
  data_5g <- read.csv(paste0("result/", clade, "_5g_BAMM_median_speciation_rates.csv", sep=""), header=TRUE)
  m2 <- c(m2, data_5g$median.rate)
  tip_4g <- read.csv(paste0("result/", clade, "_4g_BAMM_TipRates.csv", sep=""), header=TRUE)
  m3 <- c(m3, tip_4g$Rate)
  tip_5g <- read.csv(paste0("result/", clade, "_5g_BAMM_TipRates.csv", sep=""), header=TRUE)
  m4 <- c(m4, tip_5g$Rate)
  
}


###########whole_tree_scale############
#mean_4g_rate
mean(m1)
#mean_5g_rate
mean(m2)
#mean_4g_tip_rate
mean(m3)
#mean_5g_tip_rate
mean(m4)
