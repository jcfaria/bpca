##
## Static 2D bpca workflow with base graphics
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp <- bpca(gabriel1971)

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
          method='sqrt'),
     main='gabriel1971 - sqrt',
     sub='The graphical parameters are working fine!',
     var.cex=.6,
     var.color=rainbow(9),
     var.pch='v',
     obj.pch='o',
     obj.cex=.5,
     obj.col=rainbow(8),
     obj.pos=1,
     obj.offset=.5)

devAskNewPage(oask)
