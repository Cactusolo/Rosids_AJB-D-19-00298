library(scales)
library(tidyverse)

files <- list.files("genus_level_10BAMM/result", pattern = "_BAMM_median_speciation_rates.csv", full.names = TRUE)

files2 <- list.files("genus_level_10BAMM/result_fraction", pattern = "_BAMM_median_speciation_rates.csv", full.names = TRUE)

pdf("../../Figure/BMM_genus_level_10B_sampling_fraction_treatment_rttplot.pdf", width = 6, height = 5)
data1 <- read_csv(files[1])

plot(data1$median.rate ~ rev(data1$Time), type="l", xlab="Time before present (Myr)", ylab="Median Speciation Rate", ylim=c(0,0.5), xlim=c(35,0), bty="n", col=alpha("blue", 0.5))

for(i in 2:length(files)){
  data <- read_csv(files[i])
  par(new=TRUE)
  lines(data$median.rate ~ rev(data$Time), type="l", col=alpha("blue", 0.5))
}

for(i in 1:length(files2)){
  data2 <- read_csv(files2[i])
  # par(new=TRUE)
  lines(data2$median.rate ~ rev(data2$Time), type="l", col=alpha("orange", 0.5))
}


legend(15, 0.4, legend=c("Global sampling fraction", "Clade sampling fraction"), col=c("blue", "orange"), cex=0.8, lty=c(1,1), bty = "n")

dev.off()