s <- seq(0.01,0.99,0.01)
s

qn <- qnorm(s)
qn

sf <- data.frame(p = s, q = qn)
sf

sample <- rnorm(200)
sample

quantile(sample, probs = s)

# qqnorm
par(mfrow=c(1,1))
trees
qqnorm(trees$Height)

qqnorm(randu$x)

# qqplot
randu
n <- length(randu$x)
n
y <- qunif(ppoints(n))
y
qqplot(y,randu$x)

chi3 <- qchisq(ppoints(30),df=3)
n30 <- qnorm(ppoints(30))
qqplot(n30,chi3)

cauchy <- qcauchy(ppoints(30))
qqplot(n30,cauchy)

par(mfrow=c(1,2))
x <- seq(-3,3,0.01)
plot(x,dnorm(x))
plot(x,pnorm(x))

plot(x,dchisq(x,df=3))
plot(x,pchisq(x,df=3))

plot(x,dcauchy(x))
plot(x,pcauchy(x))
