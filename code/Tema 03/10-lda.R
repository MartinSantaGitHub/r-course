library(MASS)
library(caret)

bn <- read.csv("../data/tema3/banknote-authentication.csv")
bn$class <- factor(bn$class)

set.seed(2018)

t.ids <- createDataPartition(bn$class,p=0.7,list=F)

mod <- lda(bn[t.ids,1:4],bn[t.ids,5])
mod <- lda(class ~ ., data=bn[t.ids,])

bn[t.ids,"Pred"] <- predict(mod,bn[t.ids,1:4])$class

table(bn[t.ids,"class"],bn[t.ids,"Pred"],dnn=c("Actual","Predichos"))

bn[-t.ids,"Pred"] <- predict(mod,bn[-t.ids,1:4])$class
table(bn[-t.ids,"class"],bn[-t.ids,"Pred"],dnn=c("Actual","Predichos"))
