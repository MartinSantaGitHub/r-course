library(caret)

bh <- read.csv("../data/tema3/boston-housing-logistic.csv")
bh$CLASS <- factor(bh$CLASS,levels=c(0,1))

set.seed(2018)

t.ids = createDataPartition(bh$CLASS,p=0.7,list = F)

mod<- glm(CLASS ~ .,data=bh[t.ids,],family=binomial)
summary(mod)

bh[-t.ids,"PROB_SUCCESS"] <- predict(mod,newdata = bh[-t.ids,],type="response")
bh[-t.ids,"PRED_50"] <- ifelse(bh[-t.ids,"PROB_SUCCESS"]>=0.5,1,0)

table(bh[-t.ids,"CLASS"],bh[-t.ids,"PRED_50"],dnn=c("Actual","Predichos"))
