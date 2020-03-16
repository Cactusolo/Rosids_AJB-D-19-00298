
rm(list=ls())
library("scales")
library("tidyverse")

###################
#prepare dataset as list
###################
dataname <- c("9k-tip", "20k-tip", "100k-tip")
rateMetric <- c("RPANDA", "BAMM", "DR")

####################
#RPANDA
###################
RPANDA <- list()

for(i in 1:length(dataname)){
  table1 <- read.csv(paste0("./Datasets/diversification_data/RPANDA/rosids_", dataname[i], "_RPANDA.csv", sep=""), stringsAsFactors=FALSE)
  RPANDA[[dataname[i]]] <- table1$lamda
}


####################
#BAMM
###################
BAMM <- list()

#100k-tip not finished yet
for(i in 1:(length(dataname))){
  table2 <- read.csv(paste0("./Datasets/diversification_data/BAMM/rosids_", dataname[i], "_BAMM_SpeciationRate.csv", sep=""), stringsAsFactors=FALSE)
  table3 <- read.csv(paste0("./Datasets/diversification_data/BAMM/rosids_", dataname[i], "_BAMM_tipRate.csv", sep=""), stringsAsFactors=FALSE)
  BAMM[[dataname[i]]] <- list("SpeciationRate"=table2$SpeciationRate, "TipRate"=table3$Rate)
}

####################
#DR
###################
DR <- list()

for(i in 1:length(dataname)){
  table4 <- read.csv(paste0("./Datasets/diversification_data/DR/rosids_", dataname[i], "_DR.csv", sep=""), stringsAsFactors=FALSE)
  names(table4) <- c("tips", "DRrate")
  DR[[dataname[i]]] <- table4$DRrate
}


#remove outlior function
outlier <- function(x) {
  xx <- x[!x %in% boxplot.stats(x)$out]
  return(xx)
}
#### Fig. 3 ####
################rate metric boxplot for global trees#######################
pdf('../Figure/Fig.3.rosid_9k_20K_100k-tip_rate_metric_boxplot_updated.pdf', width=7, height=7)
par(mfrow = c(2, 2), mar = c(5,3,3,0), oma = c(0,1,1,0))

color <- "#2b9778"
rateMetricLabels <- c(expression(bold(paste(lambda['RPANDA']))), expression(bold(paste(lambda['BAMM tree-wide']))), expression(bold(paste(lambda['BAMM tip']))), expression(bold(paste(lambda['DR']))))
rateylab <- expression(paste("Rate (","Myr"^"-1", ")"))
qrange <- c(0.05, 0.95)
width <- 0.4

rateMetric <- list("RPANDA"=RPANDA, "BAMM"=BAMM, "DR"=DR)
for(i in 1:4){
  if(i==1){
    rate <- rateMetric[[i]]
  } else if(i==2){#BAMM tree-wdie rate
    rate <- list()
    for(x in 1:3){#loop for 9k-, 20k- and 100k-tip trees
      rate[[x]] <- rateMetric[[i]][[x]]$SpeciationRate
    }
  }else if(i==3){#BAMM tip rate
    rate <- list()
    for(x in 1:3){#loop for 9k-, 20k- and 100k-tip trees
      rate[[x]] <- rateMetric[[i-1]][[x]]$TipRate
    }
    
  }else {
    rate <- rateMetric[[i-1]]
  }
  
  
  dat <- rate
  
  yrange <- c(0, quantile(unlist(sapply(dat, function(x) x)), 0.985))
  
  plot.new()
  plot.window(xlim = c(1, 4), ylim = yrange)
  axis(1, at = c(1, 1.5:3.5), labels = NA)
  axis(1, at = c(1, 1.5:3.5), tick=FALSE, labels = c(NA, c("9k-tip", "20k-tip", "100k-tip")), lwd=0, cex.axis =1, mgp = c(3, 0.7, 0), xpd=NA)
  
  axis(2, at = c(0, axTicks(2)), cex.axis = 1, mgp = c(3, 0.7, 0))
  
  for (j in 1:length(dat)) {
    jj <- j + 0.5
    
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
  
  if(i==1|i==3){mtext(rateylab, side = 2, cex=0.7, line = 2)}
  title(main = rateMetricLabels[i], line = -0.5)
  
}

mtext(c('(a)', '(b)'), outer = TRUE, line = -2.5, at = c(0.01, 0.51), font=2)

mtext(c('(c)', '(d)'), outer = TRUE, line = -23, at = c(0.01, 0.51), font=2)

dev.off()
