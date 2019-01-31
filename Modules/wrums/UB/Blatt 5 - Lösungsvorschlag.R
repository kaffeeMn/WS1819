#####################################
#        WRUMS WS 2018/2019         #
#  Loesungsvorschlag fuer Blatt 5   #
#####################################

## Aufgabe 13:
# (i)
x <- c(11,12,13)
y <- c(3,2,1)
## X ist immer groesser als Y, jedoch sind die beiden klar negativ korreliert.
cor(x,y, method="spearman") # -1
cor(x,y, method="pearson") # -1

# (ii)
x <- sample(1:100, 60, replace=T)
# steil:
y1 <- 5 + 3*x + rnorm(60, mean=0, sd=30)
# nicht steil: 
y2 <- 5 + x + rnorm(60, mean=0, sd=5)
par(mfrow=c(1,2))
plot(x,y1, ylim=c(0,330))
abline(lm(y1~x)$coefficients)
plot(x,y2, ylim=c(0,330))
abline(lm(y2~x)$coefficients)
cor(x,y1)
cor(x,y2)

# (iii)
x <- sample(100, 50, replace=T)
x
rank(x)
rank(2*x + 5)
rank(2*x + 5) == rank(x)
all(rank(2*x + 5) == rank(x))
y <- sample(100, 50, replace=T)
cor(x,y, method="spearman")
cor(-2*x,y, method="spearman")

# (iv)
## Beispiele im Bereich r=0:
set.seed(9)
x <- runif(100, 0, 1)
y <- runif(100, 0, 1)
cor(x,y, method="pearson")
cor(x,y, method="spearman")

## oder Extrembeispiel:
x <- 1:100
y <- c(1:99, -10e16)
cor(x,y, method="pearson")
cor(x,y, method="spearman")


# (v) 
## Siehe z.B. Aufgabe 11.
K <- matrix(c(1050, 1010, 919, 993, 1076, 1205, 1325, 1393, 1399, 1554,
              39.7, 41.9, 44.6, 46.8, 49.8, 53.1, 56.9, 61.8, 65.8, 67.1),
            byrow=TRUE, nrow=2)
cor(K[1,], K[2,], method="pearson") # 0.9395
cor(K[1,], K[2,], method="spearman") # 0.8909

# (vi) -
# (vii)

x <- 1:100
y <- 1:100
cor(x,y, method="spearman") # 1
cor(x,y, method="pearson") # 1
y[100] <- -10^16
cor(x,y, method="spearman") # 1
cor(x,y, method="pearson") # 0.1723
