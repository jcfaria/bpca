\name{var.rbf}
\alias{var.rbf}

\title{Projected Correlations by bpca}

\description{
  Computes the matrix of graphical correlations represented by biplot
  for a matrix of variable coordinates.
}

\usage{
  var.rbf(x)
}

\arguments{
  \item{x}{A given object of the classes \emph{bpca.2d} and \emph{bpca.3d}.}
}

\value{
  A matrix of graphical correlations represented by biplot.
}

\note{
  This function is mainly for internal use in the bpca package,
  and may not remain available (unless we see a good reason).
}

\author{
  Jose Claudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  and\cr
  Clarice Garcia Borges Demetrio (\email{clarice@esalq.usp.br})
}

\seealso{\code{\link{bpca}}}

\examples{
  ##
  ## Particular use
  ##

  bp1 <- bpca(gabriel1971)
  bp1$var.rb # NA

  res <- var.rbf(bp1$coord$var) # Computes the correlations of all variables under
  # the biplot projection
  res

  ##
  ## Common use
  ##

  bp2 <- bpca(gabriel1971,
  var.rb=TRUE)

  bp2$var.rb
}

\keyword{multivariate}
