rm(list=ls())
library("dplyr")

# 9k-tip tree
g4 <- read.csv("result/RPANDA_model_4g.csv", header=TRUE)

rate_PB_4g <- g4[grep(".d0", g4$Model),]

write.csv(rate_PB_4g, "result/RPANDA_PB_model_4g.csv", row.names = F, quote = F)

# 20k-tip tree
g5 <- read.csv("result/RPANDA_model_5g.csv", header=TRUE)

rate_PB_5g <- g5[grep(".d0", g5$Model),]

write.csv(rate_PB_5g, "result/RPANDA_PB_model_5g.csv", row.names = F, quote = F)

# 100k-tip tree

otl <- read.csv("result/RPANDA_model_otl.csv", header=TRUE)

rate_PB_otl <- otl[grep(".d0", otl$Model),]

write.csv(rate_PB_otl, "result/RPANDA_PB_model_otl.csv", row.names = F, quote = F)
