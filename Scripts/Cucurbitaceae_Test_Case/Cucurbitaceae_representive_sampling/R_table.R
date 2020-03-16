library("BAMMtools")
library("coda")

file <- system("ls *_mcmc_out_fraction.txt", intern=TRUE)
N=length(file)

cat("Name,ES_N_shift, ES_logLik\n", file="table.csv")

table <- matrix("", nrow=N, ncol=3)

for (i in 1:N) {mcmc.tmp <- read.csv(file[i], header=T)
	burnstart <- floor(0.1 * nrow(mcmc.tmp))
	postburn <- mcmc.tmp[burnstart:nrow(mcmc.tmp), ] 
	ES_N_shift <- as.list(effectiveSize(postburn$N_shift))$var1 
	ES_logLik <- as.list(effectiveSize(postburn$logLik))$var1
	Name <- substr(file[i], 10, nchar(file[i])-17)
	#table[[i]] <- cbind(unlist(strsplit(file[i], "_"))[1], as.list(effectiveSize(postburn$N_shift))$var1, as.list(effectiveSize(postburn$logLik))$var1)
	table[i,] <- c(Name,ES_N_shift,ES_logLik)
}
table <- as.data.frame(table)
names(table) <- NULL
#names(table) <- c("Order", "ES_N_shift", "ES_logLik")
write.table(table, sep=",", "table.csv", row.names=FALSE)
(table)
