#### This script obtains variable OCD150 ("Type of work done last week") in OCQ dataset from Questionnaire Data
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

OCQ_2005_2006 = read.xport("/Users/chenqiaochu/Desktop/625_project/OCQ_2005_2018/OCQ_D.XPT")
OCQ_2007_2008 = read.xport("/Users/chenqiaochu/Desktop/625_project/OCQ_2005_2018/OCQ_E.XPT")
OCQ_2009_2010 = read.xport("/Users/chenqiaochu/Desktop/625_project/OCQ_2005_2018/OCQ_F.XPT")
OCQ_2011_2012 = read.xport("/Users/chenqiaochu/Desktop/625_project/OCQ_2005_2018/OCQ_G.XPT")
OCQ_2013_2014 = read.xport("/Users/chenqiaochu/Desktop/625_project/OCQ_2005_2018/OCQ_H.XPT")
OCQ_2015_2016 = read.xport("/Users/chenqiaochu/Desktop/625_project/OCQ_2005_2018/OCQ_I.XPT") 
OCQ_2017_2018 = read.xport("/Users/chenqiaochu/Desktop/625_project/OCQ_2005_2018/OCQ_J.XPT") 

OCQ_2005_2006 = select(OCQ_2005_2006, c(SEQN, OCD150))
OCQ_2007_2008 = select(OCQ_2007_2008, c(SEQN, OCD150))
OCQ_2009_2010 = select(OCQ_2009_2010, c(SEQN, OCD150))
OCQ_2011_2012 = select(OCQ_2011_2012, c(SEQN, OCD150))
OCQ_2013_2014 = select(OCQ_2013_2014, c(SEQN, OCD150))
OCQ_2015_2016 = select(OCQ_2015_2016, c(SEQN, OCD150))
OCQ_2017_2018 = select(OCQ_2017_2018, c(SEQN, OCD150))

OCQ_2005_2018 = rbind(OCQ_2005_2006, 
                      OCQ_2007_2008, 
                      OCQ_2009_2010, 
                      OCQ_2011_2012, 
                      OCQ_2013_2014, 
                      OCQ_2015_2016, 
                      OCQ_2017_2018)

write.csv(OCQ_2005_2018,"/Users/chenqiaochu/Desktop/625_project/OCQ_2005_2018.csv", row.names = FALSE)


