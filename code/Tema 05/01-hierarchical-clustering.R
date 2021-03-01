#install.packages("cluster")
library(cluster)

protein <- read.csv("../data/tema5/protein.csv")

data <- as.data.frame(scale(protein[,-1]))
data$Country = protein$Country                      

rownames(data) = protein$Country

hc <- hclust(dist(data,method = "euclidean"),method = "ward.D2")
hc
plot(hc,hang=-0.01,cex=0.7)
rect.hclust(hc,k=5,border="red")

hc2 <- hclust(dist(data,method = "euclidean"),method = "single")
plot(hc2,hang=-0.01,cex=0.7)

d <- dist(data,method = "manhattan")
d

alb<-data["Albania",-10]
aus <- data["Austria",-10]
sqrt(sum((alb-aus)^2))
sum(abs(alb-aus))

hc3 <- hclust(dist(data,method = "euclidean"),method = "complete")
plot(hc3,hang=-0.01,cex=0.7)
hc$merge

hc4 <- hclust(dist(data,method = "euclidean"),method = "average")
plot(hc4,hang=-0.01,cex=0.7)
hc4$merge

dv <- diana(data,metric="euclidean")
par(mfrow=c(1,2))
plot(dv)

par(mfrow=c(1,1))

fit <- cutree(hc,k=4)
table(fit)
