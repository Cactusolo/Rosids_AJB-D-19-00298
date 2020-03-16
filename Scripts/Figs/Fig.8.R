rm(list=ls())
library("scales")
library("tidyverse")

######################
#Cucurbitaceae family level one 528-tip tree
######################

#RPANDA
RPANDA.f <- read_csv("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_20k_family_1tree_RPADNA_best_model_AW.csv")
RPANDA.f <- RPANDA.f$lamda
#BAMM
speciation.rate <- read_csv("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_20k_family_1tree_BAMM_median_speciation_rates.csv")
mean.speciation.rate <- mean(speciation.rate$median.rate)
tip.rate.f <- read_csv("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_20k_family_1tree_BAMM_TipRates.csv")
mean.tip.rate.f <- mean(tip.rate.f$Rate)
#DR
DR.f <- read_csv("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_20k_family_1tree_DR.csv")

mean.DR.f <- mean(DR.f$DRrate)


######################
#genus level 10 trees
######################
rateMetric1 <- c("RPANDA","BAMM_mean_SpeciationRate", "BAMM_mean_TipRate", "BAMM_specific_mean_SpeciationRate", "BAMM_specific_mean_tipRate", "mean_DR")
dat <- list()
for(i in 1:length(rateMetric1)){
  
  tmp <- read.csv(paste0("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_20k_genus_10_", rateMetric1[i], ".csv", sep=""), stringsAsFactors=FALSE)
  if(i==1){
    dat[[i]] <- tmp[,3]
  } else{
    dat[[i]] <- tmp[,2]
  }
}

#dat2
# each rate metric substract the mean rate estimated from the family level
fam.mean.rate <- c(RPANDA.f, mean.speciation.rate, mean.tip.rate.f, mean.DR.f)

dat2 <- list()
for(i in 1:length(rateMetric1)){
  
  tmp <- read.csv(paste0("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_20k_genus_10_", rateMetric1[i], ".csv", sep=""), stringsAsFactors=FALSE)
  if(i==1){
    dat2[[i]] <- abs(fam.mean.rate[i]-tmp[,3])
    
  } else if(i==2 | i==4){
    dat2[[i]] <- abs(fam.mean.rate[2]-tmp[,2])
  }else if(i==3 | i==5){
    dat2[[i]] <- abs(fam.mean.rate[3]-tmp[,2])
  }else{
    dat2[[i]] <- abs(fam.mean.rate[4]-tmp[,2])
  }
}

#remove outlior function
outlier <- function(x) {
  xx <- x[!x %in% boxplot.stats(x)$out]
  return(xx)
}

pdf('../Figure/Fig.8.Cucurbitaceae_20k_family_genus_diff_rate_metric_boxplot_RTT.pdf', width=4, height=10)

par(mfrow = c(3, 1), mar = c(5,3,3,0), oma = c(0,1,1,0))

color <- "#2b9778"


#plot one
rateylab <- expression(paste("Rate (","Myr"^"-1", ")"))
qrange <- c(0.05, 0.95)
width <- 0.4
yrange <- c(0.075, quantile(unlist(sapply(dat, function(x) x)), 0.985))

plot.new()
plot.window(xlim = c(1, 4), ylim = yrange)
axis(1, at = seq(1.2,4,0.5), labels = NA)
axis(1, at = c(1, seq(1.2,4,0.5)), tick=FALSE, labels = c(NA, c("RPANDA", "BAMM\nglobal\ntree-wide", "BAMM\nglobal tip", "BAMM\nspecific\ntree-wide", "BAMM\nspecific tip", "DR")), lwd=0, cex.axis =0.7, mgp = c(3, 0.7, 0), xpd=NA, line=1.5)

axis(2, at = c(0.075, axTicks(2)), cex.axis = 1, mgp = c(3, 0.7, 0))

