### mtcars
library(MASS)
library(colorRamps)

data(mtcars)

k <- blue2red(100)
x <- cut( mtcars$mpg, 100)

svg("pc_mtcars.svg")
parcoord(mtcars, col=k[as.numeric(x)])
dev.off()



### Titanic with parallel coordinates
data(Titanic)
titdf <- as.data.frame(lapply(as.data.frame(Titanic), as.numeric))
titdf[,1:4] <- lapply(titdf[,1:4], jitter)

parcoord(titdf, col=as.numeric


