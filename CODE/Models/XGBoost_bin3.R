#################################
#####        XGBoost        #####
#################################
setwd("/home/rxxwang/biostat625/XGBoost/")
# setwd("D:/UMich/625/final_project/")
library(caret)
library(xgboost)
load("train3_test_bin.rdata")
xgb_trcontrol = trainControl(
  method = "cv",
  number = 5
)
tune_grid <- expand.grid(
  nrounds = seq(1:10)*50,
  eta = 0.3,
  max_depth = 1:10,
  gamma = 0,
  colsample_bytree = 1,
  min_child_weight = 1,
  subsample = 1
)
set.seed(323) 
xgb_model = train(
  dep_level_bin ~., data = training3,
  trControl = xgb_trcontrol,
  tuneGrid = tune_grid,
  method = "xgbTree",
  verbose = FALSE,
  verbosity = 0
)
xgb_model$bestTune
test_pred <- predict(xgb_model, newdata = testing)
save(xgb_model, test_pred, file = "xgboost_pred_bin3.rdata")