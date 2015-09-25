library(RColorBrewer)
library(colorRamps)


pdf("rcolorsheet.pdf", paper="a4r", width=11.6, height=8.2, onefile=TRUE)

### page 1

# grDevices::colors
m <- matrix(1:660, 60, 11)
kol <- colors()[m]
op <- par(mar=c(.1, .1, 2, .1))
image(1:11, 1:60, t(m), col=kol, axes=FALSE, ann=FALSE)
txtcol <- ifelse( apply(col2rgb(kol), 2, mean) < 70, "white", "black")
text( as.numeric(col(m)), as.numeric(row(m)), kol, cex=.8, col=txtcol)
mtext("grDevices::colors", 3, cex=2)
par(op)

### page 2
layout(matrix(1:2, 1, 2))

# RColorBrewer
op <- par(mar=c(.1, 5, 2, .1))
display.brewer.all()
mtext("RColorBrewer", 3, cex=2)
par(op)

# ramps
N <- 100 # ramp length
funnames <- c("grDevices::rainbow", "grDevices::heat.colors",
          "grDevices::terrain.colors", "grDevices::topo.colors",
          "grDevices::cm.colors", "colorRamps::blue2red",
          "colorRamps::blue2green", "colorRamps::green2red",
          "colorRamps::blue2yellow", "colorRamps::cyan2yellow",
          "colorRamps::magenta2green", "colorRamps::matlab.like",
          "colorRamps::matlab.like2", "colorRamps::primary.colors",
          "colorRamps::ygobb")
spl <- strsplit(funnames, "::")
pkgs <- sapply(spl, "[", 1)
funs <- sapply(spl, "[", 2)
kolmat <- sapply(funs, do.call, list(N))
mat <- matrix( seq(1, length(kolmat)), nrow(kolmat), ncol(kolmat))
op <- par(mar=c(.1, .1, 2, .1))
image(seq(1, nrow(mat)), seq(1, ncol(mat)), mat, col=kolmat,
      axes=FALSE, ann=FALSE)
text( nrow(mat)/2, seq(1, ncol(mat)), funnames)
mtext("Color ramps", 3, cex=2)
par(op)


dev.off()
