#this srcipt is used to feed a buntch of dropped tip trees to 9 bd RPANDA models

rm(list=ls())
library("RPANDA")
library("ape")
library("phytools")

######################################

#######RPANDA_Models##################

# define functions for time, lmbda, and mu
# constant rate
lambda.cst <- function(t,y){y[1]} #t=time, y=lambda (λ)
mu.cst <- function(t,y){y[1]} #t=time, y=mu (u)
# mu fixed to 0 (no extinction)
mu.0 <- function(t,y){0}

#variable rate
lambda.var <- function(t,y){y[1]*exp(y[2]*t)}
mu.var <- function(t,y){y[1]*exp(y[2]*t)}

#variable linear rate
lambda.l <- function(t,y){y[1] + y[2]*t}
mu.l <- function(t,y){y[1] + y[2]*t}

#rate varying as an exponetial function of temperature (x) and/or time (t)
#lambda is varying as an exponetial function of temperature (x)
lambda.x <-function(t,x,y){y[1] * exp(y[2] * x)}

#lambda is varying as exponential, function of time - no temperature dependency
lambda.t <- function(t,x,y){y[1] * exp(y[2] * t)} # should the same as lambda.var

#define a fucntion evaluate all the models for given tree and par

fit.multi.rpanda <- function(tree, Order, file) {
  #initial values
  par <- list(c(0.09), c(0.09,0.3), c(0.05, 0.01), c(0.05, 0.01), c(0.05, 0.01, 0.1), c(0.05, 0.01, 0.5), c(0.05, 0.005, 0.01), 
              c(0.05, 0.005, 0.001), c(0.05, 0.01, 0.005, 0.0001))
  # caculate crown age
  tot_time <- max(node.age(tree)$ages)
  
  # caculate fraction
  # Total.tree <- read.tree(paste("data/otl/", Order, "_otl.tre", sep=""))
  # Total.tree2 <- read.tree(paste("whole_tree/rosids_", Order, ".tre", sep=""))
  fraction <- length(tree$tip.label)/1223
  
  
  # 1) B constant
  model <- "bcst.d0"
  bcst.d0 <- fit_bd(tree, tot_time, f.lamb=lambda.cst, f.mu=mu.0, lamb_par=par[[1]][1], mu_par=c(), f=fraction, cst.lamb=TRUE, fix.mu=TRUE, cond="crown", dt=1e-3)
  write.table(paste0(Order, ",", model, ",", bcst.d0$lamb_par[1], ",", bcst.d0$aicc, sep=""), file, row.names=F, col.names=F, quote = FALSE, append=T)
  
  # 2) BD constant
  model <- "bcst.dcst"
  bcst.dcst <- fit_bd(tree, tot_time, f.lamb=lambda.cst, f.mu=mu.cst, lamb_par=par[[2]][1], mu_par=par[[2]][2], cst.lamb=TRUE, cst.mu=TRUE, cond="crown", f=fraction, dt=1e-3)
  write.table(paste0(Order, ",", model, ",", bcst.dcst$lamb_par[1], ",", bcst.dcst$aicc, sep=""), file, row.names=F, col.names=F, quote = FALSE, append=T)
  
  # 3) B variable E ("B exponential")
  model <- "bvar.d0"
  bvar.d0 <- fit_bd(tree, tot_time, f.lamb=lambda.var, f.mu=mu.0, lamb_par=par[[3]][c(1,2)], mu_par=c(), expo.lamb=TRUE, fix.mu=TRUE, cond="crown", f=fraction, dt=1e-3)
  lambda <- bvar.d0$lamb_par[1]*exp(bvar.d0$lamb_par[2]*0)
  write.table(paste0(Order, ",", model, ",", bvar.d0$lamb_par[1], ",", bvar.d0$aicc, sep=""), file, row.names=F, col.names=F, quote = FALSE, append=T)
  
  # 4) B variable L ("B linear")
  model <- "bvar.l.d0"
  bvar.l.d0 <- fit_bd(tree, tot_time, f.lamb=lambda.l, f.mu=mu.0, lamb_par=par[[4]][c(1,2)], mu_par=c(), fix.mu=TRUE, f=fraction, cond="crown", dt=1e-3)
  write.table(paste0(Order, ",", model, ",", bvar.l.d0$lamb_par[1], ",", bvar.l.d0$aicc, sep=""), file, row.names=F, col.names=F, quote = FALSE, append=T)
  
  # 5) B variable E, D constant ("B exponential, D constant")
  model <- "bvar.dcst"
  bvar.dcst <- fit_bd(tree, tot_time, f.lamb=lambda.var, f.mu=mu.cst, lamb_par=par[[5]][c(1,2)], mu_par=par[[5]][3], expo.lamb=TRUE, cst.mu=TRUE,cond="crown", f=fraction, dt=1e-3)
  write.table(paste0(Order, ",", model, ",", bvar.dcst$lamb_par[1], ",", bvar.dcst$aicc, sep=""), file, row.names=F, col.names=F, quote = FALSE, append=T)
  
  # 6) B variable L, D constant ("B linear, D constant")
  model <- "bvar.l.dcst"
  bvar.l.dcst <- fit_bd(tree, tot_time, f.lamb=lambda.l, f.mu=mu.cst, lamb_par=par[[6]][c(1,2)],mu_par=par[[6]][3], cst.mu=TRUE, cond="crown", f=fraction, dt=1e-3)
  write.table(paste0(Order, ",", model, ",", bvar.l.dcst$lamb_par[1], ",", bvar.l.dcst$aicc, sep=""), file, row.names=F, col.names=F, quote = FALSE, append=T)
  
  # 7) B constant, D variable E ("B constant, D exponential")
  model <- "bcst.dvar"
  bcst.dvar <- fit_bd(tree, tot_time, f.lamb=lambda.cst, f.mu=mu.var, lamb_par=par[[7]][1], mu_par=par[[7]][c(2,3)], cst.lamb=TRUE, expo.mu=TRUE, cond="crown", f=fraction, dt=1e-3)
  write.table(paste0(Order, ",", model, ",", bcst.dvar$lamb_par[1], ",", bcst.dvar$aicc, sep=""), file, row.names=F, col.names=F, quote = FALSE, append=T)
  
  # 8) B constant, D variable L ("B constant, D linear")
  model <- "bcst.dvar.l"
  bcst.dvar.l <- fit_bd(tree, tot_time, f.lamb=lambda.cst, f.mu=mu.l, lamb_par=par[[8]][1], mu_par=par[[8]][c(2,3)], cst.lamb=TRUE, cond="crown", f=fraction, dt=1e-3)
  write.table(paste0(Order, ",", model, ",", bcst.dvar.l$lamb_par[1], ",", bcst.dvar.l$aicc, sep=""), file, row.names=F, col.names=F, quote = FALSE, append=T)
  
  # 9) B variable, D variable
  #new.par <- list(c(0.05, 0.01, 0.005, 0.0001))
  model <- "bvar.dvar"
  bvar.dvar <- fit_bd(tree, tot_time, f.lamb=lambda.var, f.mu=mu.var, lamb_par=par[[9]][c(1,2)], mu_par=par[[9]][c(3,4)], expo.lamb=TRUE, expo.mu=TRUE, cond="crown", f=fraction, dt=1e-3)
  write.table(paste0(Order, ",", model, ",", bvar.dvar$lamb_par[1], ",", bvar.dvar$aicc, sep=""), file, row.names=F, col.names=F, quote = FALSE, append=T)
  
  #return results as a list
  result <- (list("bcstd0"=bcst.d0, "bcst.dcst"=bcst.dcst, "bvar.d0"=bvar.d0, "bvar.l.d0"=bvar.l.d0, "bvar.dcst"=bvar.dcst, "bvar.l.dcst"=bvar.l.dcst, "bcst.dvar"=bcst.dvar, "bcst.dvar.l"=bcst.dvar.l, "bvar.dvar"=bvar.dvar))
  
  # newname <- unlist(strsplit(file, split="[.]"))[1]
  saveRDS(result, file=paste0("genus_level_10fitbd/", Order, ".rds", sep=""))

}

#################running_panel#####################

# dir.create("genus_level_10fitbd")

files <- list.files("genus_level_10", pattern = ".tre$", full.names = TRUE)

for (i in 1:length(files)){
  
  tryCatch({
    
    Order <- substr(basename(files[i]), 1, nchar(basename(files[i]))-4)
    file <- paste0("genus_level_10fitbd/", Order, "_RPADNA_model.csv", sep="")
    cat("Clade,Model,lamda,AICc\n", file = file)
    #read tree
    tree <- read.tree(files[i])
    if(!is.ultrametric(tree)){
      tree <- force.ultrametric(tree, method="extend")
    }
    print(Order)
    fit.multi.rpanda(tree, Order, file)
    
  })
} 
