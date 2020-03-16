rm(list=ls())
library("BAMMtools") 
library("coda")

BAMM_summ <- function(Tree){
  name <- unlist(strsplit(basename(Tree), split="[.]"))[1]
  directory <- "result_40_tree"
  ####evaluate mcmc##############
  mcmc <- read.csv(paste(Tree, "_mcmc_out_cmb.csv", sep=""), header=T)
  
  pdf(paste0(directory, "/", name, "_MCMC_convergent.pdf", sep=""))
  plot(mcmc$logLik ~ mcmc$generation)
  dev.off()
  
  burnstart <- floor(0.1*nrow(mcmc))
  postburn <- mcmc[burnstart:nrow(mcmc), ]#postburn is the generations left after burning
  
  #next caculate the effective sample size (ESS), which should be greater than 200 if our analysis
  # ran long enough
  logLik <- effectiveSize(postburn$logLik) # calculates autocorrelation function
  N_shift <- effectiveSize(postburn$N_shift) #effective sample size on N-shifts
  ESSample <- cbind.data.frame(name, logLik, N_shift)
  file1 <- paste0(directory, "/Cucurbitaceae_5g_40tree_ESS_convergence.txt", sep="")
  cat("Tree_name,LogLik,N_shift\n", file=file1)
  write.table(ESSample, file=file1, row.names=F, col.names=F, append=T, sep=",")
  
  #read tree
  tree <- read.tree(Tree)
  
  #read event data
  edata <- getEventData(tree, paste(Tree, "_event_data_cmb.csv", sep=""), burnin = 0.1)
  
  #tip rates
  TR <- getTipRates(edata, returnNetDiv = FALSE, statistic = "median")
  file2 <- paste0(directory, "/", name, "_BAMM_TipRates.csv", sep="")
  cat("Tip_label,Rate\n", file=file2)
  write.table(TR$lambda.avg, sep=",", file=file2, col.names = FALSE, append = TRUE)
  
  #median speciation rate
  Rate.Matrix <- getRateThroughTimeMatrix(edata)
  Time <- Rate.Matrix$times
  median.rate <- apply(Rate.Matrix$lambda, 2, quantile, c(0.5))
  md.rmat <- cbind.data.frame(Time, median.rate)
  
  write.csv(md.rmat, file=paste0(directory, "/", name, "_BAMM_median_speciation_rates.csv", sep=""), row.names = FALSE)
}


########################running_panel###########################
# dir.create("result_40_tree")


trees <- list.files("BAMM_run/", pattern = ".tre$", full.names = TRUE)

for(i in 1:length(trees)){
  BAMM_summ(trees[i])
  
}
