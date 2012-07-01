\name{plot}
\alias{plot.bpca.2d}
\alias{plot.bpca.3d}
\alias{plot.qbpca}

\title{Biplot of Multivariate Data Based on Principal Components Analysis}

\description{
  These are methods for objects of class \code{bpca.2d}, \code{bpca.3d} and
  \code{qbpca}.
}

\usage{
  \method{plot}{bpca.2d}(x,
     type=c('bp', 'eo', 'ev', 'co', 'cv', 'ww', 'dv', 'ms', 'ro', 'rv'),
     circles.number=5,
     circles.color='darkgray',
     circles.lwd=1,
     radio=.2,
     obj.id=1:2,
     var.id=1,
     base.color='red3',
     base.lty='dotted',
     proj.color='gray',
     proj.lty='dotted',
     arrow.color='black',
     arrow.lty='solid',
     arrow.lwd=1,
     arrow.length=.2,
     ref.lines=TRUE,
     ref.color='navy',
     ref.lty='dotted',
     var.factor=1,
     var.color='red3',
     var.lty='solid',
     var.pch=20,
     var.pos=4,
     var.cex=.6,
     var.offset=.2,
     obj.factor=1,
     obj.color='black',
     obj.pch=20,
     obj.pos=4,
     obj.cex=.6,
     obj.offset=.2,
     obj.names=TRUE,
     obj.labels,
     obj.identify=FALSE,
     xlim, ylim, xlab, ylab, \dots)

  \method{plot}{bpca.3d}(x,
     rgl.use=FALSE,
     ref.lines=TRUE,
     ref.color='navy',
     ref.lty=ifelse(rgl.use, NA, 'dotted'),
     clear3d=ifelse(rgl.use, TRUE, NULL),
     simple.axes=ifelse(rgl.use, TRUE, NULL),
     aspect=ifelse(rgl.use, c(1, 1, 1), NULL),
     var.factor=1,
     var.color='red3',
     var.lty=ifelse(rgl.use, NA, 'solid'),
     var.pch=ifelse(rgl.use, NULL, 20),
     var.pos=ifelse(rgl.use, 0, 4),
     var.cex=ifelse(rgl.use, .8, .6),
     var.offset=ifelse(rgl.use, NULL, .2),
     obj.color='black',
     obj.pch=ifelse(rgl.use, NULL, 20),
     obj.pos=ifelse(rgl.use, 0, 4),
     obj.cex=ifelse(rgl.use, .8, .6),
     obj.offset=ifelse(rgl.use, NULL, .2),
     obj.names=TRUE,
     obj.labels,
     obj.identify=FALSE,
     box=FALSE,
     angle=ifelse(rgl.use, NULL, 40),
     xlim, ylim, zlim, xlab, ylab, zlab, \dots)

  \method{plot}{qbpca}(x,
     xlab='Index',
     ylab='r',
     pch=c(1,8),
     col=c(4,2), \dots)
}

