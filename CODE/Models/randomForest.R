##################################
library(randomForest)
library(rfUtilities)
library(caret)
library(e1071)
library(pROC)

load("train_test_bin.rdata")

##############Stratified sampling################

training$dep_level_bin = as.factor(training$dep_level_bin)
trControl = trainControl(
  method  = "cv",
  number  = 5,
  classProbs = TRUE,
  search = "grid",
  summaryFunction = prSummary
)

set.seed(333)

#find mtry
set.seed(107)

tg = expand.grid(.mtry = c(1:20))

rf_mtry = train(
  make.names(dep_level_bin) ~ .,
  data = training,
  method = "rf",
  metric = "AUC",
  tuneGrid = tg,
  importance = TRUE,
  trControl = trControl
)
best_mtry = 5

tuneGrid = expand.grid(.mtry = best_mtry)


#best ntrees
store_maxtrees = list()
for (ntree in c(50,
                100,
                150,
                200,
                250,
                300,
                350,
                400,
                450,
                500,
                550,
                600,
                650,
                700,
                750,
                800)) {
  set.seed(5678)
  rf_maxtrees = train(
    make.names(dep_level_bin) ~ .,
    data = training,
    method = "rf",
    metric = "AUC",
    tuneGrid = tuneGrid,
    trControl = trControl,
    importance = TRUE,
    ntree = ntree
  )
  key = toString(ntree)
  store_maxtrees[[key]] = rf_maxtrees
}
results_tree = resamples(store_maxtrees)
summary(results_tree)    #-> 500 (AUC)

# stratified model under optimal paras

set.seed(3300)
rf_fit = randomForest(
  x = training[-1],
  y = training$dep_level_bin,
  ntree = 500,
  mtry = 5
)

rf_pred = predict(rf_fit, newdata = testing[-1])

rf_cm = confusionMatrix(testing$dep_level_bin,
                        rf_pred,
                        mode = "everything",
                        positive = "1")
(rf_balanced_acc = rf_cm$byClass[11]) #  0.8122582
(rf_f1 = rf_cm$byClass[7]) #0.1010526

test_roc = roc(testing$dep_level_bin ~ as.numeric(rf_pred),
               plot = TRUE,
               print.auc = TRUE)
as.numeric(test_roc$auc) # 0.5261511

importance(rf_fit)
varImpPlot(rf_fit)


############ SMOTE ##############
load("train2_test_bin.rdata")

training2$dep_level_bin = as.factor(training2$dep_level_bin)
trControl = trainControl(
  method  = "cv",
  number  = 5,
  classProbs = TRUE,
  search = "grid",
  summaryFunction = prSummary
)

set.seed(333)

#find mtry
set.seed(107)

tg = expand.grid(.mtry = c(1:20))

rf_mtry = train(
  make.names(dep_level_bin) ~ .,
  data = training2,
  method = "rf",
  metric = "AUC",
  tuneGrid = tg,
  importance = TRUE,
  trControl = trControl
)
best_mtry = 5


tuneGrid = expand.grid(.mtry = best_mtry)


#best ntrees
store_maxtrees = list()
for (ntree in c(50,
                100,
                150,
                200,
                250,
                300,
                350,
                400,
                450,
                500,
                550,
                600,
                650,
                700,
                750,
                800)) {
  set.seed(5678)
  rf_maxtrees = train(
    make.names(dep_level_bin) ~ .,
    data = training2,
    method = "rf",
    metric = "AUC",
    tuneGrid = tuneGrid,
    trControl = trControl,
    importance = TRUE,
    ntree = ntree
  )
  key = toString(ntree)
  store_maxtrees[[key]] = rf_maxtrees
}
results_tree = resamples(store_maxtrees)
summary(results_tree)    #-> 650 (AUC)


# smote model under optimal paras

set.seed(3300)
rf_fit_smote = randomForest(
  x = training2[-1],
  y = training2$dep_level_bin,
  ntree = 650,
  mtry = 5
)

rf_pred2 = predict(rf_fit_smote, newdata = testing[-1])

rf_cm = confusionMatrix(testing$dep_level_bin,
                        rf_pred2,
                        mode = "everything",
                        positive = "1")
(rf_balanced_acc = rf_cm$byClass[11])  #  0.5868797
(rf_f1 = rf_cm$byClass[7]) #0.2787194

test_roc2 = roc(
  testing$dep_level_bin ~ as.numeric(rf_pred2),
  plot = TRUE,
  print.auc = TRUE
)
as.numeric(test_roc2$auc) # 0.6176733

importance(rf_fit_smote)
varImpPlot(rf_fit_smote)

############ Downsampling ##############
load("train3_test_bin.rdata")


training3$dep_level_bin = as.factor(training3$dep_level_bin)
trControl = trainControl(
  method  = "cv",
  number  = 5,
  classProbs = TRUE,
  search = "grid",
  summaryFunction = prSummary
)

set.seed(333)

#find mtry
set.seed(107)

tg = expand.grid(.mtry = c(1:20))

rf_mtry = train(
  make.names(dep_level_bin) ~ .,
  data = training3,
  method = "rf",
  metric = "AUC",
  tuneGrid = tg,
  importance = TRUE,
  trControl = trControl
)
best_mtry = 6


tuneGrid = expand.grid(.mtry = best_mtry)


#best ntrees
store_maxtrees = list()
for (ntree in c(300,
                350,
                400,
                450,
                500,
                550,
                600,
                650,
                700,
                750,
                800,
                850,
                900,
                950,
                1000)) {
  set.seed(5678)
  rf_maxtrees = train(
    make.names(dep_level_bin) ~ .,
    data = training3,
    method = "rf",
    metric = "AUC",
    tuneGrid = tuneGrid,
    trControl = trControl,
    importance = TRUE,
    ntree = ntree
  )
  key = toString(ntree)
  store_maxtrees[[key]] = rf_maxtrees
}
results_tree = resamples(store_maxtrees)
summary(results_tree)    #700-> (AUC)


# downsample model under optimal paras

set.seed(3300)
rf_fit_down = randomForest(
  x = training3[-39],
  y = training3$dep_level_bin,
  ntree = 700,
  mtry = 6
)

rf_pred3 = predict(rf_fit_down, newdata = testing[-1])

rf_cm = confusionMatrix(testing$dep_level_bin,
                        rf_pred3,
                        mode = "everything",
                        positive = "1")
(rf_balanced_acc = rf_cm$byClass[11])  # 0.5862212
(rf_f1 = rf_cm$byClass[7]) #0.3210127

test_roc3 = roc(
  testing$dep_level_bin ~ as.numeric(rf_pred3),
  plot = TRUE,
  print.auc = TRUE
)
as.numeric(test_roc3$auc) #0.7304363

importance(rf_fit_down)
varImpPlot(rf_fit_down)
