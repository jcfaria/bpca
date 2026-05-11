##
## Static 3D bpca workflow with scatterplot3d
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp <- bpca(gabriel1971,
           d=1:3)

plot(bp)

# Explore the object created by bpca()
class(bp)
names(bp)
str(bp)

summary(bp)
bp$call
bp$eigenvalues
bp$eigenvectors
bp$number
bp$importance
bp$coord
bp$coord$objects
bp$coord$variables
bp$var.rb
bp$var.rd

# Example with customized graphical parameters
plot(bpca(gabriel1971,
          d=1:3,
          method='jk'),
     main='gabriel1971 - jk',
     sub='The graphical parameters are working fine!',
     var.pch='+',
     var.cex=.6,
     var.color=rainbow(9),
     obj.pch='*',
     obj.cex=.8,
     obj.col=rainbow(8),
     ref.lty='solid',
     ref.col='red',
     angle=70)

##
## Alternative 3D reduction using a different starting dimension
##

bp <- bpca(gabriel1971,
           d=2:4)

plot(bp)

# Explore the object created by bpca()
class(bp)
names(bp)
str(bp)

summary(bp)
bp$call
bp$eigenvalues
bp$eigenvectors
bp$number
bp$importance
bp$coord
bp$var.rb
bp$var.rd

# Changing the angle between x (PC2) and y (PC3) axis
plot(bp,
     angle=65)

devAskNewPage(oask)

