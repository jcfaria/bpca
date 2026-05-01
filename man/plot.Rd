\name{plot}
\alias{plot.bpca.2d}
\alias{plot.bpca.3d}
\alias{plot.qbpca}

\title{
  Biplot of Multivariate Data Based on Principal Component Analysis
}

\description{
  These are methods for objects of class \code{bpca.2d}, \code{bpca.3d} and
  \code{qbpca}.

  These functions provide a 2D or 3D graphical representation of the objects and variables
  from a \code{bpca} object. It allows for manual or automatic positioning of labels
  to improve visualization and avoid overlaps.
}

\usage{
  \method{plot}{bpca.2d}(x,
     type=c('bp', 'eo', 'ev', 'co', 'cv', 'ww', 'dv', 'ms', 'ro', 'rv'),
     c.color='darkgray',
     c.lwd=1,
     c.number=5,
     c.radio=1,
     obj.id=1:2,
     var.id=1,
     base.color='red3',
     base.lty='dotted',
     proj.color='gray',
     proj.lty='dotted',
     a.color='blue',
     a.lty='solid',
     a.lwd=2,
     a.length=.1,
     ref.lines=TRUE,
     ref.color='navy',
     ref.lty='dotted',
     var.factor=NULL,
     var.color='red3',
     var.lty='solid',
     var.pch=20,
     var.cex=.6,
     var.pos=NULL,
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
     xlim,
     ylim,
     xlab,
     ylab, \dots)

  \method{plot}{bpca.3d}(x,
     rgl.use=FALSE,
     ref.lines=TRUE,
     ref.color='navy',
     ref.lty=ifelse(rgl.use, NA, 'dotted'),
     clear3d=ifelse(rgl.use, TRUE, NULL),
     simple.axes=ifelse(rgl.use, TRUE, NULL),
     aspect=ifelse(rgl.use, c(1, 1, 1), NULL),
     var.factor=NULL,
     var.color='red3',
     var.lty=ifelse(rgl.use, NA, 'solid'),
     var.pch=ifelse(rgl.use, NULL, 20),
     var.cex=ifelse(rgl.use, .8, .6),
     var.pos=ifelse(rgl.use, 0, NA),
     var.offset=ifelse(rgl.use, 0.2, 0.2),
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
     xlim,
     ylim,
     zlim,
     xlab,
     ylab,
     zlab, \dots)

  \method{plot}{qbpca}(x,
     limit=10,
     highlight.col='gray75',
     highlight.lty='dashed',
     highlight.pad=0.05,
     highlight.width=0.25,
     highlight.guides=TRUE,
     pair.labels=TRUE,
     label.max.nchar=NULL,
     label.side='bottom',
     label.angle=45,
     label.cex=0.6,
     label.offset=0.02,
     xlab='',
     ylab='r',
     pch=c(1,8),
     col=c(4,2), \dots)
}

