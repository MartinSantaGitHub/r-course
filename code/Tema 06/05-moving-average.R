s <- read.csv("../data/tema6/ts-example.csv")
s$sales
plot(s$sales, type="l")

n <- 7
weights <- rep(1/n,n)
weights

s.fil.1 <- filter(s$sales,filter=weights,sides=2)
lines(s.fil.1,col="blue",lw=3)

s.fil.2 <- filter(s$sales,filter=weights,sides=1)
lines(s.fil.2,col="red",lw=3)

n <- 12
gas.f.1 <- filter(prices.ts[,2],filter=rep(1/n,n),sides=2)
gas.f.2 <- filter(prices.ts[,2],filter=rep(1/n,n),sides=1)
plot(prices.ts[,2])
lines(gas.f.1,col="blue",lw=3)
lines(gas.f.2,col="blue",lw=3)
