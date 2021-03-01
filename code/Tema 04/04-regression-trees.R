#install.packages("rpart")
#install.packages("rpart.plot")
#install.packages("ipred")
#install.packages("gbm")
library(rpart)
library(rpart.plot)
library(caret)
library(ipred)
library(gbm)

bh <- read.csv("../data/tema4/BostonHousing.csv")
t.id <- createDataPartition(bh$MEDV,p=.7,list=F)
bfit <- rpart(MEDV~.,data=bh[t.id,])
bfit

prp(bfit,type=2,nn=T,fallen.leaves = T,faclen = 4,varlen = 8,shadow.col = "gray")

bfit$cptable

plotcp(bfit)

bfitpruned <- prune(bfit,cp=0.02357120)

prp(bfitpruned,type=2,nn=T,fallen.leaves = T,faclen = 4,varlen = 8,shadow.col = "gray")

preds <- predict(bfit, bh[t.id,])
sqrt(mean((preds - bh[t.id,]$MEDV)^2))

preds <- predict(bfitpruned, bh[t.id,])
sqrt(mean((preds - bh[t.id,]$MEDV)^2))

preds <- predict(bfitpruned, bh[-t.id,])
sqrt(mean((preds - bh[-t.id,]$MEDV)^2))

preds <- predict(bfit, bh[-t.id,])
sqrt(mean((preds - bh[-t.id,]$MEDV)^2))

# Predictores categóricos

ed <- read.csv("../data/tema4/education.csv")
ed$region <- factor(ed$region)
t.id <- createDataPartition(ed$expense,p=0.7,list=F)
fit <- rpart(expense ~ region+urban+income+under18,data=ed[t.id,])
prp(fit,type=2,nn=T,fallen.leaves = T,faclen = 4,varlen = 8,shadow.col = "gray")

# Bagging 
bagging.fit <- bagging(MEDV~.,data=bh[t.id,])

prediction.t <- predict(bagging.fit,bh[t.id,])
sqrt(mean((prediction.t - bh[t.id,]$MEDV)^2))

prediction.v <- predict(bagging.fit,bh[-t.id,])
sqrt(mean((prediction.v - bh[-t.id,]$MEDV)^2))

# Boosting
gbmfit <- gbm(MEDV~.,data=bh[t.id,],distribution = "gaussian")
prediction.t <- predict()
