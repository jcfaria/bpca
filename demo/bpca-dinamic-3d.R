##
## Interactive 3D bpca workflow with rgl
##

# rgl::open3d()
plot(pca <- bpca(iris[-5],
                 d=1:3),
     rgl.use=TRUE,
     var.color='brown',
     var.cex=1.2,
     obj.names=FALSE,
     obj.cex=.3,
     obj.col=c('blue', 'green', 'red')[as.numeric(iris$Species)],
     simple.axes=TRUE)

scores <- pca$coord$objects

ell <- rgl::ellipse3d(cov(scores),
                      center=colMeans(scores),
                      level=0.68)

rgl::plot3d(ell,
            col='gray',
            alpha=0.2,
            add=TRUE)

rgl::play3d(rgl::spin3d(axis=c(1,2,3)),
            duration=12)

# This graphic style was suggested by Michael Friendly (York University).
# Tip: interact with the graphic using the mouse.
# left button: click and drag to rotate;
# right button: click and drag to zoom.

