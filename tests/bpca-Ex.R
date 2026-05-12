# bpca-Ex.R — exemplos agregados dos arquivos man/*.Rd
# Gerado com tools:::Rd2ex() a partir de cada .Rd com secao \examples.
# Antes em \dontrun (prefixo ##D) — descomentado para execucao manual.
# Carregue o pacote antes: devtools::load_all() ou library(bpca).


# ---- bpca-package.Rd ----

### Name: bpca-package
### Title: Biplot of Multivariate Data Based on Principal Component
###   Analysis
### Aliases: bpca-package
### Keywords: package multivariate

### ** Examples

##
## Grouping objects with different symbols and colors (2D and 3D)
##

dev.new(w=6, h=6)
oask <- devAskNewPage(dev.interactive(orNone=TRUE))

# 2D
plot(bpca(iris[-5]),
     var.pos=c(4, 2, 3, 1),
     var.offset=.3,
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

# 3D dynamic
plot(bpca(iris[-5],
          method='hj',
          d=1:3),
     rgl.use=TRUE,
     var.col=c('blue', 'red'),
     var.cex=1.2,
     obj.names=FALSE,
     obj.cex=.8,
     obj.col=c('red', 'green3', 'orange')[as.numeric(iris$Species)],
     simple.axes=FALSE,
     box=TRUE)

##
## New plotting options
##
plot(bpca(ontario))

# Labels for all objects
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
     obj.col=cl[as.numeric(iris$Species)],
     obj.cex=1)

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
     var.id='Sepal.Length')

devAskNewPage(oask)




# ---- bpca.Rd ----

### Name: bpca
### Title: Biplot of Multivariate Data Based on Principal Component
###   Analysis
### Aliases: bpca bpca.default bpca.prcomp
### Keywords: multivariate

### ** Examples

##
## Example 1
## Compute and plot a bpca object with base graphics (2D)
##

bp <- bpca(gabriel1971)

dev.new(w=6, h=6)
oask <- devAskNewPage(dev.interactive(orNone=TRUE))
plot(bp)

# Explore the object created by bpca()
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

##
## Example 2
## Compute and plot a bpca object with scatterplot3d (3D)
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
bp$eigenval
bp$eigenvec
bp$numb
bp$import
bp$coord
bp$coord$obj
bp$coord$var
bp$var.rb
bp$var.rd

##
## Example 3
## Compute and plot a bpca object with rgl (3D)
##

plot(bpca(gabriel1971,
          d=1:3),
     rgl.use=TRUE)

# Tip: interact with the graphic using the mouse
# left button: click and drag to rotate;
# right button: click and drag to zoom.

##
## Example 4
## Group objects using different symbols and colors (2D and 3D)
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

# 3D dynamic
plot(bpca(iris[-5],
          method='hj',
          d=1:3),
     rgl.use=TRUE,
     var.col=c('blue', 'red'),
     var.cex=1.2,
     obj.names=FALSE,
     obj.cex=.8,
     obj.col=c('red', 'green3', 'orange')[as.numeric(iris$Species)],
     simple.axes=FALSE,
     box=TRUE)

devAskNewPage(oask)       




# ---- dt.tools.Rd ----

### Name: dt.tools
### Title: Data Tools for Multivariate Analysis
### Aliases: dt.tools
### Keywords: multivariate

### ** Examples

##
## Computes vector lengths, angles between variable vectors,
## and variable correlations from data.frame or matrix objects (n x p)
## n = rows (objects)
## p = columns (variables)
##

dt <- dt.tools(iris,
               2)  # Non-numeric columns are ignored internally.

# Explore the object created by dt.tools()
class(dt)
names(dt)
str(dt)

dt$length
dt$angle
dt$r
dt

# Checking the determinations
(iris.tools <- round(dt.tools(iris,
                              center=2)$r,
                     5))

(iris.obsv  <- round(cor(iris[-5]),
                     5))

all(iris.tools == iris.obsv)




# ---- gabriel1971.Rd ----

### Name: gabriel1971
### Title: Percentages of households having various facilities and
###   appliances in East Jerusalem Arab areas, by quarters of the town
### Aliases: gabriel1971
### Keywords: datasets

### ** Examples

##
## A simple example
##
data(gabriel1971)
bp <- bpca(gabriel1971)

dev.new(w=6, h=6)
plot(bp)

# Explore the object created by bpca()
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




# ---- gge2003.Rd ----

### Name: gge2003
### Title: A didactic matrix of genotypes (rows) and environments (columns)
### Aliases: gge2003
### Keywords: datasets

### ** Examples

