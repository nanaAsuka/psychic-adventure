#### This script obtains variable MCQ010 ("Ever been told you have asthma") in MCQ dataset from Questionnaire Data
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

MCQ_2005_2006 = read.xport("/Users/chenqiaochu/Desktop/625_project/MCQ_2005_2018/MCQ_D.XPT")
MCQ_2007_2008 = read.xport("/Users/chenqiaochu/Desktop/625_project/MCQ_2005_2018/MCQ_E.XPT")
MCQ_2009_2010 = read.xport("/Users/chenqiaochu/Desktop/625_project/MCQ_2005_2018/MCQ_F.XPT")
MCQ_2011_2012 = read.xport("/Users/chenqiaochu/Desktop/625_project/MCQ_2005_2018/MCQ_G.XPT")
MCQ_2013_2014 = read.xport("/Users/chenqiaochu/Desktop/625_project/MCQ_2005_2018/MCQ_H.XPT")
MCQ_2015_2016 = read.xport("/Users/chenqiaochu/Desktop/625_project/MCQ_2005_2018/MCQ_I.XPT") 
MCQ_2017_2018 = read.xport("/Users/chenqiaochu/Desktop/625_project/MCQ_2005_2018/MCQ_J.XPT") 

MCQ_2005_2006 = select(MCQ_2005_2006, c(SEQN, MCQ010))
MCQ_2007_2008 = select(MCQ_2007_2008, c(SEQN, MCQ010))
MCQ_2009_2010 = select(MCQ_2009_2010, c(SEQN, MCQ010))
MCQ_2011_2012 = select(MCQ_2011_2012, c(SEQN, MCQ010))
MCQ_2013_2014 = select(MCQ_2013_2014, c(SEQN, MCQ010))
MCQ_2015_2016 = select(MCQ_2015_2016, c(SEQN, MCQ010))
MCQ_2017_2018 = select(MCQ_2017_2018, c(SEQN, MCQ010))

MCQ_2005_2018 = rbind(MCQ_2005_2006, 
                      MCQ_2007_2008, 
                      MCQ_2009_2010, 
                      MCQ_2011_2012, 
                      MCQ_2013_2014, 
                      MCQ_2015_2016, 
                      MCQ_2017_2018)

write.csv(MCQ_2005_2018,"/Users/chenqiaochu/Desktop/625_project/MCQ_2005_2018.csv", row.names = FALSE)


