#install.packages("FNN")
library(FNN)
library(dummies)
library(scales)
library(caret)

edu <- read.csv("../data/tema4/education.csv")
dms <- dummy(edu$region,sep="-")
edu <- cbind(edu,dms)

edu$urban.s <- rescale(edu$urban)
edu$income.s <- rescale(edu$income)
edu$unde18.s <- rescale(edu$under18)

set.seed(2018)

t.ids <- createDataPartition(edu$expense,p=0.6,list=F)
tr <- edu[t.ids,]
temp <- edu[-t.ids,]
v.ids <- createDataPartition(temp$expense,p=0.5,list=F)
val <- temp[v.ids,]
test <- temp[-v.ids,]

reg1 <- knn.reg(tr[,7:12],val[,7:12],tr$expense,k=1,
                algorithm = "brute")
rmse1 <- sqrt(mean((reg1$pred-val$expense)^2))
rmse1

reg2 <- knn.reg(tr[,7:12],val[,7:12],tr$expense,k=2,
                algorithm = "brute")
rmse2 <- sqrt(mean((reg2$pred-val$expense)^2))
rmse2

reg3 <- knn.reg(tr[,7:12],val[,7:12],tr$expense,k=3,
                algorithm = "brute")
rmse3 <- sqrt(mean((reg3$pred-val$expense)^2))
rmse3

reg4 <- knn.reg(tr[,7:12],val[,7:12],tr$expense,k=4,
                algorithm = "brute")
rmse4 <- sqrt(mean((reg4$pred-val$expense)^2))
rmse4

df <- data.frame(actual=val$expense,pred=reg4$pred)
plot(df)
abline(0,1)

reg5 <- knn.reg(tr[,7:12],val[,7:12],tr$expense,k=5,
                algorithm = "brute")
rmse5 <- sqrt(mean((reg5$pred-val$expense)^2))
rmse5

errors = c(rmse1,rmse2,rmse3,rmse4,rmse5)
plot(errors, type="o",xlab="k",ylab="RMSE")

reg.test <- knn.reg(tr[,7:12],test[,7:12],tr$expense,k=4,
                algorithm = "brute")
rmse.test <- sqrt(mean((reg.test$pred-test$expense)^2))
rmse.test

df <- data.frame(actual=test$expense,pred=reg.test$pred)
plot(df)
abline(0,1)

# Sin partición de validación
t.id <- createDataPartition(edu$expense,p=0.7,list=F)
tr <- edu[t.id,]
val <- edu[-t.id,]

reg <- knn.reg(tr[,7:12],test=NULL,y = tr$expense,
               k=4,algorithm = "brute")
rmse.reg <- sqrt(mean(reg$residuals^2))
rmse.reg

rdacb.knn.reg <- function(tr_predictos,val_predictors,
                          tr_target,val_target,k){
  library(FNN)
  res <- knn.reg(tr_predictos,val_predictors,tr_target,
                 k,algorithm = "brute")
  rmserror <- sqrt(mean((val_target-res$pred)^2))
  cat(paste("RMSE para k = ",toString(k), ": ", rmserror,"\n",sep=""))
  rmserror
}

rdacb.knn.reg(tr[,7:12],val[,7:12],tr$expense,val$expense,1)
rdacb.knn.reg(tr[,7:12],val[,7:12],tr$expense,val$expense,2)
rdacb.knn.reg(tr[,7:12],val[,7:12],tr$expense,val$expense,3)
rdacb.knn.reg(tr[,7:12],val[,7:12],tr$expense,val$expense,4)
rdacb.knn.reg(tr[,7:12],val[,7:12],tr$expense,val$expense,5)

rdacb.knn.multi <- function(tr_predictos,val_predictors,
                            tr_target,val_target,start_k,end_k){
  rms_errors <- vector()
  for (k in start_k:end_k) {
    rms_error <- rdacb.knn.reg(tr_predictos,val_predictors,tr_target,val_target,k)
    rms_errors <- c(rms_errors,rms_error)
  }
  plot(rms_errors,type="o",xlab="k",ylab="RMSE")
}

rdacb.knn.multi(tr[,7:12],val[,7:12],tr$expense,val$expense,1,10)
