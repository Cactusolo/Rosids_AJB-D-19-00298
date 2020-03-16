# the rates is mean median rates
rm(list=ls())
library("tidyverse")

Order <- read.csv("Order", header=FALSE, stringsAsFactors = FALSE)

Order <- Order$V1

cat("Order,SpeciationRate,TipRate\n", file = "Rosid_100k_17order_BAMM_mean_rates.csv", sep = "", quote=FALSE, append = TRUE)

for (i in 1:length(Order)){
  order <- Order[i]
  file1 <- read_csv(paste0(order, "_BAMM_median_SpeciationRates.csv", sep=""))
  tree.rate <- file1 %>% summarise(mean(median.rate))
  file2 <- read_csv(paste0(order, "_BAMM_TipRates.csv", sep=""))
  tip.rate <- file2 %>% summarise(mean(Rate))
  dat <- c(order, tree.rate, tip.rate)
  write.table(dat, file="Rosid_100k_17order_BAMM_mean_rates.csv", sep=",", row.names = FALSE, col.names = FALSE, append = TRUE, quote=FALSE)
}
