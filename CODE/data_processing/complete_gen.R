# This script generates the complete_data.csv
# This dataset contains all 22 predictors and outcome

rm(list = ls())
graphics.off()

library(dplyr)
library(tidyverse)
library(foreign)

#setting working directory
setwd('/Users/aa/Downloads/cdc_data')

############################
####BMX file batch read#####
############################

filenames = dir("BMX_2005_2018")
BMX_2005_2018 = data.frame()
for (i in filenames) {
  path = paste0("BMX_2005_2018", "/", i) #construct file path
  tempdata = read.xport(path) %>%
    select(SEQN, BMXBMI)
  BMX_2005_2018 = rbind(BMX_2005_2018, tempdata)
}
write.csv(BMX_2005_2018, "BMX_2005_2018.csv", row.names = FALSE)


############################
####BPQ file batch read#####
############################

filenames = dir("BPQ_2005_2018")
BPQ_2005_2018 = data.frame()
for (i in filenames) {
  path = paste0("BPQ_2005_2018", "/", i) #construct file path
  tempdata = read.xport(path) %>%
    select(SEQN, BPQ020, BPQ080)
  BPQ_2005_2018 = rbind(BPQ_2005_2018, tempdata)
}
write.csv(BPQ_2005_2018, "BPQ_2005_2018.csv", row.names = FALSE)


############################
####DEMO file batch read#####
############################

filenames = dir("DEMO_2005_2018")
DEMO_2005_2018 = data.frame()
for (i in filenames) {
  path = paste0("DEMO_2005_2018", "/", i) # construct file path
  tempdata = read.xport(path) %>%
    select(SEQN,
           RIDAGEYR,
           INDFMPIR,
           DMDEDUC2,
           DMDMARTL,
           RIAGENDR,
           RIDRETH1,
           DMDHHSIZ)
  DEMO_2005_2018 = rbind(DEMO_2005_2018, tempdata)
}
write.csv(DEMO_2005_2018, "DEMO_2005_2018.csv", row.names = FALSE)


############################
####SMQ file batch read#####
############################

filenames = dir("SMQ_2005_2018")
SMQ_2005_2018 = data.frame()
for (i in filenames) {
  path = paste0("SMQ_2005_2018", "/", i) # construct file path
  tempdata = read.xport(path) %>%
    select(SEQN, SMQ020)
  SMQ_2005_2018 = rbind(SMQ_2005_2018, tempdata)
}
write.csv(SMQ_2005_2018, "SMQ_2005_2018.csv", row.names = FALSE)



############################
####OCQ file batch read#####
############################


filenames = dir("OCQ_2005_2018")
OCQ_2005_2018 = data.frame()
for (i in filenames) {
  path = paste0("OCQ_2005_2018", "/", i) # construct file path
  tempdata = read.xport(path) %>%
    select(SEQN, OCD150)
  OCQ_2005_2018 = rbind(OCQ_2005_2018, tempdata)
}
write.csv(OCQ_2005_2018, "OCQ_2005_2018.csv", row.names = FALSE)


############################
####MCQ file batch read#####
############################

filenames = dir("MCQ_2005_2018")
MCQ_2005_2018 = data.frame()
for (i in filenames) {
  path = paste0("MCQ_2005_2018", "/", i) # construct file path
  tempdata = read.xport(path) %>%
    select(SEQN, MCQ010)
  MCQ_2005_2018 = rbind(MCQ_2005_2018, tempdata)
}
write.csv(MCQ_2005_2018, "MCQ_2005_2018.csv", row.names = FALSE)


############################
####DIQ file batch read#####
############################


filenames = dir("DIQ_2005_2018")
DIQ_2005_2018 = data.frame()
for (i in filenames) {
  path = paste0("DIQ_2005_2018", "/", i) # construct file path
  tempdata = read.xport(path) %>%
    select(SEQN, DIQ010)
  DIQ_2005_2018 = rbind(DIQ_2005_2018, tempdata)
}
write.csv(DIQ_2005_2018, "DIQ_2005_2018.csv", row.names = FALSE)

