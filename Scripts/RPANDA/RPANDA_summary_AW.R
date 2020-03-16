rm(list=ls())
library("dplyr")
library("tidyverse")
# table <- read_csv("result/RPANDA_model_4g.csv")

# defined a function for caculate AkaikeWeight
AKW <- function(x){
  Delta.AIC <- x -min(x)
  AkaikeWeight <- BMhyd::AkaikeWeight(Delta.AIC)
  return(AkaikeWeight)
}

#defined a function to read a dataset, and output a table with AkaikeWeight and best model based on AkaikeWeight
sum_result <- function(dataset){
  
  table <- read_csv(paste0("result/RPANDA_model_", dataset, ".csv", sep=""))
  
  table.new <- table %>% group_by(Clade) %>% mutate(AW=AICc) %>% mutate_at("AW", AKW)
  
  write.csv(table.new, paste0("RPANDA_model_", dataset, "_17_order_Rate_AkaikeWeight.csv", sep=""), row.names = FALSE)
  
  sum_result <- table %>% group_by(Clade) %>% mutate(AW=AICc) %>% mutate_at("AW", AKW) %>%
    filter(AW==max(AW))
  
  write.csv(sum_result, paste0("RPANDA_Best_model_", dataset, "_17_order_Rate_AkaikeWeight.csv", sep=""), row.names = FALSE)
}

#apply the function for three datasets
sum_result("4g")
sum_result("5g")
sum_result("otl")

####################whole_tree_summ####################
# files <- list.files("result/Whole_tree", pattern = ".csv", full.names = TRUE)

sum_result2 <- function(dataset){
  
  table <- read_csv(paste0("result/Whole_tree/RPANDA_model_", dataset, ".csv", sep=""))
  
  table.new <- table %>% group_by(Clade) %>% mutate(AW=AICc) %>% mutate_at("AW", AKW)
  
  write.csv(table.new, paste0("result/Whole_tree/RPANDA_model_", dataset, "_Rate_AkaikeWeight.csv", sep=""), row.names = FALSE)
  
  sum_result <- table %>% group_by(Clade) %>% mutate(AW=AICc) %>% mutate_at("AW", AKW) %>%
    filter(AW==max(AW))
  
  write.csv(sum_result, paste0("result/Whole_tree/RPANDA_best_model_", dataset, "_Rate_AkaikeWeight.csv", sep=""), row.names = FALSE)
}

sum_result2("4g")
sum_result2("5g")
sum_result2("otl")

###############
model <- read_csv("RPANDA_sum_plots/RPANDA_17_order_model_AW.csv")

names(model)[4] <- "AkaikeWeight"

dd <- model %>%  group_by(Model, dataset) %>% summarise(count=n()) %>% arrange(desc(count))


#################40tree_AW###########

model.40 <- read_csv("../family_random_drop/RPANDA_40/family_random_drop_tip_RPADNA_model_md.csv")

table.new <- model.40 %>% group_by(Trees) %>% mutate(AW=AICc) %>% mutate_at("AW", AKW)
write.csv(table.new, "../family_random_drop/RPANDA_40/family_random_droptip_RPADNA_model_AW.csv", row.names = FALSE)
sum_result <- table.new %>% filter(AW==max(AW))
write.csv(sum_result, "../family_random_drop/RPANDA_40/family_random_droptip_RPADNA_best_model_AW.csv", row.names = FALSE)

###########family and genus##########
model.fam <- read_csv("../family_random_drop/Cucurbitaceae_5g_family_level/RPANDA/Cucurbitaceae_5g_RPADNA_model.csv")
table.new <- model.fam %>% group_by(Clade) %>% mutate(AW=AICc) %>% mutate_at("AW", AKW)
write.csv(table.new, "../family_random_drop/Cucurbitaceae_5g_family_level/RPANDA/Cucurbitaceae_5g_RPADNA_model_AW.csv", row.names = FALSE)
sum_result <- table.new %>% filter(AW==max(AW))
write.csv(sum_result, "../family_random_drop/Cucurbitaceae_5g_family_level/RPANDA/Cucurbitaceae_5g_RPADNA_best_model_AW.csv", row.names = FALSE)

model.gen <- read_csv("../family_random_drop/Cucurbitaceae_5g_genus_level/Cucurbitaceae_5g_genus_RPADNA_model.csv")
table.new <- model.gen %>% group_by(Clade) %>% mutate(AW=AICc) %>% mutate_at("AW", AKW)
write.csv(table.new, "../family_random_drop/Cucurbitaceae_5g_genus_level/Cucurbitaceae_5g_genus_RPADNA_model_AW.csv", row.names = FALSE)
sum_result <- table.new %>% filter(AW==max(AW))
write.csv(sum_result, "../family_random_drop/Cucurbitaceae_5g_genus_level/Cucurbitaceae_5g_genus_RPADNA_best_model_AW.csv", row.names = FALSE)
