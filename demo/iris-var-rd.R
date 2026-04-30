##
## Diagnostic of iris representation with `var.rd` parameter (2D and 3D)
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp2 <- bpca(iris[-5],
            var.rb=TRUE,
            var.rd=TRUE,
            limit=3)

plot(bp2,
     obj.names=FALSE,
     obj.pch=c('+', '-', '*')[unclass(iris$Species)],
     obj.col=c('red', 'green3', 'blue')[unclass(iris$Species)],
     obj.cex=1)

bp2$var.rd
bp2$eigenvectors

# Graphical diagnostic
plot(bpca(iris[-5],
          d=3:4),
     obj.names=FALSE,
     obj.pch=c('+', '-', '*')[unclass(iris$Species)],
     obj.col=c('red', 'green3', 'blue')[unclass(iris$Species)],
     obj.cex=1)

# Interpretation:
# Sepal.length followed by Petal.Width contains information in dimensions
# (PC3 is essentially a contrast between both) that was not fully
# captured by the biplot reduction (PC1 and PC2).
# Therefore, among all variables, they have a poor representation in 2D
# biplot.

bp3 <- bpca(iris[-5],
            d=1:3,
            var.rb=TRUE,
            var.rd=TRUE,
            limit=2)

plot(bp3,
     obj.names=FALSE, 
     obj.pch=c('+', '-', '*')[unclass(iris$Species)],
     obj.col=c('red', 'green3', 'blue')[unclass(iris$Species)],
     obj.cex=1)

bp3$var.rd
bp3$eigenvectors

round(bp3$var.rb,
      2)

round(cor(iris[-5]),
      2)

# Good representation of all variables with a 3D biplot.

devAskNewPage(oask)

