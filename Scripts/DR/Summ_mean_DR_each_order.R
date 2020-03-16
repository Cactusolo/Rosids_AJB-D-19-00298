rm(list=ls())

order.list <- c("Brassicales", "Celastrales", "Crossosomatales", "Cucurbitales", "Fabales", "Fagales", "Geraniales", "Huerteales", "Malpighiales", "Malvales", "Myrtales", "Oxalidales", "Picramniales", "Rosales", "Sapindales", "Vitales", "Zygophyllales")

Mean_sum <- function(dataset){
  folder <- paste0("rosid_", dataset, "_clade_DR", sep="")
  file <- paste0(folder, "/Mean_DR_17order_", dataset, ".txt", sep="")
  cat("Clade,MeanDR\n", file = file)
  
  for (i in 1:length(order.list)){
    
    tryCatch({
      Order <- order.list[i]
      #read data
      data <- read.csv(paste(folder, "/rosid_", dataset, "_", Order, "_DR.csv", sep=""))
      #print(Order)
      # mean_rate <- mean(data$DR_rates)
      # write.table(paste0(Order, ",", mean_rate, sep=""), file, row.names=F, col.names=F, append=T)
      print(c(Order, length(data$Tip_lable)))
    })
  } 
}

# Mean_sum("4g")
# Mean_sum("5g")
Mean_sum("otl")
