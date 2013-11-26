\name{var.rdf}
\alias{var.rdf}

\title{
  Diagnostic of Projected Correlations
}

\description{
  Computes the diagnostic of poor graphical correlations projected by biplot
  according to an arbitrary \samp{limit}.
}

\usage{
  var.rdf(x,
          var.rb,
          limit)
}

\arguments{
  \item{x}{A given object of the classe \code{data.frame} or \code{matrix}.}
  \item{var.rb}{A given object of the class \code{matrix} with the projected correlations by biplot.}
  \item{limit}{A vector giving the percentual limit to define poor representation of variables.}
}

\value{
  A \code{data.frame} of poor graphical correlations projected by biplot.
}

\note{
  This function is mainly for internal use in the \pkg{bpca} package,
  and may not remain available (unless we see a good reason).
}

\author{
  José Cláudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  Clarice Garcia Borges Demétrio (\email{clarice@esalq.usp.br})\cr
  and\cr
  Ivan Bezerra Allaman (\email{ivanalaman@gmail.com})
}

\seealso{\code{\link{bpca}}.}

\examples{
##
## Example 1
## Diagnostic of gabriel1971 dataset representation
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
## Diagnostic of gabriel1971 dataset representation with var.rd parameter
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

# Graphical visualization of the importance of the variables not contemplated
# in the reduction
plot(bpca(gabriel1971,
          meth='hj',
          d=3:4),
     main='hj',
     xlim=c(-1,1),
     ylim=c(-1,1))

# Interpretation:
# RUR followed by CRISTIAN contains information dimensions that
# wasn't contemplated by the biplot reduction (PC3).
# Between all, RUR followed by CRISTIAN, variables are the most poor represented
# by a 2d biplot.

\dontrun{
##
## Example 3
## Diagnostic of iris dataset representation with var.rd parameter
##

bp3 <- bpca(iris[-5],
            var.rb=TRUE,
            var.rd=TRUE,
            limit=3)

plot(bp3,
     obj.col=c('red', 'green3', 'blue')[unclass(iris$Species)],
     var.factor=.3)

bp3$var.rd
bp3$eigenvectors

# Graphical diagnostic
plot(bpca(iris[-5],
          d=3:4),
     obj.col=c('red', 'green3', 'blue')[unclass(iris$Species)],
     obj.names=FALSE,
     var.factor=.6,
     xlim=c(-2,3),
     ylim=c(-1,1))

# Interpretation:
# Sepal.length followed by Petal.Width contains information in dimensions
# (PC3 - the PC3 is, essentially, a contrast among both) that wasn't fully
# contemplated by the biplot reduction (PC1 and PC2) .
# Therefore, between all variables, they have the most poor representation by a
# 2d biplot.

bp4 <- bpca(iris[-5],
            d=1:3,
            var.rb=TRUE,
            var.rd=TRUE,
            limit=2)

plot(bp4,
     obj.names=FALSE,
     obj.pch=c('+', '-', '*')[unclass(iris$Species)],
     obj.col=c('red', 'green3', 'blue')[unclass(iris$Species)],
     obj.cex=1,
     xlim=c(-5,5),
     ylim=c(-5,5),
     zlim=c(-5,5),
     var.factor=.5)

bp4$var.rd
bp4$eigenvectors

round(bp3$var.rb, 2)

round(cor(iris[-5]), 2)

# Good representation of all variables with a 3d biplot!
}

devAskNewPage(oask)
}

\keyword{multivariate}
