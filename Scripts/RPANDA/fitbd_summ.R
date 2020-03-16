rm(list=ls())
#library("RPANDA")
#library("ape")
#library("phytools")

######################################

#define a fucntion extract SpeciationRate, model name, and corresponding aicc for given RPANDA model run

read.multi.rpanda <- function(Order, file) {
  Rpanda_run <- readRDS(paste0("result/RPANDA_model_otl_", Order, ".rds", sep=""))
  for (i in 1:length(names(Rpanda_run))){
    #Order <- Order
    model <- names(Rpanda_run[i])
    SpeciationRate <- Rpanda_run[[i]]$lamb_par[1]
    AICC <- Rpanda_run[[i]]$aicc
    write.table(paste0(Order, ",", model, ",", SpeciationRate, ",", AICC, sep=""), file, row.names=F, col.names=F, append=T)
  }
}
  #################running_panel#####################
  
  #order.list <- c("Brassicales", "Celastrales", "Crossosomatales", "Cucurbitales", "Fabales", "Fagales", 
  #                "Geraniales", "Huerteales", "Malpighiales", "Malvales", "Myrtales", "Oxalidales", "Picramniales", "Rosales", 
  #                "Sapindales", "Zygophyllales", "Vitales")
  
  order.list <- c("Brassicales", "Celastrales", "Crossosomatales", "Cucurbitales", "Fabales", "Fagales", "Geraniales", "Huerteales")
  
  file <- "result/RPANDA_model_otl1.txt"
  cat("Clade,Model,lamda,AICc\n", file = file)
  
  for (i in 1:length(order.list)){
    Order <- order.list[i]
    read.multi.rpanda(Order, file)
  }
  