for (j in 1:length(dat)) {
  
  if(j == 1){
    jj <- 1.2
  } else{
    jj <- 1.2 + 0.5*(j-1)
  }
  
  
  if(quantile(dat[[j]],  qrange[2], na.rm=TRUE) > yrange[2]){
    dat[[j]] <- outlier(dat[[j]])
  }
  qStats <- quantile(dat[[j]], c(qrange[1], 0.25, 0.5, 0.75, qrange[2]), na.rm=TRUE)
  rect(jj - width/2, qStats[2], jj + width/2, qStats[4], col=alpha(color, 0.75))
  segments(jj, qStats[1], jj, qStats[2], lty=2, lend=1)
  segments(jj, qStats[4], jj, qStats[5], lty=2, lend=1)
  segments(jj - width/3, qStats[1], jj + width/3, qStats[1], lend=1)
  segments(jj - width/3, qStats[5], jj + width/3, qStats[5], lend=1)
  segments(jj - width/3, qStats[3], jj + width/3, qStats[3], lwd=2, lend=1)
}

mtext(rateylab, side = 2, cex=0.8, line = 2)
#title(main = rateMetricLabels[i], line = -0.5)
#legend(1.5, 0.15, legend = "GS=")

mtext('(a)', outer = TRUE, line = -3, at = 0.01, font=2)

#plot two dat2
yrange <- c(0, quantile(unlist(sapply(dat2, function(x) x)), 0.985))
plot.new()
plot.window(xlim = c(1, 4), ylim = yrange)

axis(1, at = seq(1.2,4,0.5), labels = NA)
axis(1, at = c(1, seq(1.2,4,0.5)), tick=FALSE, labels = c(NA, c("RPANDA", "BAMM\nglobal\ntree-wide", "BAMM\nglobal tip", "BAMM\nspecific\ntree-wide", "BAMM\nspecific tip", "DR")), lwd=0, cex.axis =0.7, mgp = c(3, 0.7, 0), xpd=NA, line=1.5)

axis(2, at = c(0, axTicks(2)), cex.axis = 1, mgp = c(3, 0.7, 0))

for (j in 1:length(dat2)) {
  
  if(j == 1){
    jj <- 1.2
  } else{
    jj <- 1.2 + 0.5*(j-1)
  }
  
  
  if(quantile(dat2[[j]],  qrange[2], na.rm=TRUE) > yrange[2]){
    dat2[[j]] <- outlier(dat2[[j]])
  }
  qStats <- quantile(dat2[[j]], c(qrange[1], 0.25, 0.5, 0.75, qrange[2]), na.rm=TRUE)
  rect(jj - width/2, qStats[2], jj + width/2, qStats[4], col=alpha(color, 0.75))
  segments(jj, qStats[1], jj, qStats[2], lty=2, lend=1)
  segments(jj, qStats[4], jj, qStats[5], lty=2, lend=1)
  segments(jj - width/3, qStats[1], jj + width/3, qStats[1], lend=1)
  segments(jj - width/3, qStats[5], jj + width/3, qStats[5], lend=1)
  segments(jj - width/3, qStats[3], jj + width/3, qStats[3], lwd=2, lend=1)
}
mtext(rateylab, side = 2, cex=0.8, line = 2)
# mtext(rateylab, side = 2, cex=0.8, line = 2)
mtext('(b)', outer = TRUE, line = -28, at = 0.01, font=2)

#plot three 
#RTT plot with genus level (global sampling and clade specific samling; 10 +10 tree) + family level (i tree)
# 
files <- list.files("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_20k_genus_10_BAMM_RTT_matrix", pattern = "_BAMM_global_median_speciation_rates.csv", full.names = TRUE)

files2 <- list.files("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_20k_genus_10_BAMM_RTT_matrix", pattern = "_BAMM_specific_median_speciation_rates.csv", full.names = TRUE)


# plot.new()

# plot.window(xlim = c(1, 4), ylim = c(0,0.5))
data1 <- read_csv(files[1])

plot(data1$median.rate ~ rev(data1$Time), type="l", xlab="Time before present (Myr)", ylab="", ylim=c(0.1,0.5), xlim=c(35,0), bty="n", col=alpha("blue", 0.5))
mtext(rateylab, side = 2, cex=0.8, line = 2)
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
  lines(speciation.rate$median.rate ~ rev(speciation.rate$Time), type="l", lwd=2, col="black")

legend(33, 0.45, legend=c("global sampling fraction", "clade sampling fraction", "original family tree"), col=c("blue", "orange", "black"), cex=0.8, lty=c(1,1,1), bty = "n")
mtext('(c)', outer = TRUE, line = -52.5, at = 0.01, font=2)

dev.off()