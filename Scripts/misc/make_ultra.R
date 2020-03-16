library("ape")
library("phytools")

file <- list.files(".", pattern="_ultramatric_extend.tre", full.names=TRUE)

clade <- unlist(strsplit(basename(file), split="_"))[1]

tree <- read.tree(file)

if(sum(tree$edge.length==0) >0){
tree$edge.length[which(tree$edge.length==0)] <- 0.1
tree2 <- force.ultrametric(tree, method="extend")
write.tree(tree2, paste0(clade, "_ultrametric_extend.tre", sep=""))
}