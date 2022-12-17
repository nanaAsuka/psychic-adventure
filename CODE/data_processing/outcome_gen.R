#### This script obtains all variables in DPQ dataset from Questionnaire Data
#### This is use for getting the response variable/outcome
#### D: 2005-2006
#### E: 2007-2008
#### F: 2009-2010
#### G: 2011-2012
#### H: 2013-2014
#### I: 2015-2016
#### J: 2017-2018

#install.packages("foreign")
#install.packages("dplyr")
# install.packages("tidyverse")
library(foreign)
library(dplyr)
library(tidyverse)

DPQ_2005_2006 = read.xport("/Users/chenqiaochu/Desktop/625_project/DPQ_2005_2018/DPQ_D.XPT")
DPQ_2007_2008 = read.xport("/Users/chenqiaochu/Desktop/625_project/DPQ_2005_2018/DPQ_E.XPT")
DPQ_2009_2010 = read.xport("/Users/chenqiaochu/Desktop/625_project/DPQ_2005_2018/DPQ_F.XPT")
DPQ_2011_2012 = read.xport("/Users/chenqiaochu/Desktop/625_project/DPQ_2005_2018/DPQ_G.XPT")
DPQ_2013_2014 = read.xport("/Users/chenqiaochu/Desktop/625_project/DPQ_2005_2018/DPQ_H.XPT")
DPQ_2015_2016 = read.xport("/Users/chenqiaochu/Desktop/625_project/DPQ_2005_2018/DPQ_I.XPT")
DPQ_2017_2018 = read.xport("/Users/chenqiaochu/Desktop/625_project/DPQ_2005_2018/DPQ_J.XPT")

DPQ_2005_2018 = rbind(
  DPQ_2005_2006,
  DPQ_2007_2008,
  DPQ_2009_2010,
  DPQ_2011_2012,
  DPQ_2013_2014,
  DPQ_2015_2016,
  DPQ_2017_2018
)
nrow(DPQ_2005_2018) #40496
#write.csv(DPQ_2005_2018,"/Users/chenqiaochu/Desktop/625_project/DPQ_2005_2018.csv", row.names = FALSE)

######## ######## ######## ######## #####
######## make response variables ########
######## ######## ######## ######## #####

######## ######## ########
#drop DPQ100--not defined in PHQ-9's 9 questions
DPQ_2005_2018 = DPQ_2005_2018[, -11]
######## ######## ########

######## ######## ########
# answer = 7 means Refused
# answer = 9 means Don't know
# --> make them to NA
DPQ_2005_2018[DPQ_2005_2018 == 7] = NA
DPQ_2005_2018[DPQ_2005_2018 == 9] = NA

# remove SEQR with all NA
DPQ_2005_2018 = DPQ_2005_2018[rowSums(is.na(DPQ_2005_2018[, -1])) != ncol(DPQ_2005_2018[, -1]),]
nrow(DPQ_2005_2018) #36459   (40496 ----> 36459)
######## ######## ########

######## ######## ########
# calculate the score and add to DPQ_2005_2018
sum_fun = function(x) {
  sum(x[2:11], na.rm = T)
}
DPQ_2005_2018$sum_score = apply(DPQ_2005_2018, 1, sum_fun)
######## ######## ########

DPQ_2005_2018$dep_level = rep(0, nrow(DPQ_2005_2018))
DPQ_2005_2018$dep_level = ifelse(
  DPQ_2005_2018$sum_score <= 4,
  "mini",
  ifelse(
    DPQ_2005_2018$sum_score <= 9,
    "mild",
    ifelse(
      DPQ_2005_2018$sum_score <= 14,
      "moderate",
      ifelse(
        DPQ_2005_2018$sum_score <= 19,
        "moderate_severe",
        ifelse(DPQ_2005_2018$sum_score <= 27, "severe")
      )
    )
  )
)
DPQ_2005_2018_w_level = select(DPQ_2005_2018, c(SEQN, sum_score, dep_level))

write.csv(
  DPQ_2005_2018_w_level,
  "/Users/chenqiaochu/Desktop/625_project/DPQ_2005_2018_w_level.csv",
  row.names = FALSE
)
