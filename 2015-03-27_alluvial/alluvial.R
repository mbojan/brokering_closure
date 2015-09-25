### mtcars
library(MASS)
library(colorRamps)
library(RColorBrewer)

data(mtcars)
k <- blue2red(100)
x <- cut( mtcars$mpg, 100)

svg("cars.svg", width=6, height=4)
op <- par(mar=c(3, rep(.1, 3)))
parcoord(mtcars, col=k[as.numeric(x)])
par(op)
dev.off()



### Titanic with parallel coordinates
data(Titanic)
titdf <- as.data.frame(lapply(as.data.frame(Titanic), as.numeric))
titdf2 <- titdf[ rep(1:nrow(titdf), titdf$Freq) , ]
titdf2[,6:9] <- lapply(titdf2[,1:4], jitter)
k <- adjustcolor(brewer.pal(3, "Set1")[titdf2$Survived], alpha=.2)

svg("titanic_pc.svg", width=6, height=4)
op <- par(mar=c(3, 1, 1, 1))
parcoord(titdf2[,6:9], col=k)
par(op)
dev.off()






# Titanic data
library(alluvial)
tit <- as.data.frame(Titanic)

# 2d
tit2d <- aggregate( Freq ~ Class + Survived, data=tit, sum)

svg("titanic1.svg", height=6, width=6)
alluvial( tit2d[,1:2], freq=tit2d$Freq, xw=0.0, alpha=0.8,
         gap.width=0.1, col= "steelblue", border="white",
         layer = tit2d$Survived != "Yes" )
dev.off()

svg("titanic2.svg", height=6, width=6)
alluvial( tit2d[,1:2], freq=tit2d$Freq, 
         hide=tit2d$Freq < 150,
         xw=0.0, alpha=0.8,
         gap.width=0.1, col= "steelblue", border="white",
         layer = tit2d$Survived != "Yes" )
dev.off()

# 3d
tit3d <- aggregate( Freq ~ Class + Sex + Survived, data=tit, sum)

svg("titanic3.svg", height=6, width=6)
alluvial(tit3d[,1:3], freq=tit3d$Freq, alpha=1, xw=0.2,
         col=ifelse( tit3d$Survived == "No", "red", "gray"),
         layer = tit3d$Sex != "Female",
         border="white")
dev.off()

# 4d
svg("titanic4.svg", height=6, width=6)
alluvial( tit[,1:4], freq=tit$Freq, border=NA,
         hide = tit$Freq < quantile(tit$Freq, .50),
         col=ifelse( tit$Survived == "No", "red", "gray") )
dev.off()