##
## Example from Yan and Kang (2003), GGE biplot analysis
## for breeders, geneticists, and agronomists
##

data(gge2003)
bp <- bpca(t(gge2003), var.rb=TRUE)

as.dist(bp$var.rb)

dev.new(w=8, h=4)
op = par(no.readonly=TRUE)
par(mfrow=c(1,2))

plot(bpca(gge2003),
     main='Columns as variables',
     var.col=1,
     obj.col=2:4,
     obj.cex=.8)

plot(bpca(t(gge2003)),
     main='Rows as variables',
     var.col=1,
     obj.col=c(2:4, 2),
     obj.cex=.8)

par(op)


# ---- ontario.Rd ----

### Name: ontario
### Title: Ontario winter wheat (1993)
### Aliases: ontario
### Keywords: datasets

### ** Examples

data(ontario)

# 2D
plot(bpca(ontario,
          d=1:2))

# 3D
plot(bpca(ontario,
          d=1:3),
     rgl.use=TRUE)




# ---- plot.Rd ----

### Name: plot
### Title: Biplot of Multivariate Data Based on Principal Component
###   Analysis
### Aliases: plot.bpca.2d plot.bpca.3d plot.qbpca
### Keywords: multivariate

### ** Examples


# To avoid overlap in a 2D biplot by manually positioning labels:
# Suppose we have 4 variables and want to position them differently
plot(bpca(ontario),
     var.pos = c(1, 3, 4, 2),
     var.offset = 0.5)

# For 3D dynamic plots with custom offsets:
if(interactive()) {
  plot(bpca(ontario, d=1:3),
       rgl.use = TRUE,
       var.pos = 3,
       var.offset = 0.8)
}

##
## Example 1
## Computing and plotting a bpca object with base graphics (2D)
##

bp <- bpca(gabriel1971)

dev.new(w=6, h=6)
oask <- devAskNewPage(dev.interactive(orNone=TRUE))
plot(bp)

# To avoid overlap in a 2D biplot by manually positioning labels
plot(bp,
     var.pos=c(1,
               3,
               rep(4, 7)),
     var.offset=.3)

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
## Example 2
## Computing and plotting a bpca object with scatterplot3d (3D)
##

bp <- bpca(gabriel1971,
           d=1:3)

plot(bp,
     var.col=rainbow(9))

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
     ref.lty='dotted',
     ref.col=gray(.6),
     angle=70)

##
## Example 3
## Computing and plotting a bpca object with rgl (3D)
##

plot(bpca(gabriel1971,
          d=1:3),
     rgl.use=TRUE)

# Tip: interact with the graphic using the mouse
# left button: click and drag to rotate;
# right button: click and drag to zoom.

##
## Example 4
## Grouping objects with different symbols and colors (2D and 3D)
##

# 2D
plot(bpca(iris[-5]),
     var.cex=.7,
     obj.names=FALSE,
     obj.cex=1.5,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.pch=c('+', '*', '-')[as.numeric(iris$Species)])

plot(bpca(iris[-5]),
     var.cex=.7,
     var.pos=c(4, 2, 3, 1),
     var.offset=.3,
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

# 3D dynamic
plot(bpca(iris[-5],
          method='hj',
          d=1:3),
     rgl.use=TRUE,
     var.col=c('blue', 'red'),
     var.cex=1.2,
     obj.names=FALSE,
     obj.cex=.8,
     obj.col=c('red', 'green3', 'orange')[as.numeric(iris$Species)])

##
## Example 5
## Computing and plotting a bpca object with `obj.identify=TRUE` (2D)
##

bp <- bpca(gabriel1971)

# Normal labels
if(interactive())
plot(bp,
     obj.names=FALSE,
     obj.identify=TRUE)

# Alternative labels
if(interactive())
plot(bp,
     obj.names=FALSE,
     obj.labels=c('toi', 'kit', 'bat', 'ele', 'wat', 'rad', 'tv', 'ref'),
     obj.identify=TRUE)

##
## Example 6
## Computing and plotting a bpca object with `obj.identify=TRUE` (3D)
##

bp <- bpca(gabriel1971,
           d=1:3)

# Normal labels
if(interactive())
plot(bp,
     obj.names=FALSE,
     obj.identify=TRUE)

# Alternative labels
if(interactive())
plot(bp,
     obj.names=FALSE,
     obj.labels=c('toi', 'kit', 'bat', 'ele', 'wat', 'rad', 'tv', 'ref'),
     obj.identify=TRUE)

##
## New plotting options
##
plot(bpca(ontario))

# Labels for all objects
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
     var.fac=.3,
     obj.names=FALSE,
     obj.cex=.9,
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
     type='co',
     c.radio=.4,
     c.color='blue',
     c.lwd=2)

