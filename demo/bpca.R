##
## Computing and plotting a bpca object with 'graphics' package - 2d
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp2 <- bpca(gabriel1971)

plot(bp2)

# Exploring the object 'bp2' created by the function 'bpca'
class(bp2)
names(bp2)
str(bp2)

summary(bp2)
bp2$call
bp2$eigenval
bp2$eigenvec
bp2$numb
bp2$import
bp2$coord
bp2$coord$obj
bp2$coord$var
bp2$var.rb
bp2$var.rd

# Additional graphical parameters (nonsense)
plot(bpca(gabriel1971,
          meth='sqrt'),
     main='gabriel1971 - sqrt',
     sub='The graphical parameters are working fine!',
     var.cex=.6,
     var.col=rainbow(9),
     var.pch='v',
     obj.pch='o',
     obj.cex=.5,
     obj.col=rainbow(8),
     obj.pos=1,
     obj.offset=.5)

##
## Computing and plotting a bpca object with 'scatterplot3d' package - 3d
##

bp3 <- bpca(gabriel1971,
            d=1:3)

plot(bp3)

# Exploring the object 'bp3' created by the function 'bpca'
class(bp3)
names(bp3)
str(bp3)

summary(bp3)
bp3$call
bp3$eigenval
bp3$eigenvec
bp3$numb
bp3$import
bp3$coord
bp3$coord$obj
bp3$coord$var
bp3$var.rb
bp3$var.rd

# Additional graphical parameters (nonsense)
plot(bpca(gabriel1971,
          d=1:3,
          meth='jk'),
     main='gabriel1971 - jk',
     sub='The graphical parameters are working fine!',
     var.pch='+',
     var.cex=.6,
     var.col=rainbow(ncol(gabriel1971)),
     obj.pch='*',
     obj.cex=.8,
     obj.col=rainbow(nrow(gabriel1971)),
     ref.lty='solid',
     ref.col='red',
     angle=70)

##
## Computing and plotting a bpca object with 'obj.identify=TRUE' parameter - 2d
##

bp2 <- bpca(gabriel1971)

# Normal labels
if(dev.interactive()) {
  plot(bp2,
       obj.names=FALSE,
       obj.identify=TRUE)
}  

# Alternative labels
if(dev.interactive()) {
  plot(bp2,
       obj.names=FALSE,
       obj.labels=c('toi', 'kit', 'bat', 'ele', 'wat', 'rad', 'tv', 'ref'),
       obj.identify=TRUE)
}       

##
## Computing and plotting a bpca object with 'obj.identify=TRUE' parameter - 3d
##

bp3 <- bpca(gabriel1971,
           d=1:3)

# Normal labels
if(dev.interactive()) {
  plot(bp3,
       obj.names=FALSE,
       obj.identify=TRUE)
}  

# Alternative labels
if(dev.interactive()) {
  plot(bp3,
       obj.names=FALSE,
       obj.labels=c('toi', 'kit', 'bat', 'ele', 'wat', 'rad', 'tv', 'ref'),
       obj.identify=T)
}

##
## Computes: vector variable lengths, angles between vector variables and
## variable correlations from data.frame or matrix objects (n x p)
## n = rows (objects)
## p = columns (variables)
##

dt <- dt.tools(iris,
               center=2) # No numeric columns are removed in 'dt.tools'

# Exploring the object 'bp' created by the function 'var.tools'
class(dt)
names(dt)
str(dt)

dt$length
dt$angle
dt$r
dt

# Checking the determinations
(iris.tools <- round(dt$r,
                     5))

(iris.obsv  <- round(cor(iris[-5]),
                     5))

all(iris.tools == iris.obsv)

##
## Grouping objects with different symbols and colors - 2d and 3d
##

# 2d
plot(bpca(iris[-5]),
     var.cex=.7,
     obj.names=FALSE,
     obj.cex=1.5,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.pch=c('+', '*', '-')[as.numeric(iris$Species)])

# 3d static
plot(bpca(iris[-5],
          d=1:3),
     var.color=c('blue', 'red'),
     var.cex=1,
     obj.names=FALSE,
     obj.cex=1,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.pch=c('+', '*', '-')[as.numeric(iris$Species)])

##
## Example of 'var.rb=TRUE' parameter as a measure of the quality of the biplot - 2d
##

## Differences between methods of factorization
# SQRT
bp2_sqrt <- bpca(gabriel1971,
                 meth='sqrt',
                 var.rb=TRUE)

qbp2_sqrt <- qbpca(gabriel1971,
                   bp2_sqrt)

plot(qbp2_sqrt,
     main='sqrt - 2d \n (poor)')

# JK
bp2_jk <- bpca(gabriel1971,
               meth='jk',
               var.rb=TRUE)

qbp2_jk <- qbpca(gabriel1971,
                 bp2_jk)

plot(qbp2_jk,
     main='jk - 2d \n (very poor)')

# GH
bp2_gh <- bpca(gabriel1971,
               meth='gh',
               var.rb=TRUE)

