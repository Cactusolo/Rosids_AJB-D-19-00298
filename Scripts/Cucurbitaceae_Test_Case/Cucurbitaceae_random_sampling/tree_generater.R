library("ape")

tree1 <- read.tree("./data/Cucurbitaceae_5g.tre")

rdm_drop_tip <- function(tree, pecentage, rep){
  pp <- as.numeric(pecentage/100)
#calculate how many tips need to drop
  m<-round(pp*length(tree$tip.label))
  for (i in 1:rep){
      rm_tip <- sample(tree$tip.label)[1:m]
      write.csv(rm_tip, paste0("data/Cucurbitaceae_5g_", pecentage, "_", i, "_rm_tip.txt", sep=""), quote = FALSE, row.names = FALSE, col.names = FALSE)
      tree.result<- drop.tip(tree, rm_tip)
      write.tree(tree.result, paste0("data/Cucurbitaceae_5g_", pecentage, "_", i, "_drop.tre", sep=""))
  }
}

rdm_drop_tip(tree1, 10, 10)
rdm_drop_tip(tree1, 30, 10)
rdm_drop_tip(tree1, 50, 10)
rdm_drop_tip(tree1, 75, 10)
