####################################
##          Naive Bayes
##################################

library(e1071)
library(caret)
library(pROC)
set.seed(12)

##### fit model with stratidied sampling data #####
load("train_test_bin.rdata")

nb_fit = naiveBayes(dep_level_bin ~ ., data = training)
nb_pred = predict(nb_fit, newdata = testing)
nb_cm = confusionMatrix(testing$dep_level_bin,
                        nb_pred,
                        mode = "everything",
                        positive = "1")
(nb_balanced_acc = nb_cm$byClass[11]) #0.5760803
(nb_f1 = nb_cm$byClass[7]) #0.2883135

test_roc = roc(testing$dep_level_bin ~ as.numeric(nb_pred),
               plot = TRUE,
               print.auc = TRUE)
as.numeric(test_roc$auc) # 0.650686



##### fit model with SMOTE data #####
load("train2_test_bin.rdata")

nb_fit = naiveBayes(dep_level_bin ~ ., data = training2)
nb_pred = predict(nb_fit, newdata = testing)
nb_cm = confusionMatrix(testing$dep_level_bin,
                        nb_pred,
                        mode = "everything",
                        positive = "1")
(nb_balanced_acc = nb_cm$byClass[11]) #0.552302
(nb_f1 = nb_cm$byClass[7]) #0.2453378

test_roc = roc(testing$dep_level_bin ~ as.numeric(nb_pred),
               plot = TRUE,
               print.auc = TRUE)
as.numeric(test_roc$auc) # 0.6579833


##### fit model with downsampling data #####
load("train3_test_bin.rdata")

nb_fit = naiveBayes(dep_level_bin ~ ., data = training3)
nb_pred = predict(nb_fit, newdata = testing)
nb_cm = confusionMatrix(testing$dep_level_bin,
                        nb_pred,
                        mode = "everything",
                        positive = "1")
(nb_balanced_acc = nb_cm$byClass[11]) #  0.5591518
(nb_f1 = nb_cm$byClass[7]) # 0.2610245

test_roc = roc(testing$dep_level_bin ~ as.numeric(nb_pred),
               plot = TRUE,
               print.auc = TRUE)
as.numeric(test_roc$auc) #  0.6720681
