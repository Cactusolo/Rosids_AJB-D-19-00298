rm(list=ls())

library("tidyverse")

######################################################################
#comparison of RTT curves from 10%, 30% 50% and 75% random drop treatment 
#with original tree 

pdf("../Figure/Fig. 6. BAMM_40_RTT_curves_from_treatment_of_droptip.pdf", width=6, height=6)
par(mfrow = c(2, 2), mar = c(5,4,1,0), oma = c(0.5,1,0.5,0))
fam <- read_csv("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_5g_family_level/regular_single_family/BAMM_Run_family/result/Cucurbitaceae_5g_family_BAMM_median_speciation_rates.csv")
xrang <- c(35,0)
yrang <- c(0,1)
brks <- c(10,30,50,75)
color <- c("#f4320c","#10a674","orange", "#910951")
rateylab <- expression(paste("Rate (","Myr"^"-1", ")"))
files <- list.files("./Datasets/diversification_data/Cucurbitaceae_Test_Case/Cucurbitaceae_5g_family_level/Fam_40_random_drop_tip/BAMM_40/BAMM_40_result", 
                    pattern = "_BAMM_median_speciation_rates.csv", full.names = TRUE)

for(i in 1:length(files)){
  name <- gsub("_BAMM_median_speciation_rates.csv", "", basename(files[i]))
  name <- gsub('_[0-9]+$', '', name)
  data <- read.csv(files[i], header = TRUE)
  q <- as.numeric(unlist(strsplit(name, split="_"))[[3]])
  
  if(q==10){
    if(i==1){
      #plot.new()
      plot(data$median.rate ~ rev(data$Time), type="l", xlab="Time before present (Myr)", 
           ylab="", ylim=yrang, xlim=xrang, col=alpha(color[brks %in% q], 0.8), 
           bty="n", main="Speciation Rate Through Time Curve", cex.main=0.7, cex.axis=0.8)
      mtext(rateylab, side = 2, cex=0.7, line = 2)
    } else {
      par(new=TRUE)
      lines(data$median.rate ~ rev(data$Time), type="l", col=alpha(color[brks %in% q], 0.8))
    }
    lines(fam$median.rate ~ rev(fam$Time), type="l", lwd=2, col="black")
    legend(15, 0.15, legend=c("Original tree", "10% treatment"), col=c("black", color[brks %in% q]), cex=0.6, lty=1, bty = "n")
  }else if(q==30){
    if(i-10==1){
      # plot.new()
      plot(data$median.rate ~ rev(data$Time), type="l", xlab="Time before present (Myr)", 
           ylab="", ylim=yrang, xlim=xrang, col=alpha(color[brks %in% q], 0.8), 
           bty="n", main="Speciation Rate Through Time Curve", cex.main=0.7, cex.axis=0.8)
      mtext(rateylab, side = 2, cex=0.7, line = 2)
    } else {
      par(new=TRUE)
      lines(data$median.rate ~ rev(data$Time), type="l", col=alpha(color[brks %in% q], 0.8))
      
    }
    lines(fam$median.rate ~ rev(fam$Time), type="l", lwd=2, col="black")
    legend(15, 0.15, legend=c("Original tree", "30% treatment"), col=c("black", color[brks %in% q]), cex=0.6, lty=1, bty = "n")
  }else if(q==50){
    if(i-20==1){
      # plot.new()
      plot(data$median.rate ~ rev(data$Time), type="l", xlab="Time before present (Myr)", 
           ylab="", ylim=yrang, xlim=xrang, col=alpha(color[brks %in% q], 0.8), 
           bty="n", main="Speciation Rate Through Time Curve", cex.main=0.7, cex.axis=0.8)
      mtext(rateylab, side = 2, cex=0.7, line = 2)
    } else {
      par(new=TRUE)
      lines(data$median.rate ~ rev(data$Time), type="l", col=alpha(color[brks %in% q], 0.8))
    }
    lines(fam$median.rate ~ rev(fam$Time), type="l", lwd=2, col="black")
    legend(15, 0.15, legend=c("Original tree", "50% treatment"), col=c("black", color[brks %in% q]), cex=0.6, lty=1, bty = "n")
  }else{
    if(i-30==1){
      # plot.new()
      plot(data$median.rate ~ rev(data$Time), type="l", xlab="Time before present (Myr)", 
           ylab="", ylim=yrang, xlim=xrang, col=alpha(color[brks %in% q], 0.8), 
           bty="n", main="Speciation Rate Through Time Curve", cex.main=0.7, cex.axis=0.8)
      mtext(rateylab, side = 2, cex=0.7, line = 2)
      mtext(c('(a)', '(b)'), outer = TRUE, line = -2, at = c(0.02,0.52), font=2)
      mtext(c('(c)', '(d)'), outer = TRUE, line = -18.7, at = c(0.02,0.52), font=2)
    } else {
      par(new=TRUE)
      lines(data$median.rate ~ rev(data$Time), type="l", col=alpha(color[brks %in% q], 0.8))
    }
    lines(fam$median.rate ~ rev(fam$Time), type="l", lwd=2, col="black")
    legend(15, 0.15, legend=c("Original tree", "75% treatment"), col=c("black", color[brks %in% q]), cex=0.6, lty=1, bty = "n")
  }
}
dev.off()