library(class)
library(caret)
library(MLmetrics)
library(pROC)


################using smote########################

#gauge k --> 194.2936
k1 = sqrt(nrow(training2))

trControl <- trainControl(method  = "cv",number  = 5, classProbs = TRUE, summaryFunction = prSummary)

set.seed(3203)

knn.fit <- train(make.names(as.factor(dep_level_bin)) ~ ., data = training2, method = "knn",
                  tuneGrid = expand.grid(k = 1:195),
                  trControl = trControl,
                  metric = "AUC")

# k = 54
knn_pred <- knn(train=training2[,-1],
                test=testing[,-1],
                cl=training2[,1],
                k=knn.fit$bestTune$k)

test_roc = roc(testing$dep_level_bin~ as.numeric(knn_pred), plot = TRUE, print.auc = TRUE)
as.numeric(test_roc$auc)#0.7045392

cm1 = confusionMatrix(data = knn_pred, reference = as.factor(testing[,1]), positive = "1")
cm1


###############using down ################
#gauge k --> 59.43
k2 = sqrt(nrow(training3))


set.seed(3204)

knn.fit2 <- train(make.names(as.factor(dep_level_bin)) ~ ., data = training3, method = "knn",
                 tuneGrid = expand.grid(k = 1:60),
                 trControl = trControl,
                 metric = "AUC")

# k = 58
knn_pred2 <- knn(train=training3[,-39],
                test=testing[,-39],
                cl=training3[,39],
                k=knn.fit2$bestTune$k)

test_roc2 = roc(testing$dep_level_bin~ as.numeric(knn_pred2), plot = TRUE, print.auc = TRUE)
as.numeric(test_roc2$auc)#0.4910222

cm2 = confusionMatrix(data = knn_pred2, reference = as.factor(testing[,1]), positive = "1")
cm2

#####################using stratified ##############

#gauge k--> 143
k3 = sqrt(nrow(training))

set.seed(3205)

knn.fit3 <- train(make.names(as.factor(dep_level_bin)) ~ ., data = training, method = "knn",
                  tuneGrid = expand.grid(k = 144:200),
                  trControl = trControl,
                  metric = "AUC")
# k = 93(highest F)

knn_pred3 <- knn(train=training[,-1],
                 test=testing[,-1],
                 cl=training[,1],
                 k=knn.fit3$bestTune$k)

knnPredict <- predict(knn.fit3,newdata = testing)

test_roc3 = roc(testing$dep_level_bin~ as.numeric(knn_pred3), plot = TRUE, print.auc = TRUE)
as.numeric(test_roc3$auc)#0.5

cm3 = confusionMatrix(data = knn_pred3, reference = as.factor(testing[,1]), positive = "1")
cm3


