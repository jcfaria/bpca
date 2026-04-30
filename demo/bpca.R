##
## Computing and plotting a bpca object with base graphics (2D)
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp2 <- bpca(gabriel1971)

plot(bp2)

# Explore the object created by bpca()
class(bp2)
names(bp2)
str(bp2)

summary(bp2)
bp2$call
bp2$eigenvalues
bp2$eigenvectors
bp2$number
bp2$importance
bp2$coord
bp2$coord$objects
bp2$coord$variables
bp2$var.rb
bp2$var.rd

# Additional graphical parameters
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

##
## Computing and plotting a bpca object with scatterplot3d (3D)
##

bp3 <- bpca(gabriel1971,
            d=1:3)

plot(bp3)

# Explore the object created by bpca()
class(bp3)
names(bp3)
str(bp3)

summary(bp3)
bp3$call
bp3$eigenvalues
bp3$eigenvectors
bp3$number
bp3$importance
bp3$coord
bp3$coord$objects
bp3$coord$variables
bp3$var.rb
bp3$var.rd

# Additional graphical parameters
plot(bpca(gabriel1971,
          d=1:3,
          method='jk'),
     main='gabriel1971 - jk',
     sub='The graphical parameters are working fine!',
     var.pch='+',
     var.cex=.6,
     var.color=rainbow(ncol(gabriel1971)),
     obj.pch='*',
     obj.cex=.8,
     obj.col=rainbow(nrow(gabriel1971)),
     ref.lty='solid',
     ref.col='red',
     angle=70)

##
## Computing and plotting with `obj.identify=TRUE` (2D)
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
## Computing and plotting with `obj.identify=TRUE` (3D)
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
       obj.identify=TRUE)
}

##
## Computes: vector variable lengths, angles between vector variables and
## variable correlations from data.frame or matrix objects (n x p)
## n = rows (objects)
## p = columns (variables)
##

dt <- dt.tools(iris,
               center=2) # Non-numeric columns are ignored internally.

# Explore the object created by dt.tools()
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
## Grouping objects with different symbols and colors (2D and 3D)
##

# 2D
plot(bpca(iris[-5]),
     var.cex=.7,
     obj.names=FALSE,
     obj.cex=1.5,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.pch=c('+', '*', '-')[as.numeric(iris$Species)])

# 3D static
plot(bpca(iris[-5],
          d=1:3),
     var.color=c('blue', 'red'),
     var.cex=1,
     obj.names=FALSE,
     obj.cex=1,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.pch=c('+', '*', '-')[as.numeric(iris$Species)])

##
## Example of `var.rb=TRUE` as a biplot quality measure (2D)
##

## Differences between methods of factorization
# SQRT
bp2_sqrt <- bpca(gabriel1971,
                 method='sqrt',
                 var.rb=TRUE)

qbp2_sqrt <- qbpca(gabriel1971,
                   bp2_sqrt)

plot(qbp2_sqrt,
     main='sqrt - 2D \n (poor)')

# JK
bp2_jk <- bpca(gabriel1971,
               method='jk',
               var.rb=TRUE)

qbp2_jk <- qbpca(gabriel1971,
                 bp2_jk)

plot(qbp2_jk,
     main='jk - 2D \n (very poor)')

# GH
bp2_gh <- bpca(gabriel1971,
               method='gh',
               var.rb=TRUE)

qbp2_gh <- qbpca(gabriel1971,
                 bp2_gh)

plot(qbp2_gh,
     main='gh - 2D \n (good)')

# HJ
bp2_hj <- bpca(gabriel1971,
               method='hj',
               var.rb=TRUE)

qbp2_hj <- qbpca(gabriel1971,
                 bp2_hj)

plot(qbp2_hj,
     main='hj - 2D \n (good)')

##
## Example of `var.rb=TRUE` as a biplot quality measure (3D)
##

## Differences between methods of factorization
# SQRT
bp3_sqrt <- bpca(gabriel1971,
                 method='sqrt',
                 d=1:3,
                 var.rb=TRUE)

qbp_sqrt <- qbpca(gabriel1971,
                  bp3_sqrt)

plot(qbp_sqrt,
     main='sqrt - 3D \n (poor)')

# JK
bp3_jk <- bpca(gabriel1971,
               method='jk',
               d=1:3,
               var.rb=TRUE)

qbp3_jk <- qbpca(gabriel1971,
                 bp3_jk)

plot(qbp3_jk,
     main='jk - 3D \n (very poor)')

# GH
bp3_gh <- bpca(gabriel1971,
               method='gh',
               d=1:3,
               var.rb=TRUE)

qbp3_gh <- qbpca(gabriel1971,
                 bp3_gh)

plot(qbp3_gh,
     main='gh - 3D \n (wow!)')

# HJ
bp3_hj <- bpca(gabriel1971,
               method='hj',
               d=1:3,
               var.rb=TRUE)

qbp3_hj <- qbpca(gabriel1971,
                 bp3_hj)

plot(qbp3_hj,
     main='hj - 3D \n (wow!)')

##
## Example of `var.rd=TRUE` as a biplot quality measure (2D)
## Mainly recommended for large datasets.
##

bp <- bpca(gabriel1971,
           method='hj',
           var.rb=TRUE, 
           var.rd=TRUE, 
           limit=3)

bp$var.rd

# RUR followed by CRISTIAN contains information in dimensions that
# wasn't contemplated by the biplot reduction (PC3).
# Among all variables, RUR followed by CRISTIAN is poorly represented in 2D.
# biplot.

# Graphical visualization of the importance of the variables not contemplated
# in the reduction
plot(bpca(gabriel1971,
          method='hj',
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

# Set obj.labels
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

# Set obj.labels
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

# Discriminativeness vs. representativeness
plot(bpca(ontario),
     type='dv')

# Means vs. stability
plot(bpca(ontario),
     type='ms')

# Rank objects with reference to the ideal variable
plot(bpca(ontario),
     type='ro')

# Rank variables with reference to the ideal object
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
     var.factor=.3)

devAskNewPage(oask)

