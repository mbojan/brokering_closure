library(igraph)

#============================================================================ 
# Simple chain

g <- graph( c(1,2, 2,3), directed=TRUE)
E(g)$label <- c("cleaning.R", "figure.R")
V(g)$label <- c("raw_data.dat", "cleaned_data.rda", "figure.pdf")

set.seed(4)
g$layout <- layout.sugiyama(g, layer=1:3)$layout

png("chain.png")
op <- par(mar=rep(1,4))
plot(g, edge.label.family="mono", edge.label.color="black",
     vertex.shape="rectangle",
     vertex.color="white",
     edge.arrow.size=.6,
     vertex.size=70,
     vertex.size2=15)
par(op)
dev.off()

