#### This script obtains
####   DIQ010 from DIQ dataset
####   DR1TCARB, DR1TPROT, DR1TPFAT, DR1TFA, DR1TIRON from DR1TOT dataset
####   HIQ011 from HIQ dataset
#### D: 2005-2006
#### E: 2007-2008
#### F: 2009-2010
#### G: 2011-2012
#### H: 2013-2014
#### I: 2015-2016
#### J: 2017-2018

library(foreign)
library(dplyr)
library(tidyverse)
setwd("D:/UMich/625/final project/data download/")

year = c("D", "E", "F", "G", "H", "I", "J")
dataset = c("DIQ_", "DR1TOT_", "HIQ_")
predictor = list(
  c("SEQN", "DIQ010"),
  c(
    "SEQN",
    "DR1TCARB",
    "DR1TPROT",
    "DR1TPFAT",
    "DR1TFA",
    "DR1TIRON"
  ),
  c("SEQN", "HIQ011")
)

for (i in 1:3) {
  complete_data = NULL
  for (j in 1:7) {
    data = read.xport(paste0(dataset[i], year[j], ".XPT"))
    data = data[, predictor[[i]]]
    complete_data = rbind(complete_data, data)
  }
  write.csv(complete_data,
            paste0(dataset[i], "2005_2018.csv"),
            row.names = FALSE)
  print(
    paste0(
      dataset[i],
      "2005_2018.csv (not clean on SEQN) contains ",
      dim(complete_data)[1],
      " SEQN, corresponding to ",
      predictor[[i]][2]
    )
  )
}
