\name{bpca-package}
\alias{bpca-package}
\docType{package}

\title{
  Biplot of Multivariate Data Based on Principal Components Analysis
}

\description{
  Implements biplot (2d and 3d) and diagnostic tools of the quality of the reduction.
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

\keyword{package}
\keyword{multivariate}

\examples{
##
## Grouping objects with different symbols and colors - 2d and 3d
##

x11(w=6, h=6)
oask <- devAskNewPage(dev.interactive(orNone=TRUE))

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
     simple.axes=FALSE,
     box=TRUE)

# New options ploting
plot(bpca(ontario))

plot(bpca(ontario),
     type='eo',
     obj.cex=1)

plot(bpca(ontario),
     type='eo',
     obj.id='G7',
     obj.cex=1)

plot(bpca(ontario),
     type='ev',
     var.pos=2,
     var.cex=1)

plot(bpca(ontario),
     type='ev',
     var.id='E7',
     var.pos=1,
     var.cex=1)

plot(bpca(ontario),
     type='co')

plot(bpca(ontario),
     type='co',
     obj.id=13:14)

plot(bpca(ontario),
     type='co',
     obj.id=c('G13', 'G7'))

plot(bpca(ontario),
     type='cv')

plot(bpca(ontario),
     type='ww')

plot(bpca(ontario),
     type='dv')

plot(bpca(ontario),
     type='ms')

plot(bpca(ontario),
     type='ro')

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
