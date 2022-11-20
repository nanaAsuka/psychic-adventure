#### This script obtains variables SMQ020 ("Smoked at least 100 cigarettes in life") in SMQ dataset from Questionnaire Data
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

SMQ_2005_2006 = read.xport("/Users/chenqiaochu/Desktop/625_project/SMQ_2005_2018/SMQ_D.XPT")
SMQ_2007_2008 = read.xport("/Users/chenqiaochu/Desktop/625_project/SMQ_2005_2018/SMQ_E.XPT")
SMQ_2009_2010 = read.xport("/Users/chenqiaochu/Desktop/625_project/SMQ_2005_2018/SMQ_F.XPT")
SMQ_2011_2012 = read.xport("/Users/chenqiaochu/Desktop/625_project/SMQ_2005_2018/SMQ_G.XPT")
SMQ_2013_2014 = read.xport("/Users/chenqiaochu/Desktop/625_project/SMQ_2005_2018/SMQ_H.XPT")
SMQ_2015_2016 = read.xport("/Users/chenqiaochu/Desktop/625_project/SMQ_2005_2018/SMQ_I.XPT") 
SMQ_2017_2018 = read.xport("/Users/chenqiaochu/Desktop/625_project/SMQ_2005_2018/SMQ_J.XPT") 

SMQ_2005_2006 = select(SMQ_2005_2006, c(SEQN, SMQ020))
SMQ_2007_2008 = select(SMQ_2007_2008, c(SEQN, SMQ020))
SMQ_2009_2010 = select(SMQ_2009_2010, c(SEQN, SMQ020))
SMQ_2011_2012 = select(SMQ_2011_2012, c(SEQN, SMQ020))
SMQ_2013_2014 = select(SMQ_2013_2014, c(SEQN, SMQ020))
SMQ_2015_2016 = select(SMQ_2015_2016, c(SEQN, SMQ020))
SMQ_2017_2018 = select(SMQ_2017_2018, c(SEQN, SMQ020))

SMQ_2005_2018 = rbind(SMQ_2005_2006, 
                      SMQ_2007_2008, 
                      SMQ_2009_2010, 
                      SMQ_2011_2012, 
                      SMQ_2013_2014, 
                      SMQ_2015_2016, 
                      SMQ_2017_2018)

write.csv(SMQ_2005_2018,"/Users/chenqiaochu/Desktop/625_project/SMQ_2005_2018.csv", row.names = FALSE)