plot(bpca(ontario),
     type='co',
     obj.labels=obj.lab,
     c.radio=.5,
     c.color='blue',
     c.lwd=2)

plot(bpca(ontario),
     type='co',
     obj.labels=obj.lab,
     obj.id=13:14)

plot(bpca(ontario),
     type='co',
     obj.labels=obj.lab,
     obj.id=c('g7', 
              'g13'))

# Compare two variables
plot(bpca(ontario),
     type='cv',
     c.number=3,
     c.radio=1.5)

# Which won where/what
plot(bpca(ontario),
     type='ww')

# Discriminativeness vs. representativeness
plot(bpca(ontario),
     type='dv')

plot(bpca(ontario),
     type='dv',
     c.number=4,
     c.radio=1)

# Means vs. stability
plot(bpca(ontario),
     type='ms')

plot(bpca(ontario),
     type='ms',
     c.number=3)

# Rank objects with reference to the ideal variable
plot(bpca(ontario),
     type='ro')

plot(bpca(ontario),
     type='ro',
     c.number=6,
     c.radio=.5)

# Rank variables with reference to the ideal object
plot(bpca(ontario),
     type='rv')

plot(bpca(ontario),
     type='rv',
     c.number=6,
     c.radio=.5)

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




# ---- print.xtable.Rd ----

### Name: print.xtable
### Title: Print Method for xtable.bpca Objects
### Aliases: print.xtable print.xtable.bpca print.xtable.default
### Keywords: multivariate

### ** Examples


## Example 1: Principal labels in Portuguese
library(xtable)

bp2 <- bpca(gabriel1971)  
tbl <- xtable(bp2)
rownames(tbl) <- gsub('Eigenvectors','Autovetores',rownames(tbl))
rownames(tbl) <- c(rownames(tbl)[1:9],'Autovalores','Variância retida','Variância acumulada')
dimnames(tbl)[[2]] <- c('CP 1','CP 2')

print(tbl)

## Example 2: With bold in the column  
tbl1 <- xtable(bp2)
bold <- function(x){
  paste('\textbf{',
        x, 
        '}')
}

print(tbl1,
      sanitize.colnames.function = bold)

# Example 3: With italic row labels
tbl2 <- xtable(bp2)
italic <- function(x){
  paste('& \textit{',
        x, 
        '}')
} # The "&" keeps the correct number of table columns.

print(tbl2,
      sanitize.rownames.function = italic)

## HTML table (e.g. R Markdown HTML): pass type via print()
print(tbl,
      type = "html")




# ---- qbpca.Rd ----

### Name: qbpca
### Title: Quality of the Representation of Variables by Biplot
### Aliases: qbpca
### Keywords: multivariate

### ** Examples

##
## Example 1
## Example of the `var.rb=TRUE` parameter as a quality measure (2D)
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

## Differences between methods of factorization
# SQRT
bp1 <- bpca(gabriel1971,
            meth='sqrt',
            var.rb=TRUE)

qbp1 <- qbpca(gabriel1971,
              bp1)

plot(qbp1,
     main='sqrt - 2D \n (poor)')


# JK
bp2 <- bpca(gabriel1971,
            meth='jk',
            var.rb=TRUE)

qbp2 <- qbpca(gabriel1971,
              bp2)

plot(qbp2,
     main='jk - 2D \n (very poor)')


# GH
bp3 <- bpca(gabriel1971,
            meth='gh',
            var.rb=TRUE)

qbp3 <- qbpca(gabriel1971,
              bp3)

plot(qbp3,
     main='gh - 2D \n (good)')


# HJ
bp4 <- bpca(gabriel1971,
            meth='hj',
            var.rb=TRUE)

qbp4 <- qbpca(gabriel1971,
             bp4)

plot(qbp4,
     main='hj - 2D \n (good)')

##
## Example 2
## Example of the `var.rb=TRUE` parameter as a quality measure (3D)
##

## Differences between methods of factorization
# SQRT
bp1 <- bpca(gabriel1971,
            meth='sqrt',
            d=1:3,
            var.rb=TRUE)

qbp1 <- qbpca(gabriel1971,
              bp1)

plot(qbp1,
     main='sqrt - 3D \n (poor)')


# JK
bp2 <- bpca(gabriel1971,
            meth='jk',
            d=1:3,
            var.rb=TRUE)

qbp2 <- qbpca(gabriel1971,
             bp2)

