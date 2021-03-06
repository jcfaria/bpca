##
## Computing and plotting a bpca object with 'graphics' package - 2d
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp <- bpca(gabriel1971)

plot(bp,
     var.factor=2)

# Exploring the object 'bp' created by the function 'bpca'
class(bp)
names(bp)
str(bp)

summary(bp)
bp$call
bp$eigenval
bp$eigenvec
bp$numb
bp$import
bp$coord
bp$coord$obj
bp$coord$var
bp$var.rb
bp$var.rd

# Additional graphical parameters (nonsense)
plot(bpca(gabriel1971,
          meth='sqrt'),
     main='gabriel1971 - sqrt',
     sub='The graphical parameters are working fine!',
     var.factor=2,
     var.cex=.6,
     var.col=rainbow(9),
     var.pch='v',
     obj.pch='o',
     obj.cex=.5,
     obj.col=rainbow(8),
     obj.pos=1,
     obj.offset=.5)

##
## Computing and plotting a bpca object with arbitrary choice of the first eigenvalue - 3d
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp <- bpca(gabriel1971,
           d=2:4)

plot(bp,
     var.factor=2,
     xlim=c(-2,2),
     ylim=c(-2,2),
     zlim=c(-2,2))

# Exploring the object 'bp' created by the function 'bpca'
class(bp)
names(bp)
str(bp)

summary(bp)
bp$call
bp$eigenval
bp$eigenvec
bp$number
bp$import
bp$coord
bp$var.rb
bp$var.rd

# Changing the angle between x (PC2) and y (PC3) axis
plot(bp,
     var.factor=2,
     angle=65,
     xlim=c(-2,2),
     ylim=c(-2,2),
     zlim=c(-2,2))

devAskNewPage(oask)
