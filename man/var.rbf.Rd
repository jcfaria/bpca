\name{var.rbf}
\alias{var.rbf}

\title{
  Projected Correlations by bpca
}

\description{
  Computes the matrix of graphical correlations represented by biplot
  for a matrix of variable coordinates.
}

\usage{
  var.rbf(x)
}

\arguments{
  \item{x}{A given object of the classes \samp{bpca.2d} and \samp{bpca.3d}.}
}

\value{
  A \code{matrix} of graphical correlations represented by biplot.
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
## Particular use
##

bp1 <- bpca(gabriel1971)
bp1$var.rb # NA

# Computes the correlations of all variables under the biplot projection
(res <- var.rbf(bp1$coord$var)) 

##
## Common use
##

bp2 <- bpca(gabriel1971,
            var.rb=TRUE)

bp2$var.rb
}

\keyword{multivariate}
