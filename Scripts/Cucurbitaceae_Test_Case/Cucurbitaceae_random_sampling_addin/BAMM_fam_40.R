rm(list=ls())
library("BAMMtools") 
library("coda")

BAMM_summ <- function(Tree){
  name <- gsub("bub.tre", "", basename(Tree))
  directory <- "Cucurbitaceae_5g_family_level/Fam_randomdrop_addin_40/BAMM_fam_40/"
  ####evaluate mcmc##############
  mcmc <- read.csv(paste(gsub("bub.tre", "", Tree), "_mcmc_out_cmb.csv", sep=""), header=T)
  
  pdf(paste0(directory, "result/", name, "_MCMC_convergent.pdf", sep=""))
  plot(mcmc$logLik ~ mcmc$generation)
  dev.off()
  
  burnstart <- floor(0.1*nrow(mcmc))
  postburn <- mcmc[burnstart:nrow(mcmc), ]#postburn is the generations left after burning
  
  #next caculate the effective sample size (ESS), which should be greater than 200 if our analysis
  # ran long enough
  logLik <- effectiveSize(postburn$logLik) # calculates autocorrelation function
  N_shift <- effectiveSize(postburn$N_shift) #effective sample size on N-shifts
  ESSample <- cbind.data.frame(name, logLik, N_shift)
  file1 <- paste0(directory, "result/Cucurbitaceae_5g_drop_addin_40tree_ESS_convergence.txt", sep="")
  write.table(ESSample, file=file1, row.names=FALSE, col.names=FALSE, quote=FALSE, append=TRUE, sep=",")
  
  #read tree
  tree <- read.tree(Tree)
  
  #read event data
  edata <- getEventData(tree, paste(gsub("bub.tre", "", Tree), "_event_data_cmb.csv", sep=""), burnin = 0.1)
  
  #tip rates
  TR <- getTipRates(edata, returnNetDiv = FALSE, statistic = "median")
  file2 <- paste0(directory, "result/", name, "_BAMM_TipRates.csv", sep="")
  cat("Tip_label,Rate\n", file=file2)
  write.table(TR$lambda.avg, sep=",", file=file2, col.names = FALSE, append = TRUE, quote=FALSE)
 
  #median speciation rate
  Rate.Matrix <- getRateThroughTimeMatrix(edata)
  Time <- Rate.Matrix$times
  median.rate <- apply(Rate.Matrix$lambda, 2, quantile, c(0.5))
  md.rmat <- cbind.data.frame(Time, median.rate)
  
  write.csv(md.rmat, file=paste0(directory, "result/", name, "_BAMM_median_speciation_rates.csv", sep=""), row.names = FALSE)
}

########################running_panel###########################
# dir.create("result_40_tree")

trees <- list.files("Cucurbitaceae_5g_family_level/Fam_randomdrop_addin_40/BAMM_fam_40/data", pattern = ".tre$", full.names = TRUE)

file1 <- "Cucurbitaceae_5g_family_level/Fam_randomdrop_addin_40/BAMM_fam_40/result/Cucurbitaceae_5g_40tree_ESS_convergence.txt"
cat("Tree_name,LogLik,N_shift\n", file=file1)

for(i in 1:length(trees)){
  BAMM_summ(trees[i])
  
}
