#################################
#####       SVM_SMOTE      #####
#################################
setwd("/home/rxxwang/biostat625/SVM/")
# setwd("D:/UMich/625/final_project/")
library(e1071)
load("train2_test_bin.rdata")
set.seed(1932)

##### fit model with SMOTE data #####

svm = svm(dep_level_bin ~ ., data = training2)
svm
test_pred = predict(svm, newdata = testing)
training2$dep_level_bin = as.numeric(training2$dep_level_bin)
testing$dep_level_bin = as.numeric(testing$dep_level_bin)
svm_p = svm(dep_level_bin ~ ., data = training2, probability = TRUE)
svm_p
test_pred_p = predict(svm_p, newdata = testing, probability = TRUE)
save(svm, test_pred, svm_p, test_pred_p, file = "svm_caret_pred_bin2.rdata")