############################
####DR1TOT file batch read##
############################

filenames = dir("DR1TOT_2005_2018")
DR1TOT_2005_2018 = data.frame()
for (i in filenames) {
  path = paste0("DR1TOT_2005_2018", "/", i) # construct file path
  tempdata = read.xport(path) %>%
    select(SEQN,
           DR1TCARB,
           DR1TPROT,
           DR1TPFAT,
           DR1TFA,
           DR1TIRON)
  DR1TOT_2005_2018 = rbind(DR1TOT_2005_2018, tempdata)
}
write.csv(DR1TOT_2005_2018, "DR1TOT_2005_2018.csv", row.names = FALSE)


############################
######HIQ file batch read###
############################

filenames = dir("HIQ_2005_2018")
HIQ_2005_2018 = data.frame()
for (i in filenames) {
  path = paste0("HIQ_2005_2018", "/", i) # construct file path
  tempdata = read.xport(path) %>%
    select(SEQN, HIQ011)
  HIQ_2005_2018 = rbind(HIQ_2005_2018, tempdata)
}
write.csv(HIQ_2005_2018, "HIQ_2005_2018.csv", row.names = FALSE)


#############################
#####PAQ file batch read#####
#############################

filenames = dir("PAQ_2005_2018")
PAQ_2005_2018 = data.frame()

lookup = c("PAQ605" = "PAD200")

for (i in filenames) {
  path = paste0("PAQ_2005_2018", "/", i) # construct file path
  tempdata = read.xport(path) %>%
    rename_with(.fn = ~ lookup[.x], .cols = intersect(names(.), names(lookup))) %>%
    select(SEQN, PAD200)
  PAQ_2005_2018 = rbind(PAQ_2005_2018, tempdata)
}

write.csv(PAQ_2005_2018, "PAQ_2005_2018.csv", row.names = FALSE)


############################
####HSQ file batch read#####
############################

filenames = dir("HSQ_2005_2018")
HSQ_2005_2018 = data.frame()

for (i in filenames) {
  path = paste0("HSQ_2005_2018", "/", i) # construct file path
  tempdata = read.xport(path) %>%
    select(SEQN, HSD010)
  HSQ_2005_2018 = rbind(HSQ_2005_2018, tempdata)
}

write.csv(HSQ_2005_2018, "HSQ_2005_2018.csv", row.names = FALSE)


######################
#### combine data ####
######################

dataset = c("BMX",
            "BPQ",
            "DEMO",
            "DIQ",
            "DR1TOT",
            "HIQ",
            "MCQ",
            "OCQ",
            "SMQ",
            "PAQ",
            "HSQ")

for (i in 1:length(dataset)) {
  data = read.csv(paste0(dataset[i], "_2005_2018.csv"))
  if (i == 1) {
    completedata = data
  } else{
    completedata = merge(completedata, data, by = "SEQN")
  }
}
data = read.csv(paste0("DPQ_2005_2018_w_level.csv"))
completedata = merge(completedata, data, by = "SEQN")
completedata = na.omit(completedata)


#############################
#### filter invalid data ####
#############################
dep_data = read.csv("psychic-adventure/CODE/outcome/DPQ_2005_2018_w_level.csv")
dep_data = dep_data[, -2]
completedata = merge(completedata, dep_data, by = "SEQN")
col_name = c(
  "BPQ020",
  "BPQ080",
  "DMDEDUC2",
  "DMDMARTL",
  "DIQ010",
  "HIQ011",
  "MCQ010",
  "OCD150",
  "SMQ020",
  "PAD200",
  "HSD010"
)
rule_out = list(c(9),
                c(7, 9),
                c(7, 9),
                c(77, 99),
                c(9),
                c(7, 9),
                c(9),
                c(7, 9),
                c(7, 9),
                c(3, 9),
                c(9))
for (i in 1:length(col_name)) {
  completedata = completedata[-which(completedata[, col_name[i]] %in% rule_out[[i]]), ]
}
completedata$dep_level = as.factor(completedata$dep_level)
data = completedata
save(data, file = "complete_data.rdata")
