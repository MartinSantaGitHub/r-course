#install.packages("naivebayes")
library(caret)
library(e1071)

ep <- read.csv("../data/tema3/electronics-purchase.csv")

set.seed(2018)

t.ids <- createDataPartition(ep$Purchase,p=0.6,list=F)
mod <- naiveBayes(Purchase ~ .,data = ep[t.ids,])
mod

pred <- predict(mod,ep[-t.ids,])
tab <- table(ep[-t.ids,]$Purchase,pred,dnn=c("Actual","Predicha"))
confusionMatrix(tab)
