##
## Computing and plotting a bpca object with 'scatterplot3d' package - 3d
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp <- bpca(gabriel1971,
           d=1:3)

plot(bp)

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
          d=1:3,
          meth='jk'),
     main='gabriel1971 - jk',
     sub='The graphical parameters are working fine!',
     var.pch='+',
     var.cex=.6,
     var.col=rainbow(9),
     obj.pch='*',
     obj.cex=.8,
     obj.col=rainbow(8),
     ref.lty='solid',
     ref.col='red',
     angle=70)

##
## Computing and plotting a bpca object with arbitrary choice of the first eigenvalue - 3d
##

bp <- bpca(gabriel1971,
           d=2:4)

plot(bp)

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
     angle=65)

devAskNewPage(oask)

