####################################
##  Multinomial logistics regression
####################################

##### fit model with stratified sampling data #####
load("train_test_bin.rdata")

library(caret)
library(pROC)

logit_fit = glm(dep_level_bin ~ ., data = training, family = "binomial")
logit_pred = predict(logit_fit, newdata = testing)
summary(logit_fit)

# define the threshold
c = nrow(training[training$dep_level_bin == 1, ]) / nrow(training)
logit_pred = ifelse(logit_pred, logit_pred >= c)
logit_pred = as.integer(logit_pred)

logit_cm = confusionMatrix(
  data = as.factor(logit_pred),
  reference = as.factor(testing[, 1]),
  positive = "1",
  mode = "everything"
)
(logit_balanced_acc = logit_cm$byClass[11]) # 0.5476291
(logit_f1 = logit_cm$byClass[7]) #0.1737452

#ROC/AUC
test_roc = roc(
  testing$dep_level_bin ~ as.numeric(logit_pred),
  plot = TRUE,
  print.auc = TRUE
)
as.numeric(test_roc$auc) #0.5476291



##### fit model with SMOTE data #####
load("train2_test_bin.rdata")

library(caret)
library(pROC)

logit_fit = glm(dep_level_bin ~ ., data = training2, family = "binomial")
logit_pred = predict(logit_fit, newdata = testing)
summary(logit_fit)

# define the threshold
c = nrow(training2[training2$dep_level_bin == 1, ]) / nrow(training2)
logit_pred = ifelse(logit_pred, logit_pred >= c)
logit_pred = as.integer(logit_pred)

logit_cm = confusionMatrix(
  data = as.factor(logit_pred),
  reference = as.factor(testing[, 1]),
  positive = "1",
  mode = "everything"
)
(logit_balanced_acc = logit_cm$byClass[11]) #0.7172514
(logit_f1 = logit_cm$byClass[7]) # 0.3598901

#ROC/AUC
test_roc = roc(
  testing$dep_level_bin ~ as.numeric(logit_pred),
  plot = TRUE,
  print.auc = TRUE
)
as.numeric(test_roc$auc) #0.7172514

##### fit model with downsample data #####
load("train3_test_bin.rdata")

logit_fit = glm(dep_level_bin ~ ., data = training3, family = "binomial")
logit_pred = predict(logit_fit, newdata = testing)
summary(logit_fit)

# define the threshold
c = nrow(training3[training3$dep_level_bin == 1, ]) / nrow(training3)
logit_pred = ifelse(logit_pred, logit_pred >= c)
logit_pred = as.integer(logit_pred)

logit_cm = confusionMatrix(
  data = as.factor(logit_pred),
  reference = as.factor(testing[, 1]),
  positive = "1",
  mode = "everything"
)
(logit_balanced_acc = logit_cm$byClass[11]) #0.7151739
(logit_f1 = logit_cm$byClass[7]) #

#ROC/AUC
test_roc = roc(
  testing$dep_level_bin ~ as.numeric(logit_pred),
  plot = TRUE,
  print.auc = TRUE
)
as.numeric(test_roc$auc) #0.7151739
