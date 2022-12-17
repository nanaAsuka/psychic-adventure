# This script contains data preprocessing, EDA on complete_data.csv
# reconstruction on outcome variable 
# train and test splitting
# Note: three ways dealing with training data
# 1. stratified
# 2. SMOTE
# 3. Down-sampling

library(caret)
set.seed(107)

## read completedata
completedata = read.csv("complete_data.csv")
completedata = na.omit(completedata) ## remove NA data

#drop dep_level
completedata = completedata[-25]

# outcome reconstruction 
# create two classes based on sum_score < 10 --> 0; >= 10 --> 1;
completedata$dep_level_bin = ifelse(completedata$sum_score < 10, 0, 1)
completedata = completedata[-24] ## drop sum_score


#############################
#### filter invalid data ####
#############################

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
completedata$dep_level_bin = as.factor(completedata$dep_level_bin)
data = completedata

#######################################
#### EDA ##############################
#######################################

#summary of data
summary(data)

cor(data)

# boxplot for continuous variables
png(file="BMXBMI.png")  
png(file="RIDAGEYR.png")  
png(file="HSD010.png")  
png(file="DR1TIRON.png")  
png(file="DR1TCARB.png")  
png(file="DR1TFA.png")  
png(file="DR1TPFAT.png")  
png(file="DR1TPROT.png")  

boxplot(data$BMXBMI~data$dep_level_bin, xlab = "depression level", ylab = "BMXBMI") # slight different
dev.off()
boxplot(data$RIDAGEYR~data$dep_level_bin, xlab = "depression level", ylab = "RIDAGEYR")
dev.off()
boxplot(data$HSD010~data$dep_level_bin, xlab = "depression level", ylab = "HSD010") # see difference
dev.off()
boxplot(data$DR1TIRON~data$dep_level_bin, xlab = "depression level", ylab = "DR1TIRON")
dev.off()
boxplot(data$DR1TCARB~data$dep_level_bin, xlab = "depression level", ylab = "DR1TCARB")
dev.off()
boxplot(data$DR1TFA~data$dep_level_bin, xlab = "depression level", ylab = "DR1TFA")
dev.off()
boxplot(data$DR1TPFAT~data$dep_level_bin, xlab = "depression level", ylab = "DR1TPFAT")
dev.off()
boxplot(data$DR1TPROT~data$dep_level_bin, xlab = "depression level", ylab = "DR1TPROT")
dev.off()
# bar plot for differ depression level within differ gender
# found difference

png(file="gender.png")  
par( mfrow= c(1,2) )
barplot(table(data$RIAGENDR[data$dep_level_bin == 0]), xlab = "gender (1) MALE (2) FEMALE", ylab = "count", main = "depression score < 10")
barplot(table(data$RIAGENDR[data$dep_level_bin == 1]), xlab = "gender (1) MALE (2) FEMALE", ylab = "count", main = "depression score >= 10")
dev.off()

#######################################
#### stratify split train and test ####
#######################################

inTrain = createDataPartition(y = data$dep_level_bin,
                              ## the outcome data are needed
                              p = .8,
                              ## The percentage of data in the
                              ## training set
                              list = FALSE)

str(inTrain)


training = data[inTrain, ]
testing  = data[-inTrain, ]

nrow(training)
#>[1] 20641
nrow(testing)
#>[1] 5159

table(training$dep_level_bin)
table(testing$dep_level_bin)


#########################################################
#####standardization on train and test separately########
#########################################################

library(mltools)
library(data.table)
# one-hot key methods variables
hotkeys_col = c("DMDEDUC2", "DMDMARTL", "RIDRETH1", "OCD150")
# dichotomous variables
dichotomous_col = c("BPQ020",
                    "BPQ080",
                    "RIAGENDR",
                    "DIQ010",
                    "HIQ011",
                    "MCQ010",
                    "SMQ020",
                    "PAD200")
# continuous variables
continuous_col = c(
  "BMXBMI",
  "RIDAGEYR",
  "INDFMPIR",
  "DR1TCARB",
  "DR1TPROT",
  "DR1TPFAT",
  "DR1TFA",
  "DR1TIRON",
  "DMDHHSIZ",
  "HSD010"
)

# set 2 new dataframe
std_training = training[, c("SEQN", "dep_level_bin")]
std_testing = testing[, c("SEQN", "dep_level_bin")]
# one-hot key methods
hotkeys = function(data, std_data) {
  for (i in 1:length(hotkeys_col)) {
    dt = data.table(factor(data[, hotkeys_col[i]]))
    colnames(dt) = hotkeys_col[i]
    std_data = cbind(std_data, as.data.frame(one_hot(dt)))
  }
  return(std_data)
}
std_training = hotkeys(training, std_training)
std_testing = hotkeys(testing, std_testing)

# dichotomous variables
dichotomous = function(data, std_data) {
  for (i in 1:length(dichotomous_col)) {
    colnames_std_data = colnames(std_data)
    col_num = dim(std_data)[2] + 1
    std_data[, col_num] = data[, dichotomous_col[i]] - 1
    colnames(std_data) = c(colnames_std_data, dichotomous_col[i])
  }
  return(std_data)
}
std_training = dichotomous(training, std_training)
std_testing = dichotomous(testing, std_testing)


# continuous variables
continuous = function(data, std_data) {
  for (i in 1:length(continuous_col)) {
    colnames_std_data = colnames(std_data)
    std_data = cbind(std_data, as.data.frame(scale(data[, continuous_col[i]])))
    colnames(std_data) = c(colnames_std_data, continuous_col[i])
  }
  return(std_data)
}
std_training = continuous(training, std_training)
std_testing = continuous(testing, std_testing)

# keep the same variable names
training = std_training
testing = std_testing

#remove id
training = subset(training, select = -c(SEQN))
testing = subset(testing, select = -c(SEQN))

##############################################
########## stratified sampling      ##########
##############################################


save(training, testing, file = "train_test_bin.rdata")

#####################################
##########      SMOTE      ##########
#####################################

library(themis)
set.seed(838)
training2 = smote(training, var = "dep_level_bin")
save(training2, testing, file = "train2_test_bin.rdata")


#####################################
##########    Downsample   ##########
#####################################

library(caret)
training3 = downSample(x = training[, -1],
                       y = training$dep_level_bin,
                       yname = "dep_level_bin")
#table(training3$dep_level_bin)
save(training3, testing, file = "train3_test_bin.rdata")
