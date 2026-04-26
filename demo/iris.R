##
## Grouping objects with different symbols and colors - 2d and 3d
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

# 2d
plot(bpca(iris[-5]),
     var.factor=.3, 
     var.cex=.7,
     obj.names=FALSE,
     obj.cex=1.5,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.pch=c('+', '*', '-')[as.numeric(iris$Species)])

# 3d static
plot(bpca(iris[-5],
          d=1:3),
     var.factor=.2,
     var.color=c('blue', 'red'),
     var.cex=1,
     obj.names=FALSE,
     obj.cex=1,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.pch=c('+', '*', '-')[as.numeric(iris$Species)])

devAskNewPage(oask)

# 3d dinamic
plot(bpca(iris[-5],
          d=1:3,
          method='hj'),
     rgl.use=TRUE,
     var.col='brown',
     var.factor=.3,
     var.cex=1.2,
     obj.names=FALSE,
     obj.cex=.5,
     obj.col=c('red', 'green3', 'orange')[as.numeric(iris$Species)],
     simple.axes=FALSE, box=TRUE)

