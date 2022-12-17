#################################
#####       SVM_stratified       #####
#################################
setwd("/home/rxxwang/biostat625/SVM/")
# setwd("D:/UMich/625/final_project/")
library(e1071)
load("train_test_bin.rdata")
set.seed(1932)

##### fit model with stratified sampling data #####

svm = svm(dep_level_bin ~ ., data = training)
svm
test_pred = predict(svm, newdata = testing)
training$dep_level_bin = as.numeric(training$dep_level_bin)
testing$dep_level_bin = as.numeric(testing$dep_level_bin)
svm_p = svm(dep_level_bin ~ ., data = training, probability = TRUE)
svm_p
test_pred_p = predict(svm_p, newdata = testing, probability = TRUE)
save(svm, test_pred, svm_p, test_pred_p, file = "svm_caret_pred_bin.rdata")