\arguments{
  \item{x}{An object of class \code{bpca.2d}, \code{bpca.3d}, or \code{qbpca}.}
  \item{type}{Type of biplot: \cr
              \samp{bp} - conventional biplot; \cr
              \samp{eo} - evaluate an object; \cr
              \samp{ev} - evaluate a variable; \cr
              \samp{co} - compare two objects; \cr
              \samp{cv} - compare (relationship among) variables; \cr
              \samp{ww} - which won where/what; \cr
              \samp{dv} - discriminativeness vs. representativeness; \cr
              \samp{ms} - mean vs. stability; \cr
              \samp{ro} - rank objects with reference to an \dQuote{ideal} variable; \cr
              \samp{rv} - rank variables with reference to an \dQuote{ideal} object.}
  \item{c.color}{The color of circles.}
  \item{c.lwd}{The \code{lwd} of circles.}
  \item{c.number}{The number of circles.}
  \item{c.radio}{The radius of circles.}
  \item{obj.id}{An object(s) number(s) or name(s).
    It is used with reprojections to identify the object(s) when the \code{type} option is \samp{'eo'} or \samp{'co'}.
    The default is \samp{1} for \samp{'eo'} and \code{1:2} for \samp{'co'}.}
  \item{var.id}{A variable number or name.
    It is used with reprojections to identify the variable when the \samp{type} option is \code{'ev'}.}
  \item{base.color}{The color for the base lines.
    It is used only with reprojections.}
  \item{base.lty}{The \samp{lty} for the base lines.
    It is used only with reprojections.}
  \item{proj.color}{The color for the projections lines.
    It is used only with reprojections.}
  \item{proj.lty}{The \samp{lty} for the projections lines.
    It is used only with reprojections.}
  \item{a.color}{The color for the arrow.
    It is used only with reprojections.}
  \item{a.lty}{The \samp{lty} for the arrow.
    It is used only with reprojections.}
  \item{a.lwd}{The \samp{lwd} for the arrow.
    It is used only with reprojections.}
  \item{a.length}{The \samp{length} for the arrow.
    It is used only with reprojections.}
  \item{rgl.use}{A logical value.
    If \code{TRUE}, the 3D scatter is drawn with \code{rgl};
    otherwise, \code{scatterplot3d} is used.}
  \item{ref.lines}{A logical value.
    If \code{TRUE}, the reference lines will be added to the biplot.}
  \item{ref.color}{Line color for reference lines.}
  \item{ref.lty}{Line type of the reference lines.}
  \item{clear3d}{A logical value.
    Clears (or not) a 3D biplot before drawing a new one.
    Used only if \code{rgl.use=TRUE}.}
  \item{simple.axes}{A logical value to draw simple axes.
    Used only if \code{rgl.use=TRUE}.}
  \item{aspect}{A vector of the apparent ratios of the \samp{x}, \samp{y},
    and \samp{z} axes of the bounding box. Used only if \code{rgl.use=TRUE}.}
  \item{var.factor}{Factor of expansion/reduction of length lines of the variables.}
  \item{var.color}{A vector of colors for the variables representation.}
  \item{var.lty}{Line type for the variables.
    Used only if \code{rgl.use=FALSE}.}
  \item{var.pch}{A vector of plotting symbols or characters for the variables.
    If too short, the values are recycled.
    Used only if \code{rgl.use=FALSE}.}
  \item{var.cex}{Character expansion for the variables.}
  \item{var.pos}{A vector or a single integer (1, 2, 3, or 4) to specify the position of the variable labels relative to the points.
    The convention is: 1 = below, 2 = left, 3 = above, and 4 = right.
    If \code{NULL} (2D or 3D static) or \code{0} (3D dynamic), an automatic radial adjustment is used.
    A vector can be used to specify different positions for each variable to avoid overlaps.}
  \item{var.offset}{A numeric value to specify the distance (offset) of the label from the variable point.
     In 3D dynamic mode (\code{rgl}), it is internally scaled to match the visual output of the 2D and 3D static modes.}
  \item{obj.factor}{Factor of expansion/reduction of length lines of the objects.}
  \item{obj.color}{A vector of colors for the objects representation.}
  \item{obj.pch}{A vector of plotting symbols or characters for objects.
    If too short, the values are recycled.
    Used only if \code{rgl.use=FALSE}.}
  \item{obj.pos}{Position of labels for objects.}
  \item{obj.cex}{Character expansion for objects.}
  \item{obj.offset}{The distance (offset) which separates the label
    from identified points of objects. Negative values are allowed.
    Used only if \code{rgl.use=FALSE}.}
  \item{obj.names}{A logical value to represent objects as spheres or points.}
  \item{obj.identify}{A logical value.
    If \code{TRUE}, objects can be identified interactively with the mouse.}
  \item{obj.labels}{A vector of labels for objects.}
  \item{box}{A logical value to whether to draw a box.
    Used only if \samp{rgl.use=TRUE}.}
  \item{angle}{Angle between \samp{x} and \samp{y} axis (Attention: result depends on scaling).
    For \eqn{180 < angle < 360} the returned functions xyz.convert and points3d will not work properly.
    Used only if \code{rgl.use=FALSE}.}
  \item{pch}{A vector of plotting symbols or characters.}
  \item{col}{A vector of colors.}
  \item{limit}{Numeric threshold (percentage) used to mark pairs with poor
    representation in \code{plot.qbpca}. Pairs where
    \code{100 * abs(r.obs - r.rb) > limit} are highlighted with dashed
    rectangles around the pair of points. Default is \code{10}.}
  \item{highlight.col}{Color used for the dashed rectangle border in
    \code{plot.qbpca}. Default is \code{'gray75'}.}
  \item{highlight.lty}{Line type used for the dashed rectangle border in
    \code{plot.qbpca}. Default is \code{'dashed'}.}
  \item{highlight.pad}{Vertical margin added above and below the two points in
    each highlighted pair. Default is \code{0.05}.}
  \item{highlight.width}{Half-width of the dashed highlight rectangle around
    each flagged pair along the x-axis. Must be in \code{(0, 0.5]}.
    Default is \code{0.25}.}
  \item{highlight.guides}{Logical. If \code{TRUE}, draws dashed guide segments
    from the lower edge of each highlighted rectangle down to the x-axis to
    facilitate pair identification. Default is \code{TRUE}.}
  \item{pair.labels}{Logical. If \code{TRUE}, variable-pair labels from
    \code{qbpca} row names are drawn on the x-axis. When labels are enabled,
    \code{plot.qbpca} automatically adjusts the corresponding plot margin to fit
    long rotated labels and restores the original device margin afterwards.
    Default is \code{TRUE}.}
  \item{label.max.nchar}{Optional maximum number of characters for each
    variable-pair label. Labels longer than this value are truncated and
    suffixed with \code{...}. Set \code{NULL} to keep full labels.
    Default is \code{NULL}.}
  \item{label.side}{Side where pair labels are drawn when
    \code{pair.labels=TRUE}. Allowed values are \code{'bottom'} and
    \code{'top'}. Default is \code{'bottom'}.}
  \item{label.angle}{Numeric angle (degrees) used to rotate x-axis pair labels
    when \code{pair.labels=TRUE}. Default is \code{45}.}
  \item{label.cex}{Character expansion for rotated x-axis pair labels.
    Default is \code{0.6}.}
  \item{label.offset}{Proportional vertical offset used to place rotated
    x-axis labels below or above the plotting region. Default is \code{0.02}.}
  \item{xlab}{A label for the \samp{x} axis.}
  \item{ylab}{A label for the \samp{y} axis.}
  \item{zlab}{A label for the \samp{z} axis (bpca.3d only).}
  \item{xlim}{The \samp{x} limits of the plot.}
  \item{ylim}{The \samp{y} limits of the plot.} 
  \item{zlim}{The \samp{z} limits of the plot (bpca.3d only).} 
  \item{\dots}{Other graphical parameters may also be passed as arguments to these functions.}
}

