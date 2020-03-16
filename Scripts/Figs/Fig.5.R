
rm(list=ls())
library("scales")
library("tidyverse")


#### Fig. 5 ####

data <- readRDS("./Datasets/diversification_data/Rosid_sampling_diversification_rate_dataset.rds")
# rate <- list("RPANDA"=RPANDA, "BAMMsr"=BAMMsr, "BAMMtr"=BAMMtr, "DR"=DR)
rate <- data[[1]]

#################plot2pdf########################
pdf('../Figure/Fig.5.Cucurbitaceae_20k_family_40_random_treatment_rate_metric_boxplot.pdf', width=6, height=11)

par(mfrow = c(4, 2), mar = c(5,3,3,0), oma = c(0,1,1,0))

color <- "#2b9778"
rateMetricLabels <- c(expression(bold(paste(lambda['RPANDA']))), expression(bold(paste(lambda['BAMM tree-wide']))), expression(bold(paste(lambda['BAMM tip']))), expression(bold(paste(lambda['DR']))))
rateylab <- expression(paste("Rate (","Myr"^"-1", ")"))
qrange <- c(0.05, 0.95)
width <- 0.4
# brks <- c(1,10,30,50,75)

for(i in 1:length(rate)){
  
  dat <- rate[[i]]
  
  if(i==4){
    yrange <- c(0.15, quantile(unlist(sapply(dat, function(x) x)), 0.985))
    plot.new()
    plot.window(xlim = c(0.5, 4.5), ylim = yrange)
    axis(1, at = c(0.5, 1:4), labels = FALSE)
    #axis(1, at = c(1, 1.5:3.5), tick=FALSE, labels = c(NA, c("9k-tip", "20k-tip", "100k-tip")), lwd=0, cex.axis =1, mgp = c(3, 0.7, 0), xpd=NA)
    text(x = (1:4) + 0.35, y = 0.13, labels = c('10%', '30%', '50%','75%'), srt=45, pos=2, xpd=NA)
    axis(2, at = c(-10, axTicks(2)), cex.axis = 1, mgp = c(3, 0.7, 0))
    
    for (j in 1:length(dat)) {
      
      if(quantile(dat[[j]],  qrange[2], na.rm=TRUE) > yrange[2]){
        dat[[j]] <- outlier(dat[[j]])
      }
      
      qStats <- quantile(dat[[j]], c(qrange[1], 0.25, 0.5, 0.75, qrange[2]), na.rm=TRUE)
      rect(j - width/2, qStats[2], j + width/2, qStats[4], col=alpha(color, 0.75))
      segments(j, qStats[1], j, qStats[2], lty=2, lend=1)
      segments(j, qStats[4], j, qStats[5], lty=2, lend=1)
      segments(j - width/3, qStats[1], j + width/3, qStats[1], lend=1)
      segments(j - width/3, qStats[5], j + width/3, qStats[5], lend=1)
      segments(j - width/3, qStats[3], j + width/3, qStats[3], lwd=2, lend=1)
    }
    mtext('random drop treatment', side = 1, cex=0.7, line = 2.6)
    title(main = rateMetricLabels[i], line = -0.5)
    
  }else{
    
    yrange <- c(0.2, quantile(unlist(sapply(dat, function(x) x)), 0.985))
    
    plot.new()
    plot.window(xlim = c(0.5, 4.5), ylim = yrange)
    axis(1, at = c(0.5, 1:4), labels = FALSE)
    #axis(1, at = c(1, 1.5:3.5), tick=FALSE, labels = c(NA, c("9k-tip", "20k-tip", "100k-tip")), lwd=0, cex.axis =1, mgp = c(3, 0.7, 0), xpd=NA)
    text(x = (1:4) + 0.35, y = 0.141, labels = c('10%', '30%', '50%','75%'), srt=45, pos=2, xpd=NA)
    axis(2, at = c(-10, axTicks(2)), cex.axis = 1, mgp = c(3, 0.7, 0))
    
    for (j in 1:length(dat)) {
      
      if(quantile(dat[[j]],  qrange[2], na.rm=TRUE) > yrange[2]){
        dat[[j]] <- outlier(dat[[j]])
      }
      
      qStats <- quantile(dat[[j]], c(qrange[1], 0.25, 0.5, 0.75, qrange[2]), na.rm=TRUE)
      rect(j - width/2, qStats[2], j + width/2, qStats[4], col=alpha(color, 0.75))
      segments(j, qStats[1], j, qStats[2], lty=2, lend=1)
      segments(j, qStats[4], j, qStats[5], lty=2, lend=1)
      segments(j - width/3, qStats[1], j + width/3, qStats[1], lend=1)
      segments(j - width/3, qStats[5], j + width/3, qStats[5], lend=1)
      segments(j - width/3, qStats[3], j + width/3, qStats[3], lwd=2, lend=1)
    }
    mtext('random drop treatment', side = 1, cex=0.7, line = 2.6)
    if(i==1 | i==3){mtext(rateylab, side = 2, cex=0.7, line = 2)}
    title(main = rateMetricLabels[i], line = -0.5)
  }
  
}

