#install.packages(c("rpart","rpart.plot","caret"))
library(rpart)
library(rpart.plot)
library(caret)
library(ROCR)

banknote <- read.csv("../data/tema3/banknote-authentication.csv")

set.seed(2018)

training.ids <- createDataPartition(banknote$class,p=0.7,list=F)

#class ~ . <-> class ~ variance + skew + curtosis + entropy
mod <- rpart(class ~ ., data=banknote[training.ids,],
             method="class",
             control = rpart.control(minsplit=20,cp=0.01))
mod

prp(mod,type=2,
    extra = 104,nn=T,
    cex=.6,fallen.leaves=T,
    faclen=4,varlen=8,
    shadow.col = "gray")

mod$cptable

mod.pruned <- prune(mod,mod$cptable[4,"CP"])

prp(mod.pruned,type=2,
    extra = 104,nn=T,
    cex=.6,fallen.leaves=T,
    faclen=4,varlen=8,
    shadow.col = "gray")

pred <- predict(mod, banknote[-training.ids,],type="class")
table(banknote[-training.ids,]$class,pred.pruned,dnn=c("Actual","Predicho"))

pred.pruned <- predict(mod.pruned, banknote[-training.ids,],type="class")
table(banknote[-training.ids,]$class,pred.pruned,dnn=c("Actual","Predicho"))

pred.pruned2 <- predict(mod.pruned,banknote[-training.ids,],type="prob")
pred2 <- predict(mod,banknote[-training.ids,],type="prob")

head(pred.pruned)
head(pred.pruned2)

pred <- prediction(pred.pruned2[,2],banknote[-training.ids,"class"])
perf <- performance(pred,"tpr","fpr")
plot(perf)
lines(par()$usr[1:2],par()$usr[3:4])

pred <- prediction(pred2[,2],banknote[-training.ids,"class"])
perf <- performance(pred,"tpr","fpr")
plot(perf)
lines(par()$usr[1:2],par()$usr[3:4])