\details{
  A biplot aims to represent both the observations and variables
  of a matrix of multivariate data on the same plot.

  The method \code{plot.bpca.2d} draws a 2D biplot (PC1 and PC2 on axis \samp{x}
  and \samp{y}, respectively). It uses the traditional graphics system.

  The method \code{plot.bpca.3d} draws a 3D biplot (PC1, PC2 and PC3 on axis
  \samp{x}, \samp{y} and \samp{z}, respectively) in two ways:

  \enumerate{
    \item static: It uses the package \code{scatterplot3d} based on
      traditional graphic system. Use the parameter \samp{rgl.use=FALSE} for it.
      It is the default.
    \item dynamic: It uses the package \code{rgl}, a 3D real-time rendering
      device driver system for R. Use the parameter \samp{rgl.use=TRUE} for it.
  }

  The method \code{plot.qbpca} draws a scatterplot of observed
  (in the data) and projected (under the biplot) related to the variables.
  It uses the traditional graphics system.
  \code{qbpca} is a simple (and graphical) measure of the quality of the biplot
  reduction associated to the variables.
}

\author{
  Faria, J. C. \cr
  Allaman, I. B. \cr
  Demétrio C. G. B.
}

\references{
  Gabriel, K. R. (1971)
  The biplot graphical display of matrices with application to principal
  component analysis.
  \emph{Biometrika} \bold{58}, 453-467.

  Galindo Vilardón, M. P. (1986)
  Una alternativa de representación simultánea: HJ-Biplot.
  \emph{Qüestiió}, 10(1):13-23, 1986.

  Johnson, R. A. and Wichern, D. W. (1988)
  \emph{Applied multivariate statistical analysis}.
  Prentice-Hall, Inc., Upper Saddle River, NJ, USA, 6 ed.

  Gower, J.C. and Hand, D. J. (1996)
  \emph{Biplots}. Chapman & Hall.

  Yan, B. W. and Kang, M. S. (2003)
  \emph{GGE biplot analysis: a graphical tool for breeders,
  geneticists, and agronomists}. CRC Press, New York, 288p.
}

\seealso{\code{\link{biplot.prcomp}}}

\examples{

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

\dontrun{
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
     obj.col=c('red', 'green3', 'orange')[as.numeric(iris$Species)],
     simple.axes=FALSE,
     box=TRUE)

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
}

devAskNewPage(oask)
}

\keyword{multivariate}
