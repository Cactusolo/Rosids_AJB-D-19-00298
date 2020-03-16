rm(list=ls())

# RR <- list.files("./BAMMresult", pattern = "_Rate_Matrix.csv$", full.names = TRUE)
# 
# TT <- list.files("./BAMMresult", pattern = "_Rate_Matrix.csv$", full.names = TRUE)

ll <- read.csv("Order", header=F)
orderlist <- as.character(ll$V1)

file.t="./BAMMresult/rosid_17_order_PB_tiprates_sum_table.csv"
cat("Order,mean_tip_rate,tree-wide_rate\n", sep="", file=file.t)

for (i in 1:length(orderlist)){
   
   order <- orderlist[i]
   #Fabales not finished yet
   # if(i==5){
   #   
   #   cat(paste0(order, ",NA,NA"), sep="\n", file=file.t, append = TRUE)
   # } else{
     #mean tip rates
     ff <- read.csv(paste0("./BAMMresult/", order, "_BAMM_PB_TipRates.csv", sep=""), header=TRUE)
     mean.tiprate <- mean(ff$Rate)
     
     #mean tree-wide speciation rates
     rr <- read.csv(paste0("./BAMMresult/", order, "_PB_Mean_Rate_Matrix.csv", sep=""), header=TRUE)
     tw_rate <- mean(rr$Mean.lamda)
     cat(paste0(order, ",", mean.tiprate, ",", tw_rate), sep="\n", file=file.t, append = TRUE)
   # }
 }


color=c("chocolate4","darkmagenta","paleturquoise4", "green4", "blue", "yellow3","palevioletred1","mediumturquoise",
        "sienna1","magenta1","forestgreen","khaki4","orangered4","red","slateblue4","goldenrod2", "mediumorchid3")

rateylab <- expression(paste("Rate (","Myr"^"-1", ")"))

pdf("./BAMMresult/rosid-20k-tip_rate-through-time_plot_BDvsPB.pdf", width = 10, height = 10)

par(mfrow = c(3, 3), mar = c(4,3,1,0), oma = c(0,0.5,0.5,0))

for (i in 1:length(orderlist)){
  order <- orderlist[i]
  # if(i !=5){
    PB <- read.csv(paste0("./BAMMresult/", order, "_PB_Mean_Rate_Matrix.csv", sep=""), header=TRUE)
  # }
  BD <- read.csv(paste0("./BAMMresult/BAMM_BD_rates/", order, "_5g_BAMM_median_speciation_rates.csv", sep=""), header=TRUE)
  
  
  xrang=c(max(BD$Time), 0)
  yrang <- c(0, max(BD$median.rate, PB$Mean.lamda))
  
  plot(BD$median.rate ~ rev(BD$Time), type="l", lwd=2, xlab="Time before present (Myr)", ylab="", ylim=yrang, xlim=xrang, bty="n", col=color[i])
  title(main = order, line = -0.8)
  if(i %in% c(1, 4, 7, 10, 13, 16)){
    mtext(rateylab, side = 2, cex=0.7, line = 2)
  }
  par(new=TRUE)
  # if(i !=5){
    lines(PB$Mean.lamda ~ rev(PB$rtt.times), type="l", lwd=2,  col=color[i], lty=2)
  # }
  legend(max(BD$Time), 0.5*max(BD$median.rate, PB$Mean.lamda), legend=c("birth-death", "pure-birth"), col=color[i], lwd=2, lty=c  (1, 2), bty = "n")
  if(i==9){
    mtext(c('(a)', '(b)', '(c)'), outer = TRUE, line = -1, at = c(0.01,0.37,0.695), font=2  )
    mtext(c('(d)', '(e)', '(f)'), outer = TRUE, line = -23, at = c(0.01,0.36,0.7), font=2)
    mtext(c('(g)', '(h)', '(i)'), outer = TRUE, line = -47.5, at = c(0.01,0.36, 0.7), font=2)
  }
  if(i==17){
    mtext(c('(j)', '(k)', '(l)'), outer = TRUE, line = -1, at = c(0.01,0.37,0.695), font=2  )
    mtext(c('(m)', '(n)', '(o)'), outer = TRUE, line = -23, at = c(0.01,0.36,0.7), font=2)
    mtext(c('(p)', '(q)'), outer = TRUE, line = -47.5, at = c(0.01,0.36), font=2)
  }
}  
dev.off()