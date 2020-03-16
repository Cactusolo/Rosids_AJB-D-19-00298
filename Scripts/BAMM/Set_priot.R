library("BAMMtools")
library("ape")
library("phytools")

if (!dir.exists("BAMM_Priors")) {
  dir.create("BAMM_Priors")
}

Info <- read.csv("Order_summary.csv", header=F)
names(Info) <- c("Order", "Tips", "Total_species", "Fraction")

for (i in 1:dim(Info)[1]){
  tryCatch({
  clade<- as.character(Info[i,1])
  tree <- read.tree(paste0(clade, ".tre", sep=""))
  setBAMMpriors(tree, total.taxa = as.numeric(Info[i,3]), outfile = paste0("BAMM_Priors/", clade, "_Priors.txt", sep=""))
  fraction <- length(tree$tip.label)/as.numeric(Info[i,3])
  cat(paste0("fraction = ", fraction, sep=""), sep="\n", file=paste0("BAMM_Priors/", clade, "_Priors.txt", sep=""), append=TRUE)
  })
}