\arguments{
  \item{x}{A \code{bpca.2d}, \code{bpca.3d} or \code{qbpca} object.}
  \item{type}{Type of biplot: \cr
              \code{bp}: conventional biplot; \cr
              \code{eo}: evaluate an object; \cr
              \code{ev}: evaluate a variable; \cr
              \code{co}: compare two objects; \cr
              \code{cv}: compare (relationship among) variables; \cr
              \code{ww}: which won where/what; \cr
              \code{dv}: discrimitivenss vs. representativeness; \cr
              \code{ms}: mean vs. stability; \cr
              \code{ro}: rank objects with ref. to an "ideal" variable; \cr
              \code{rv}: rank variables with ref. to an "ideal" object.}
  \item{circles.number}{The number of circles.}
  \item{circles.color}{\dots .}
  \item{circles.lwd}{\dots .}
  \item{radio}{\dots .}
  \item{obj.id}{An object(s) number(s) or name(s). It is used to identify the object(s) when the \code{type} option is
    \code{'eo'} or \code{'co'}. The default is \code{1} for \code{'eo'} and \code{1:2} for \code{'co'}.}
  \item{var.id}{A variable number or name. It is used to identify the variable when the \code{type} option is \code{'ev'}.}
  \item{base.color}{\dots .}
  \item{base.lty}{\dots .}
  \item{proj.color}{\dots .}
  \item{proj.lty}{\dots .}
  \item{arrow.color}{\dots .}
  \item{arrow.lty}{\dots .}
  \item{arrow.lwd}{\dots .}
  \item{arrow.length}{\dots .}
  \item{rgl.use}{A logical value. If TRUE the 3d scatter will be done with the
    \code{rgl} environment, in another way the \code{scatterplot3d}
    will be used.}
  \item{ref.lines}{A logical value. If TRUE, the reference lines will be added
    to the biplot.}
  \item{ref.color}{Line color for reference lines.}
  \item{ref.lty}{Line type of the reference lines.}
  \item{clear3d}{A logical value. It clears (or not) a 3d biplot before making
    a new one. Used only if \code{rgl.use=TRUE}.}
  \item{simple.axes}{A logical value to draw simple axes.
    Used only if \code{rgl.use=TRUE}.}
  \item{aspect}{A vector of the apparent ratios of the x, y, and z axes of the
    bounding box. Used only if \code{rgl.use=TRUE}.}
  \item{var.factor}{Factor of expansion/reduction of length lines of the
    variables.}
  \item{var.color}{A vector of colors for the variables representation.}
  \item{var.lty}{Line type for the variables. Used only if \code{rgl.use=FALSE}.}
  \item{var.pch}{A vector of plotting symbols or characters for the variables.
    If too short, the values are recycled. Used only if \code{rgl.use=FALSE}.}
  \item{var.pos}{Position of labels for the variables.}
  \item{var.cex}{Character expansion for the variables.}
  \item{var.offset}{The distance (in character widths) which separates the
    label from identified points of variables. Negative values are allowed.
    Used only if \code{rgl.use=FALSE}.}
  \item{obj.factor}{\dots .}
  \item{obj.color}{A vector of colors for the objects representation.}
  \item{obj.pch}{A vector of plotting symbols or characters for objects.
    If too short, the values are recycled. Used only if \code{rgl.use=FALSE}.}
  \item{obj.pos}{Position of labels for objects.}
  \item{obj.cex}{Character expansion for objects.}
  \item{obj.offset}{The distance (in character widths) which separates the label
    from identified points of objects. Negative values are allowed.
    Used only if \code{rgl.use=FALSE}.}
  \item{obj.names}{A logical value to represent objects as spheres or points.}
  \item{obj.identify}{A logical value. If TRUE, it is possible, in interative way,
    to identify the objects with the mouse.}
  \item{obj.labels}{A vector of labels for objects.}
  \item{box}{A logical value to whether to draw a box. Used only if
    \code{rgl.use=TRUE}.}
  \item{angle}{Angle between x and y axis (Attention: result depends on scaling).
    For 180 < angle < 360 the returned functions xyz.convert and points3d will
    not work properly. Used only if \code{rgl.use=FALSE}.}
  \item{pch}{A vector of plotting symbols or characters.}
  \item{col}{A vector of colors.}
  \item{xlab}{A label for the x axis.}
  \item{ylab}{A label for the y axis.}
  \item{zlab}{A label for the z axis (bpca.3d only).}
  \item{xlim}{The x limits of the plot.}
  \item{ylim}{The y limits of the plot.} 
  \item{zlim}{The z limits of the plot (bpca.3d only).} 
  \item{\dots}{Other graphical parameters may also be passed as arguments to
    these functions.}
}

\details{
  A biplot aims to represent both the observations and variables
  of a matrix of multivariate data on the same plot.

  The methods \code{plot.bpca.2d} draw a 2d biplot (PC1 and PC2 on axis x
  and y, respectively). It uses the traditional graphics system.

  The methods \code{plot.bpca.3d} draw a 3d biplot (PC1, PC2 and PC3 on axis
  x, y and z, respectively) in two ways:
  \itemize{
    \item{\emph{static}:}{It uses the package \code{scatterplot3d} based on
      traditional graphic system. Use the parameter \emph{rgl.use=FALSE} for it.}
    \item{\emph{dinamic}:}{It uses the package \code{rgl}: a 3D real-time rendering
      device driver system for R. Use the parameter \emph{rgl.use=TRUE} for it.}
  }  

  The method \code{qb.pca} draws a scatterplot of the correlations observed
  (in the data) and projected (under the biplot) related to the variables.
  It uses the traditional graphics system.
  \code{qb.pca} is a simple (and graphical) measure of the quality of the biplot
  reduction associated to the variables.
}

