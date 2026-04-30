##
## Computing and plotting a bpca object with scatterplot3d (3D)
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

# Additional graphical parameters
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
## Computing and plotting a bpca object with an arbitrary starting dimension (3D)
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

