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
  \item{x}{An object of class \code{data.frame} or \code{matrix}.}
  \item{var.rb}{A \code{matrix} with projected variable correlations from the biplot.}
  \item{limit}{Numeric threshold (percentage) used to define poor variable representation.}
}

\value{
  A \code{data.frame} of poor graphical correlations projected by biplot.
}

\note{
  This function is mainly for internal use in the \pkg{bpca} package,
  and may not remain available (unless we see a good reason).
}

\author{
  Faria, J. C. \cr
  Allaman, I. B. \cr
  Demétrio C. G. B.
}

\seealso{\code{\link{bpca}}}

\examples{
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

\dontrun{
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
}

devAskNewPage(oask)
}

\keyword{multivariate}
