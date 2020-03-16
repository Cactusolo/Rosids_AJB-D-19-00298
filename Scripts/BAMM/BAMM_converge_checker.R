# This R script is usuallt work with the some bash Script
# summarized a table with order, ES_N_shift, and ES_logLik value

library("BAMMtools")
library("coda")

Order <- read.csv("Order", header=F)
Order <- as.character(Order$V1)
#cat("Name,ES_N_shift,ES_logLik\n", file="BAMM_17order_PB_table.csv")

#for (i in 1:length(Order)) {
for (i in c(5,9)) {
	clade <- Order[i]
	mcmc.tmp <- read.csv(paste0("./", clade, "/", clade, "_PB_mcmc_out.txt", sep=""), header=T)
	burnstart <- floor(0.1 * nrow(mcmc.tmp))
	postburn <- mcmc.tmp[burnstart:nrow(mcmc.tmp), ] 
	ES_N_shift <- as.list(effectiveSize(postburn$N_shift))$var1 
	ES_logLik <- as.list(effectiveSize(postburn$logLik))$var1
	cat(paste0(clade,",", ES_N_shift, ",", ES_logLik, sep="\n"), file="BAMM_17order_PB_table.csv", append=TRUE)
}
