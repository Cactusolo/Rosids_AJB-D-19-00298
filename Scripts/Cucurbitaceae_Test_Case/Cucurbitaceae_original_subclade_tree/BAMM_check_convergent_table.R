library("BAMMtools")
library("coda")

cat("Name,ES_N_shift, ES_logLik\n", file="Cucurbitaceae_5g/Run_family/Cucurbitaceae_5g_family_table.csv")
mcmc.tmp <- read.csv("Cucurbitaceae_5g/Run_family/Cucurbitaceae_5g_family.tre_mcmc_out_1.txt", header=T)
burnstart <- floor(0.1 * nrow(mcmc.tmp))
postburn <- mcmc.tmp[burnstart:nrow(mcmc.tmp), ] 
ES_N_shift <- as.list(effectiveSize(postburn$N_shift))$var1 
ES_logLik <- as.list(effectiveSize(postburn$logLik))$var1

table <- cbind.data.frame("Cucurbitaceae_5g_family", ES_N_shift,ES_logLik)

#names(table) <- c("Order", "ES_N_shift", "ES_logLik")
write.table(table, sep=",", "Cucurbitaceae_5g/Run_family/Cucurbitaceae_5g_family_table.csv", row.names=FALSE, append=TRUE)
