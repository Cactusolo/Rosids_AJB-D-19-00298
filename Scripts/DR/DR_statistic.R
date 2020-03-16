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

dataset <- c("4g", "5g", "otl")
i <- 3
for (i in 1:length(dataset)) {
  tree <- read.tree(paste0("./data/rosids_", dataset[i], ".tre", sep=""))	
  if(is.ultrametric(tree)){
    print("TRUE")
  }else{
    tree <- force.ultrametric(tree, method="extend")
  }
  DR <- DR_statistic(tree)
  write.csv(paste0(names(DR), ",", DR, sep=""), file=paste0("rosids_", dataset[i], "tip_DR.csv", sep=""), row.names = FALSE)
}

for (i in 1:length(dataset)) {
  tree <- read.tree(paste0("./data/rosids_", dataset[i], ".tre", sep=""))	
  if(is.ultrametric(tree)){
    print("TRUE")
  }else{
    tree <- force.ultrametric(tree, method="extend")
  }
  DR <- DR_statistic(tree, return.mean = TRUE)
  print(paste0(dataset[i], ",", DR))
}


###################################
tree <- read.tree("./data/CN_US_speciesname_BR_addJul192019_ad.tre")	
 if(is.ultrametric(tree)){
   print("TRUE")
 }else{
   tree <- force.ultrametric(tree, method="extend")
 }

DR <- DR_statistic(tree)

write.csv(paste0(names(DR), ",", DR, sep=""), file="CN_US_speciesname_BR_addJul192019_ed_tip_DR.csv", row.names = FALSE, quote = FALSE)

genera <- unique(sort(sapply(strsplit(tree$tip.label, split="_"), "[", 1)))

for(i in 1:length(genera)){
  ii<-grep(genera[i],tree$tip.label)
  ca<-if(length(ii)>1) 
    findMRCA(tree,tree$tip.label[ii]) else ii
  tree<-paintSubTree(tree,ca,state=as.character(i),
                             anc.state="0",stem=TRUE)
}

#The following is a trick to remove map segments of zero length:
tol<-max(nodeHeights(tree))*1e-12
tree$maps<-lapply(tree$maps, function(x,tol) 
  if(length(x)>1) x[-which(x<tol)] else x,tol=tol)


cols<-setNames(c("grey",rainbow(length(genera))),
               0:length(genera))

plot.phylo(ladderize(tree), type="fan", edge.width = 0.5, show.tip.label = F, edge.color=cols)


plot(species.tree,fsize=0.7,colors=cols,ftype="i",split.vertical=TRUE,
     lwd=3,xlim=c(-24,120))