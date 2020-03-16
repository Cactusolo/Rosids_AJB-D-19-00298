rm(list=ls())


pdf("../Figure/rosid_9k-20k-100k-tip_rate-through-time_plot.pdf", width = 10, height = 9)

# par(mfrow = c(6, 3), mar = c(4,3,3,0), oma = c(0,1,1,0))

Order <- c("Brassicales","Celastrales","Crossosomatales","Cucurbitales","Fabales","Fagales","Geraniales","Huerteales","Malpighiales","Malvales","Myrtales","Oxalidales","Picramniales","Rosales","Sapindales","Vitales","Zygophyllales")

color=c("chocolate4","darkmagenta","paleturquoise4", "green4", "blue", "yellow3","palevioletred1","mediumturquoise",
      "sienna1","magenta1","forestgreen","khaki4","orangered4","red","slateblue4","goldenrod2", "mediumorchid3")

rateylab <- expression(paste("Rate (","Myr"^"-1", ")"))

par(mfrow = c(3, 3), mar = c(4,3,1,0), oma = c(0,0.5,0.5,0))
# dir.create("plots")
# for (i in 1:length(Order)){
for (i in 1:9){
# BAMM_plot <- function(i){
  clade <- Order[i]
  data_4g <- read.csv(paste0("result/", clade, "_4g_BAMM_median_speciation_rates.csv", sep=""), header=TRUE)
  data_5g <- read.csv(paste0("result/", clade, "_5g_BAMM_median_speciation_rates.csv", sep=""), header=TRUE)
  otl <- read.csv(paste0("otl_subclade/Summary/", clade, "_BAMM_median_SpeciationRates.csv", sep=""), header=TRUE)
  # t <- ifelse(max(data_5g$Time) > max(data_4g$Time), max(data_5g$Time), max(data_4g$Time))
  # R <- ifelse(max(data_5g$median.rate) > max(data_4g$median.rate), max(data_5g$median.rate), max(data_4g$median.rate))
  xrang=c(max(otl$Time, data_5g$Time, data_4g$Time), 0)
  yrang <- c(0, max(data_5g$median.rate, data_4g$median.rate, otl$median.rate))
          
  plot(data_5g$median.rate ~ rev(data_5g$Time), type="l", lwd=2, xlab="Time before present (Myr)", ylab="", ylim=yrang, xlim=xrang, bty="n", col=color[i])
  title(main = clade, line = -0.8)
  par(new=TRUE)
  lines(data_4g$median.rate ~ rev(data_4g$Time), type="l", lwd=2,  col=color[i], lty=2)
  lines(otl$median.rate ~ rev(otl$Time), type="l", lwd=3, col=color[i], lty=3)
  
  if(i %in% c(1, 4,7)){
    mtext(rateylab, side = 2, cex=0.65, line = 2)
  }
  
  if (i %in% c(1, 2)) {
    legend(95, 1.5, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 3) {
    legend(90, 0.12, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 4) {
    legend(110, 3.5, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 5 ){
    legend(45, 15, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i==6) {
    legend(100, 1.3, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 7){
    legend(45, 1.5, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 8){
    legend(68, 0.3, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i==6|i==9) {
    legend(110, 1.3, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } 
}
mtext(c('(a)', '(b)', '(c)'), outer = TRUE, line = -1, at = c(0.01,0.36,0.69), font=2)
mtext(c('(d)', '(e)', '(f)'), outer = TRUE, line = -23.5, at = c(0.01,0.36,0.69), font=2)
mtext(c('(g)', '(h)', '(i)'), outer = TRUE, line = -46, at = c(0.01,0.365,0.69), font=2)
# dev.off()
# 
# pdf("../Figure/rosid_9k-20k-100k-tip_rate-through-time_plot2.pdf", width = 10, height = 9)

##########second page
par(mfrow = c(3, 3), mar = c(4,3,1,0), oma = c(0,0.5,0.5,0))
# dir.create("plots")
# for (i in 1:length(Order)){
for (i in 10:17){
  # BAMM_plot <- function(i){
  clade <- Order[i]
  data_4g <- read.csv(paste0("result/", clade, "_4g_BAMM_median_speciation_rates.csv", sep=""), header=TRUE)
  data_5g <- read.csv(paste0("result/", clade, "_5g_BAMM_median_speciation_rates.csv", sep=""), header=TRUE)
  otl <- read.csv(paste0("otl_subclade/Summary/", clade, "_BAMM_median_SpeciationRates.csv", sep=""), header=TRUE)
  # t <- ifelse(max(data_5g$Time) > max(data_4g$Time), max(data_5g$Time), max(data_4g$Time))
  # R <- ifelse(max(data_5g$median.rate) > max(data_4g$median.rate), max(data_5g$median.rate), max(data_4g$median.rate))
  xrang=c(max(otl$Time, data_5g$Time, data_4g$Time), 0)
  yrang <- c(0, max(data_5g$median.rate, data_4g$median.rate, otl$median.rate))
  
  plot(data_5g$median.rate ~ rev(data_5g$Time), type="l", lwd=2, xlab="Time before present (Myr)", ylab="", ylim=yrang, xlim=xrang, bty="n", col=color[i])
  title(main = clade, line = -0.8)
  par(new=TRUE)
  lines(data_4g$median.rate ~ rev(data_4g$Time), type="l", lwd=2,  col=color[i], lty=2)
  lines(otl$median.rate ~ rev(otl$Time), type="l", lwd=3, col=color[i], lty=3)
  
  if(i %in% c(10, 13,16)){
    mtext(rateylab, side = 2, cex=0.65, line = 2)
  }
  
  if (i ==1 ) {
    legend(100, 1.3, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 11) {
    legend(100, 0.8, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 12) {
    legend(110, 1.8, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 13){
    legend(72, 1.4, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 14){
    legend(45, 1.4, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 15){
    legend(90, 1.4, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else if (i == 16){
    legend(30, 8, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } else {
    legend(95, 1.4, legend=c("9k-tip", "20k-tip", "100k-tip"), col=color[i], lwd=2, lty=c(2, 1, 3), bty = "n")
  } 
  
}
mtext(c('(j)', '(k)', '(l)'), outer = TRUE, line = -1, at = c(0.01,0.37,0.695), font=2)
mtext(c('(m)', '(n)', '(o)'), outer = TRUE, line = -23, at = c(0.01,0.36,0.7), font=2)
mtext(c('(p)', '(q)'), outer = TRUE, line = -47.5, at = c(0.01,0.36), font=2)

dev.off()