qbp2_gh <- qbpca(gabriel1971,
                 bp2_gh)

plot(qbp2_gh,
     main='gh - 2d \n (good)')

# HJ
bp2_hj <- bpca(gabriel1971,
               meth='hj',
               var.rb=TRUE)

qbp2_hj <- qbpca(gabriel1971,
                 bp2_hj)

plot(qbp2_hj,
     main='hj - 2d \n (good)')

##
## Example of 'var.rb=TRUE' parameter as a measure of the quality of the biplot - 3d
##

## Differences between methods of factorization
# SQRT
bp3_sqrt <- bpca(gabriel1971,
                 meth='sqrt',
                 d=1:3,
                 var.rb=TRUE)

qbp_sqrt <- qbpca(gabriel1971,
                  bp3_sqrt)

plot(qbp_sqrt,
     main='sqrt - 3d \n (poor)')

# JK
bp3_jk <- bpca(gabriel1971,
               meth='jk',
               d=1:3,
               var.rb=TRUE)

qbp3_jk <- qbpca(gabriel1971,
                 bp3_jk)

plot(qbp3_jk,
     main='jk - 3d \n (very poor)')

# GH
bp3_gh <- bpca(gabriel1971,
               meth='gh',
               d=1:3,
               var.rb=TRUE)

qbp3_gh <- qbpca(gabriel1971,
                 bp3_gh)

plot(qbp3_gh,
     main='gh - 3d \n (whow!)')

# HJ
bp3_hj <- bpca(gabriel1971,
               meth='hj',
               d=1:3,
               var.rb=TRUE)

qbp3_hj <- qbpca(gabriel1971,
                 bp3_hj)

plot(qbp3_hj,
     main='hj - 3d \n (whow!)')

##
## Example of 'var.rd=TRUE' parameter as a measure of the quality of the biplot - 2d
## Mainly recommended for large datasets.
##

bp <- bpca(gabriel1971,
           meth='hj',
           var.rb=TRUE, 
           var.rd=TRUE, 
           limit=3)

bp$var.rd

# RUR followed by CRISTIAN contains information in dimensions that
# wasn't contemplated by the biplot reduction (PC3).
# Between all, RUR followed by CRISTIAN, variables are bad represented by a 2d
# biplot.

# Graphical visualization of the importance of the variables not contemplated
# in the reduction
plot(bpca(gabriel1971,
          meth='hj',
          d=3:4),
     main='hj')

##
## New options plotting
##
data(ontario)

plot(bpca(ontario))

## Labels for all objects
(obj.lab <- paste('g',
                  1:18,
                  sep=''))

# Giving obj.labels
plot(bpca(ontario),
    obj.labels=obj.lab) 

# Evaluate an object (1 is the default)
plot(bpca(ontario),
     type='eo',
     obj.cex=1)

plot(bpca(ontario),
     type='eo',
     obj.id=7,
     obj.cex=1)

# Giving obj.labels
plot(bpca(ontario),
     type='eo',
     obj.labels=obj.lab,
     obj.id=7,
     obj.cex=1)

# The same as above
plot(bpca(ontario),
     type='eo',
     obj.labels=obj.lab,
     obj.id='g7',
     obj.cex=1)

# Evaluate a variable (1 is the default)
plot(bpca(ontario),
     type='ev',
     var.cex=1)

plot(bpca(ontario),
     type='ev',
     var.id='E7',
     obj.labels=obj.lab,
     var.cex=1)

# A complete plot
cl <- 1:3

plot(bpca(iris[-5]),
     type='ev',
     var.id=1,
     obj.names=FALSE,
     obj.col=cl[as.numeric(iris$Species)])

legend('topleft',
       legend=levels(iris$Species),
       text.col=cl,
       pch=19,
       col=cl,
       cex=.9,
       box.lty=0)   

# Compare two objects (1 and 2 are the default)
plot(bpca(ontario),
     type='co')

plot(bpca(ontario),
     type='co',
     obj.labels=obj.lab)

plot(bpca(ontario),
     type='co',
     obj.labels=obj.lab,
     obj.id=13:14)

plot(bpca(ontario),
     type='co',
     obj.labels=obj.lab,
     obj.id=c('g7', 'g13'))

# Compare two variables
plot(bpca(ontario),
     type='cv')

# Which won where/what
plot(bpca(ontario),
     type='ww')

# Discrimitiveness vs. representativeness
plot(bpca(ontario),
     type='dv')

# Means vs. stability
plot(bpca(ontario),
     type='ms')

# Rank objects with ref. to the ideal variable 
plot(bpca(ontario),
     type='ro')

# Rank variables with ref. to the ideal object
plot(bpca(ontario),
     type='rv')

plot(bpca(iris[-5]),
     type='eo',
     obj.id=42,
     obj.cex=1)

plot(bpca(iris[-5]),
     type='ev',
     var.id='Sepal.Width')

plot(bpca(iris[-5]),
     type='ev',
     var.id='Sepal.Width',
     var.fac=.3)

devAskNewPage(oask)

