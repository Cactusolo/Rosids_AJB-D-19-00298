library("BAMMtools")
library("ape")
library("phytools")
#dir.create("BAMM_Priors")
  tryCatch({
  name <- "Cucurbitaceae_5g_family"
  tree <- read.tree("Cucurbitaceae_5g.tre")
  setBAMMpriors(tree, total.taxa = 1223, outfile = paste0(name, "_Priors.txt", sep=""))
  fraction <- length(tree$tip.label)/1223
  cat(paste0("fraction = ", fraction, sep=""), sep="\n", file=paste0(name, "_Priors.txt", sep=""), append=TRUE)
  })
