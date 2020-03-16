rm(list=ls())

library("BAMMtools")
library("phytools")

#library("phangorn")
tree <- read.tree("./data/rosids_otl.tre")

is.ultrametric(tree)

get_crown_age <- function(phy, MRCA_file){
  
  tree <- ladderize(read.tree(phy))
  Rank <- read.csv(MRCA_file, header=F)
  Rank <- as.data.frame(Rank)
  names(Rank) <- c("Rank", "Tip1", "Tips2")
  
  Date <- branching.times(tree)
  N <- dim(Rank)[1]
  result <- matrix("", nrow=N, ncol=3)
  
  for (i in 1:N){
    rank <- as.character(Rank[i,]$Rank)
    t1 <- as.character(Rank[i,]$Tip1)
    t2 <- as.character(Rank[i,]$Tips2)
    Age <- unlist(Date[as.character(getmrca(tree, t1, t2))])[[1]]
    Node <- names(unlist(Date[as.character(getmrca(tree, t1, t2))]))
    result[i,] <- cbind(rank, Node, Age)
    
  }
  #return(result)
  results <- as.data.frame(result)
  names(results) <- c("Rank", "Node_ID", "Age")
  write.csv(results, "treePL_rosids_4g_age_summary.csv")
}

get_crown_age("rosidated_4g_treePL_final_ultrametric.tre", "rosids_4g_MRCA.txt")


