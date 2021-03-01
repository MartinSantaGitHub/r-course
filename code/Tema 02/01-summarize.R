#install.packages(c("modeest","raster","moments"))
library(modeest) # moda
library(raster) # quantiles, cv
library(moments) # asimetría, curtosis

data <- read.csv("../data/tema2/auto-mpg.csv",header=TRUE,stringsAsFactors = FALSE)

data$cylinders <- factor(data$cylinders,
                         levels=c(3,4,5,6,8),
                         labels = c("3cil","4cil","5cil","6cil","8cil"))

summary(data)

str(data)

summary(data$cylinders)
summary(data$mpg)
str(data$cylinders)

X = data$mpg

#### Medidas de Centralización

mean(X) # sum(X)/length(X)
median(X)
mfv(X)
quantile(X)

#### Medidas de Dispersión

var(X)
sd(X)
cv(X) # (sd(X)/mean(X)) * 100

#### Medidas de Asimetría

skewness(X)
moments::kurtosis(X)

par(mfrow = c(1,1))
hist(X)