\author{
  Jose Claudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  and\cr
  Clarice Garcia Borges Demetrio (\email{clarice@esalq.usp.br})
}

\references{
  Gabriel, K. R.  (1971)
  The biplot graphical display of matrices with application to principal
  component analysis.
  \emph{Biometrika} \bold{58}, 453-467.

  Gower, J.C. and Hand, D. J.  (1996)
  \emph{Biplots}. Chapman & Hall.

  Galindo, M. P. (1986)
  Una alternativa de representacion simultanea: HJ-Biplot.
  \emph{Questiio}, 10(1):13-23, 1986.

  Johnson, R. A. and Wichern, D. W. (1988)
  \emph{Applied multivariate statistical analysis}.
  Prentice-Hall, Inc., Upper Saddle River, NJ, USA, 6 ed.

  Yan, B. W. and Kang, M. S. (2003)
  \emph{GGE biplot analysis : a graphical tool for breeders,
    geneticists, and agronomists}. CRC Press, New York, 288p.
}

\seealso{\code{\link{biplot.prcomp}}}

\examples{
##
## Example 1
## Computing and ploting a bpca object with 'graphics' package - 2d
##

bp <- bpca(gabriel1971)

x11(w=6, h=6)
oask <- devAskNewPage(dev.interactive(orNone=TRUE))
plot(bp,
     var.factor=2)

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
## Example 2
## Computing and ploting a bpca object with 'scatterplot3d' package - 3d
##

bp <- bpca(gabriel1971,
           d=1:3)

plot(bp,
     var.factor=3)

# Additional graphical parameters (nonsense)
plot(bpca(gabriel1971,
          d=1:3,
          meth='jk'),
     main='gabriel1971 - jk',
     sub='The graphical parameters are working fine!',
     var.factor=6,
     var.pch='+',
     var.cex=.6,
     var.col='green4',
     obj.pch='*',
     obj.cex=.8,
     obj.col=1:8,
     ref.lty='solid',
     ref.col='red',
     angle=70)

##
## Example 3
## Computing and ploting a bpca object with 'rgl' package - 3d
##

plot(bpca(gabriel1971,
          d=1:3),
     rgl.use=TRUE,
     var.factor=2)

# Suggestion: Interact with the graphic with the mouse
# left button: press, maintain and movement it to interactive rotation;
# right button: press, maintain and movement it to interactive zoom.
# Enjoy it!

##
## Example 4
## Grouping objects with different symbols and colors - 2d and 3d
##

# 2d
plot(bpca(iris[-5]),
     var.factor=.3,
     var.cex=.7,
     obj.names=FALSE,
     obj.cex=1.5,
     obj.col=c('red', 'green3', 'blue')[unclass(iris$Species)],
     obj.pch=c('+', '*', '-')[unclass(iris$Species)])

# 3d static
plot(bpca(iris[-5],
          d=1:3),
     var.factor=.2,
     var.color=c('blue', 'red'),
     var.cex=1,
     obj.names=FALSE,
     obj.cex=1,
     obj.col=c('red', 'green3', 'blue')[unclass(iris$Species)],
     obj.pch=c('+', '*', '-')[unclass(iris$Species)])

# 3d dinamic
plot(bpca(iris[-5],
          method='hj',
          d=1:3),
     rgl.use=TRUE,
     var.col='brown',
     var.factor=.3,
     var.cex=1.2,
     obj.names=FALSE,
     obj.cex=.8,
     obj.col=c('red', 'green3', 'orange')[unclass(iris$Species)],
     simple.axes=FALSE, box=TRUE)

##
## Example 5
## Computing and ploting a bpca object with 'obj.identify=TRUE' parameter - 2d
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
## Computing and ploting a bpca object with 'obj.identify=TRUE' parameter - 3d
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

# New options ploting
plot(bpca(ontario))

# Labels for all objects
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
     var.pos=2,
     var.cex=1)

plot(bpca(ontario),
     type='ev',
     var.id='E7',
     obj.labels=obj.lab,
     var.pos=1,
     var.cex=1)

# A complete plot
cl <- 1:3
plot(bpca(iris[-5]),
     type='ev',
     var.id=1,
     var.fac=.3,
     obj.names=FALSE,
     obj.col=cl[unclass(iris$Species)])
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
     var.factor=.3)

  devAskNewPage(oask)
}

\keyword{multivariate}
