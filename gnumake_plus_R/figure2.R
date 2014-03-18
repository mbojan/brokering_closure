library(igraph)

g <- graph( c(1,2, 2,3), directed=TRUE)
E(g)$label <- c("cleaning.R", "figure.R")
V(g)$label <- c("raw_data.dat", "cleaned_data.rda", "figure.pdf")

m <- cbind(rep(1, 1), 3:1)

plot(g, layout=m, rescale=FALSE,
     xlim=c(.5, 1.5), ylim=c(1,3),
     vertex.color="white", vertex.label.color="black",
     edge.label=NA, vertex.shape="none")
text( c(1, 1), c(1.5, 2.5), E(g)$label)