# mtext('(a)', outer = TRUE, line = -3.5, at = 0.02, font=2)
mtext(c('(a)', '(b)'), outer = TRUE, line = -3, at = c(0.01,0.52), font=2)
mtext(c ('(c)', '(d)'), outer = TRUE, line = -23.5, at = c(0.01,0.52), font=2)
##################################dat2#################################################

#randon drop tip addin by taxonomy
#four levels treatment:10%, 30%, 50%, 75%
# treatment <- c("Cucurbitaceae_20k_10", "Cucurbitaceae_20k_30", "Cucurbitaceae_20k_50", "Cucurbitaceae_20k_75")
# 
# ####################
# #RPANDA
# ###################
# table5 <- read.csv("./data/Cucurbitaceae_20k_family_40_dropaddin_RPANDA.csv", stringsAsFactors=FALSE)
# RPANDA <- list()
# 
# for(i in 1:length(treatment)){
# 
#   RPANDA[[treatment[i]]] <- table5$lamda[table5$treatment %in% treatment[i]]
# }
# 
# ####################
# #BAMM
# ###################
# #speciation rate
# table6 <- read.csv("./data/Cucurbitaceae_20k_family_40_dropaddin_mean_SpeciationRate.csv", stringsAsFactors=FALSE)
# BAMMsr <- list()
# for(i in 1:length(treatment)){
# 
#   BAMMsr[[treatment[i]]] <- table6$speciation_rate[table6$treatment %in% treatment[i]]
# }
# 
# #tip rate
# table7 <- read.csv("./data/Cucurbitaceae_20k_family_40_dropaddin_mean_TipRate.csv", stringsAsFactors=FALSE)
# BAMMtr <- list()
# for(i in 1:length(treatment)){
# 
#   BAMMtr[[treatment[i]]] <- table7$tiprate[table7$treatment %in% treatment[i]]
# }
# ####################
# #DR
# ###################
# 
# table8 <- read.csv("./data/Cucurbitaceae_20k_family_40_dropaddin_mean_DR.csv", stringsAsFactors=FALSE)
# DR <- list()
# for(i in 1:length(treatment)){
# 
#   DR[[treatment[i]]] <- table8$MeanDRrate[table8$treatment %in% treatment[i]]
# }
# 
# rate2 <- list("RPANDA"=RPANDA, "BAMMsr"=BAMMsr, "BAMMtr"=BAMMtr, "DR"=DR)
rate2 <- data[[2]]
#############plot#################

