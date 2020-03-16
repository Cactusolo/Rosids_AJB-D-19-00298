rm(list=ls())
library("BAMMtools") 
library("coda")

BAMM_summ <- function(Tree){
  name <- unlist(strsplit(basename(Tree), split="[.]"))[1]
  directory <- "./genus_level_10BAMM/"
  ####evaluate mcmc##############
  mcmc <- read.csv(paste(directory, "data_fraction/", name, "_mcmc_out_1.txt", sep=""), header=T)
  
  pdf(paste0(directory, "result_fraction/", name, "_MCMC_convergent.pdf", sep=""))
  plot(mcmc$logLik ~ mcmc$generation)
  dev.off()
  
  burnstart <- floor(0.2*nrow(mcmc))
  postburn <- mcmc[burnstart:nrow(mcmc), ]#postburn is the generations left after burning
  
  #next caculate the effective sample size (ESS), which should be greater than 200 if our analysis
  # ran long enough
  logLik <- effectiveSize(postburn$logLik) # calculates autocorrelation function
  N_shift <- effectiveSize(postburn$N_shift) #effective sample size on N-shifts
  ESSample <- cbind.data.frame(name, logLik, N_shift)
  file1 <- paste0(directory, "result_fraction/", name, "_ESS_convergence.txt", sep="")
  cat("Tree_name,LogLik,N_shift\n", file=file1)
  write.table(ESSample, file=file1, row.names=F, col.names=F, quote=FALSE, sep=",")
  
  #read tree
  tree <- read.tree(Tree)
  
  #read event data
  edata <- getEventData(tree, paste(directory, "data_fraction/", name, "_event_data_1.txt", sep=""), burnin = 0.2)
  
  #tip rates
  TR <- getTipRates(edata, returnNetDiv = FALSE, statistic = "median")
  file2 <- paste0(directory, "result_fraction/", name, "_BAMM_TipRates.csv", sep="")
  cat("Tip_label,Rate\n", file=file2)
  write.table(TR$lambda.avg, sep=",", file=file2, col.names = FALSE, quote=FALSE, append = TRUE)
  
  #median speciation rate
  Rate.Matrix <- getRateThroughTimeMatrix(edata)
  Time <- Rate.Matrix$times
  median.rate <- apply(Rate.Matrix$lambda, 2, quantile, c(0.5))
  md.rmat <- cbind.data.frame(Time, median.rate)
  write.csv(md.rmat, file=paste0(directory, "result_fraction/", name, "_BAMM_median_speciation_rates.csv", sep=""), quote=FALSE, row.names = FALSE)
  
  #summarize mean_meidan and rate	mean_tip_rate#####
  
  mm_data <- c(paste0("Mean_tipRate,", mean(TR$lambda.avg), sep=""), paste0("Mean_lamda,", mean(Rate.Matrix$lambda), sep=""))
  write.csv(mm_data, file=paste0(directory, "result_fraction/", name, "_BAMM_mean_tip&speciation_rates.csv", sep=""), quote=FALSE, row.names = FALSE)
}

########################running_panel###########################
# 
trees <- list.files("genus_level_10", pattern = ".tre$", full.names = TRUE)

# dir.create("genus_level_10BAMM/result")

for(i in 1:length(trees)){
  BAMM_summ(trees[i])
}