plot(qbp2,
     main='jk - 3D \n (very poor)')


# GH
bp3 <- bpca(gabriel1971,
            meth='gh',
            d=1:3,
            var.rb=TRUE)

qbp3 <- qbpca(gabriel1971,
              bp3)

plot(qbp3,
     main='gh - 3D \n (wow!)')


# HJ
bp4 <- bpca(gabriel1971,
            meth='hj',
            d=1:3,
            var.rb=TRUE)

qbp4 <- qbpca(gabriel1971,
              bp4)

plot(qbp4,
     main='hj - 3D \n (wow!)')

devAskNewPage(oask)  




# ---- summary.bpca.Rd ----

### Name: summary.bpca
### Title: Summary Method for bpca Objects
### Aliases: summary.bpca
### Keywords: bpca summary multivariate

### ** Examples

##
## Example 1
## bpca - 2D
##
# bpca
bp <- bpca(gabriel1971)
summary(bp)
summary(bp,
        presentation=TRUE)

##
## Example 2
## bpca - 3D
##
bp <- bpca(gabriel1971,
           d=1:3)

# bpca
sm <- summary(bp)
str(sm)
sm
summary(bp,
        presentation=TRUE)




# ---- var.rbf.Rd ----

### Name: var.rbf
### Title: Projected Correlations by BPCA
### Aliases: var.rbf
### Keywords: multivariate

### ** Examples

##
## Direct use
##

bp1 <- bpca(gabriel1971)
bp1$var.rb # NA

# Compute correlations of all variables under the biplot projection
(res <- var.rbf(bp1$coord$var)) 

##
## Typical use
##

bp2 <- bpca(gabriel1971,
            var.rb=TRUE)

bp2$var.rb




# ---- var.rdf.Rd ----

### Name: var.rdf
### Title: Diagnostic of Projected Correlations
### Aliases: var.rdf
### Keywords: multivariate

### ** Examples

##
## Example 1
## Diagnostic of representation quality for the gabriel1971 dataset
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp1 <- bpca(gabriel1971,
            meth='hj',
            var.rb=TRUE)

(res <- var.rdf(gabriel1971,
                bp1$var.rb,
                lim=3))
class(res)

##
## Example 2
## Diagnostic of representation quality using `var.rd`
##

bp2 <- bpca(gabriel1971,
            meth='hj',
            var.rb=TRUE,
            var.rd=TRUE,
            limit=3)

plot(bp2,
     var.factor=2)

bp2$var.rd

bp2$eigenvectors

# Graphical visualization of variable importance not represented
# in the selected reduction
plot(bpca(gabriel1971,
          meth='hj',
          d=3:4),
     main='hj')

# Interpretation:
# RUR followed by CRISTIAN contains information in dimensions not captured
# by the 2D biplot reduction (mainly PC3).
# Among all variables, RUR and CRISTIAN are the most poorly represented
# in a 2D biplot.

##
## Example 3
## Diagnostic of iris representation quality using `var.rd`
##

bp3 <- bpca(iris[-5],
            var.rb=TRUE,
            var.rd=TRUE,
            limit=3)

plot(bp3,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     var.factor=.3)

bp3$var.rd
bp3$eigenvectors

# Graphical diagnostic
plot(bpca(iris[-5],
          d=3:4),
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.names=FALSE)

# Interpretation:
# Sepal.Length followed by Petal.Width contains information in dimensions
# (mainly PC3) that is not fully captured by the PC1-PC2 reduction.
# Therefore, among all variables, these are the most poorly represented
# by a 2D biplot.

bp4 <- bpca(iris[-5],
            d=1:3,
            var.rb=TRUE,
            var.rd=TRUE,
            limit=2)

plot(bp4,
     obj.names=FALSE,
     obj.pch=c('+', '-', '*')[as.numeric(iris$Species)],
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.cex=1)

bp4$var.rd
bp4$eigenvectors

round(bp3$var.rb, 2)

round(cor(iris[-5]), 2)

# Good representation of all variables with a 3D biplot.

devAskNewPage(oask)




# ---- xtable.bpca.Rd ----

### Name: xtable.bpca
### Title: LaTeX Table for Biplot Results
### Aliases: xtable.bpca
### Keywords: multivariate table latex bpca

### ** Examples

## Example 1: Simplest use
library(xtable)

bp <- bpca(iris[-5],
           d=1:3)

xtable::xtable(bp)

## Example 2: With caption and label
bp2 <- bpca(gabriel1971) 

xtable::xtable(bp2,
       caption='Biplot gabriel1971',
       label='example_2')



