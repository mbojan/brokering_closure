library(igraph)
library(intergraph)
library(isnar)

set.seed(123)

Galesburg2
table( V(Galesburg2)$adoption )
V(Galesburg2)$adopted <- V(Galesburg2)$adoption < 999999
table( V(Galesburg2)$adopted )

plot( Galesburg2, vertex.color=ifelse(V(Galesburg2)$adopted, "black", "white"),
      vertex.label.color=ifelse(V(Galesburg2)$adopted, "white", "black"),
      edge.curved=0.2 )

coleman( Galesburg2, "adopted")

m <- as.mixingm(Galesburg2, "adopted", full=TRUE)
d <- as.data.frame( m, stringsAsFactors=FALSE )
vnames <- c("ego", "alter", "tie")
d[ vnames ] <- lapply( d[vnames], as.logical)
d$hom <- with(d, ego==alter)
d$dhom <- with(d, hom * ego)

# independence model
(mod1 <- glm( tie ~ ego + alter, data=d, 
              weight=Freq, family=binomial("logit")))
summary(mod1)

# uniform  homophily
mod2 <- update(mod1, . ~ . + hom)
anova(mod1, mod2, test="Chisq")
summary(mod2)
exp(coef(mod2))
d$fit_m2 <- fitted(mod2, type=)




# Obliczenie Colemana dla grup na podstawie fitted
lg <- table( V(Galesburg2)$adopted)
