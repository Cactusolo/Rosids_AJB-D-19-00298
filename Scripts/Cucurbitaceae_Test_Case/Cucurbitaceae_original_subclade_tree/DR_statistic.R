# A script to calculate DR statistics from Jetz et al. (2012)
rm(list=ls())
library("ape")
library("phytools")

DR_statistic <- function(tree, return.mean = FALSE){
  rootnode <- length(tree$tip.label) + 1
  sprates <- numeric(length(tree$tip.label))
  for (i in 1:length(sprates)){
    node <- i
    index <- 1
    qx <- 0
    while (node != rootnode){
      el <- tree$edge.length[tree$edge[,2] == node]
      node <- tree$edge[,1][tree$edge[,2] == node]			
      qx <- qx + el* (1 / 2^(index-1))			
      index <- index + 1
    }
    sprates[i] <- 1/qx
  }
  if (return.mean){
    return(mean(sprates))		
  }else{
    names(sprates) <- tree$tip.label
    return(sprates)
  }
}

##############################ruuning panel#############################################
files <- list.files("Cucurbitaceae_5g", pattern = ".tre", full.names = TRUE)

for (i in 1:length(files)) {
  tree <- read.tree(files[i])	
  if(is.ultrametric(tree)){
    print("TRUE")
  }else{
    tree <- force.ultrametric(tree, method="extend")
  }
  
  DR <- DR_statistic(tree)
  
  file=paste0("Cucurbitaceae_5g/", basename(files[i]), "_DR.csv", sep="")
  
  cat("Tiplabels,DRrate\n", file = file)
  write.table(paste0(names(DR), ",", DR, sep=""), file=file,  row.names=FALSE, col.names=FALSE, append=TRUE)
}

#########################Mean_DR#####################################
file <- "Cucurbitaceae_5g/MeanDR_Cucurbitaceae_5g.tre.csv"
cat("tree,MeanDRrate\n", file = file)

for (i in 1:length(files)) {
  tree <- read.tree(files[i])	
  if(!is.ultrametric(tree)){
    tree <- force.ultrametric(tree, method="extend")
  }
  
  DR <- DR_statistic(tree, return.mean = TRUE)
  
  write.table(paste0(basename(files[i]), ",", DR, sep=""), file=file,  row.names=FALSE, col.names=FALSE, append=TRUE)
}
