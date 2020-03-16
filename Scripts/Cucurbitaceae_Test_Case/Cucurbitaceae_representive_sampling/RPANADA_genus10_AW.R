rm(list=ls())
library("dplyr")
library("tidyverse")

# defined a function for caculate AkaikeWeight
AKW <- function(x){
  Delta.AIC <- x -min(x)
  AkaikeWeight <- BMhyd::AkaikeWeight(Delta.AIC)
  return(AkaikeWeight)
}

# dir.create("genus_level_10fitbd/summary")
files <- list.files("genus_level_10fitbd", pattern = ".csv$", full.names = TRUE)

file1 <- "genus_level_10fitbd/summary/genus_level_10RPANDA_All_model_AW.csv"
cat("Trees,Model,lamda,AICc,AkaikeWeight\n", file = file1)
file2 <- "genus_level_10fitbd/summary/genus_level_10RPANDA_best_model_AW.csv"
cat("Trees,Model,lamda,AICc,AkaikeWeight\n", file = file2)

model.each <- setNames(data.frame(matrix(ncol = 5, nrow = 0)), c("Trees", "Model", "lamda", "AICc", "AkaikeWeight"))

for (i in 1:length(files)){
  table <- read_csv(files[i])
  result <- table %>% group_by(Clade) %>% mutate(AW=AICc) %>% mutate_at("AW", AKW)
  name <- gsub("_RPADNA_model.csv", "", basename(files[i]))
  write.csv(result, paste0("genus_level_10fitbd/summary/", name, "RPANDA_Rate_AkaikeWeight.csv", sep=""), quote=FALSE, row.names = FALSE)
  sum_result <- result %>% filter(AW==max(AW))
  model.each[i, ] <- sum_result
  write.table(sum_result, sep=",", file=file1, row.names=F, col.names=F, quote=FALSE, append=T)
}

Best <- model.each%>% select(Trees, Model, lamda, AICc) %>% mutate(AW=AICc) %>% mutate_at("AW", AKW) %>% filter(AW==max(AW))

write.table(Best, sep=",", file=file2, row.names=F, col.names=F, quote=FALSE, append=T)