# par(mfrow = c(2, 4), mar = c(5,3,3,0), oma = c(0,1,1,0))
for(i in 1:length(rate2)){
  
  dat <- rate2[[i]]
  
  if(i==1){
    yrange <- c(0, quantile(unlist(sapply(dat, function(x) x)), 0.985))
    plot.new()
    plot.window(xlim = c(0.5, 4.5), ylim = yrange)
    axis(1, at = c(0.5, 1:4), labels = FALSE)
    text(x = (1:4) + 0.35, y = -0.03, labels = c('10%', '30%', '50%','75%'), srt=45, pos=2, xpd=NA)
    axis(2, at = c(-10, axTicks(2)), cex.axis = 1, mgp = c(3, 0.7, 0))
    mtext(rateylab, side = 2, cex=0.7, line = 2)

  } else if(i==2){
    yrange <- c(0.15, quantile(unlist(sapply(dat, function(x) x)), 0.985))
    plot.new()
    plot.window(xlim = c(0.5, 4.5), ylim = yrange)
    axis(1, at = c(0.5, 1:4), labels = FALSE)
    text(x = (1:4) + 0.35, y = 0.08, labels = c('10%', '30%', '50%','75%'), srt=45, pos=2, xpd=NA)
    axis(2, at = c(-10, axTicks(2)), cex.axis = 1, mgp = c(3, 0.7, 0))
  } else if(i==3){
    yrange <- c(0.2, quantile(unlist(sapply(dat, function(x) x)), 0.985))
    plot.new()
    plot.window(xlim = c(0.5, 4.5), ylim = yrange)
    axis(1, at = c(0.5, 1:4), labels = FALSE)
    text(x = (1:4) + 0.35, y = 0.175, labels = c('10%', '30%', '50%','75%'), srt=45, pos=2, xpd=NA)
    axis(2, at = c(-10, axTicks(2)), cex.axis = 1, mgp = c(3, 0.7, 0))
    mtext(rateylab, side = 2, cex=0.7, line = 2)
  } else{
    yrange <- c(0.1, quantile(unlist(sapply(dat, function(x) x)), 0.985))
    plot.new()
    plot.window(xlim = c(0.5, 4.5), ylim = yrange)
    axis(1, at = c(0.5, 1:4), labels = FALSE)
    text(x = (1:4) + 0.35, y = 0.08, labels = c('10%', '30%', '50%','75%'), srt=45, pos=2, xpd=NA)
    axis(2, at = c(-10, axTicks(2)), cex.axis = 1, mgp = c(3, 0.7, 0))
  }
    
    for (j in 1:length(dat)) {
      
      if(quantile(dat[[j]],  qrange[2], na.rm=TRUE) > yrange[2]){
        dat[[j]] <- outlier(dat[[j]])
      }
      
      qStats <- quantile(dat[[j]], c(qrange[1], 0.25, 0.5, 0.75, qrange[2]), na.rm=TRUE)
      rect(j - width/2, qStats[2], j + width/2, qStats[4], col=alpha(color, 0.75))
      segments(j, qStats[1], j, qStats[2], lty=2, lend=1)
      segments(j, qStats[4], j, qStats[5], lty=2, lend=1)
      segments(j - width/3, qStats[1], j + width/3, qStats[1], lend=1)
      segments(j - width/3, qStats[5], j + width/3, qStats[5], lend=1)
      segments(j - width/3, qStats[3], j + width/3, qStats[3], lwd=2, lend=1)
    }
    mtext('random drop&addin treatment', side = 1, cex=0.7, line = 2.6)
    #title(main = rateMetricLabels[i], line = -0.05)
    title(main = rateMetricLabels[i])
  
}
# mtext('(b)', outer = TRUE, line = -28.5, at = 0.02, font=2)
mtext(c('(e)', '(f)'), outer = TRUE, line = -44, at = c(0.01,0.51), font=2)
mtext(c('(g)', '(h)'), outer = TRUE, line = -64, at = c(0.01,0.51), font=2)
dev.off()

# RateMetric <- list(rate, rate2)
# 
# saveRDS(RateMetric, "./data/Rosid_sampling_diversification_rate_dataset.rds")
