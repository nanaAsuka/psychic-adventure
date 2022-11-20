#### This script obtains variable LBDHI ("HIV antibody test result") in HIV dataset from Laboratory Data 
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

HIV_2005_2006 = read.xport("/Users/chenqiaochu/Desktop/625_project/HIV_2005_2018/HIV_D.XPT")
HIV_2005_2006 = select(HIV_2005_2006, c(SEQN, LBDHI))
HIV_2007_2008 = read.xport("/Users/chenqiaochu/Desktop/625_project/HIV_2005_2018/HIV_E.XPT")
HIV_2009_2010 = read.xport("/Users/chenqiaochu/Desktop/625_project/HIV_2005_2018/HIV_F.XPT")
HIV_2011_2012 = read.xport("/Users/chenqiaochu/Desktop/625_project/HIV_2005_2018/HIV_G.XPT")
HIV_2013_2014 = read.xport("/Users/chenqiaochu/Desktop/625_project/HIV_2005_2018/HIV_H.XPT")
HIV_2015_2016 = read.xport("/Users/chenqiaochu/Desktop/625_project/HIV_2005_2018/HIV_I.XPT") #use LBXHIVC
HIV_2015_2016 = select(HIV_2015_2016, c(SEQN, LBXHIVC))
colnames(HIV_2015_2016) = c("SEQN", "LBDHI")
HIV_2017_2018 = read.xport("/Users/chenqiaochu/Desktop/625_project/HIV_2005_2018/HIV_J.XPT") #use LBXHIVC
HIV_2017_2018 = select(HIV_2017_2018, c(SEQN, LBXHIVC))
colnames(HIV_2017_2018) = c("SEQN", "LBDHI")

#put all data frames into list
HIV_2005_2018 = rbind(HIV_2005_2006, 
                      HIV_2007_2008, 
                      HIV_2009_2010, 
                      HIV_2011_2012, 
                      HIV_2013_2014, 
                      HIV_2015_2016, 
                      HIV_2017_2018)

write.csv(HIV_2005_2018,"/Users/chenqiaochu/Desktop/625_project/HIV_2005_2018.csv", row.names = FALSE)

