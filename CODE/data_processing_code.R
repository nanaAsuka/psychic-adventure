rm(list=ls())
graphics.off()

library(tidyverse)
library(foreign)

#setting working directory
setwd('/Users/aa/Downloads/cdc_data')

############################ BMX file batch read
filenames <- dir("BMX_2005_2018")
BMX_2005_2018 <- data.frame()
for (i in filenames){
  path <- paste0("BMX_2005_2018","/",i) #construct file path
  tempdata <- read.xport(path) %>%
    select(SEQN,BMXBMI)
  BMX_2005_2018 <- rbind(BMX_2005_2018,tempdata)
}
write.csv(BMX_2005_2018, "BMX_2005_2018.csv",row.names = FALSE)

############################ BPQ file batch read
filenames <- dir("BPQ_2005_2018")
BPQ_2005_2018 <- data.frame()
for (i in filenames){
  path <- paste0("BPQ_2005_2018","/",i) #construct file path
  tempdata <- read.xport(path) %>%
    select(SEQN,BPQ020,BPQ080)
  BPQ_2005_2018 <- rbind(BPQ_2005_2018,tempdata)
}
write.csv(BPQ_2005_2018, "BPQ_2005_2018.csv",row.names = FALSE)

############################ DEMO file batch read
filenames <- dir("DEMO_2005_2018")
DEMO_2005_2018 <- data.frame()
for (i in filenames){
  path <- paste0("DEMO_2005_2018","/",i) # construct file path
  tempdata <- read.xport(path) %>%
    select(SEQN,RIDAGEYR,INDFMPIR,DMDEDUC2,DMDMARTL,RIAGENDR,RIDRETH1)
  DEMO_2005_2018 <- rbind(DEMO_2005_2018,tempdata)
}
write.csv(DEMO_2005_2018, "DEMO_2005_2018.csv",row.names = FALSE)

############################ SMQ file batch read
filenames <- dir("SMQ_2005_2018")
SMQ_2005_2018 <- data.frame()
for (i in filenames){
  path <- paste0("SMQ_2005_2018","/",i) # construct file path
  tempdata <- read.xport(path) %>%
    select(SEQN,SMQ020)
  SMQ_2005_2018 <- rbind(SMQ_2005_2018,tempdata)
}
write.csv(SMQ_2005_2018, "SMQ_2005_2018.csv",row.names = FALSE)


############################ OCQ file batch read
filenames <- dir("OCQ_2005_2018")
OCQ_2005_2018 <- data.frame()
for (i in filenames){
  path <- paste0("OCQ_2005_2018","/",i) # construct file path
  tempdata <- read.xport(path) %>%
    select(SEQN,OCD150)
  OCQ_2005_2018 <- rbind(OCQ_2005_2018,tempdata)
}
write.csv(OCQ_2005_2018, "OCQ_2005_2018.csv",row.names = FALSE)


############################ MCQ file batch read
filenames <- dir("MCQ_2005_2018")
MCQ_2005_2018 <- data.frame()
for (i in filenames){
  path <- paste0("MCQ_2005_2018","/",i) # construct file path
  tempdata <- read.xport(path) %>%
    select(SEQN,MCQ010)
  MCQ_2005_2018 <- rbind(MCQ_2005_2018,tempdata)
}
write.csv(MCQ_2005_2018, "MCQ_2005_2018.csv",row.names = FALSE)


############################ DIQ file batch read
filenames <- dir("DIQ_2005_2018")
DIQ_2005_2018 <- data.frame()
for (i in filenames){
  path <- paste0("DIQ_2005_2018","/",i) # construct file path
  tempdata <- read.xport(path) %>%
    select(SEQN, DIQ010)
  DIQ_2005_2018 <- rbind(DIQ_2005_2018,tempdata)
}
write.csv(DIQ_2005_2018, "DIQ_2005_2018.csv",row.names = FALSE)

############################ DR1TOT file batch read
filenames <- dir("DR1TOT_2005_2018")
DR1TOT_2005_2018 <- data.frame()
for (i in filenames){
  path <- paste0("DR1TOT_2005_2018","/",i) # construct file path
  tempdata <- read.xport(path) %>%
    select(SEQN,
           DR1TCARB,
           DR1TPROT,
           DR1TPFAT,
           DR1TFA,
           DR1TIRON)
  DR1TOT_2005_2018 <- rbind(DR1TOT_2005_2018,tempdata)
}
write.csv(DR1TOT_2005_2018, "DR1TOT_2005_2018.csv",row.names = FALSE)


############################ HIQ file batch read
filenames <- dir("HIQ_2005_2018")
HIQ_2005_2018 <- data.frame()
for (i in filenames){
  path <- paste0("HIQ_2005_2018","/",i) # construct file path
  tempdata <- read.xport(path) %>%
    select(SEQN, HIQ011)
  HIQ_2005_2018 <- rbind(HIQ_2005_2018,tempdata)
}
write.csv(HIQ_2005_2018, "HIQ_2005_2018.csv",row.names = FALSE)








