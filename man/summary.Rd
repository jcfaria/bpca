\name{summary}
\alias{summary.bpca}

\title{Summary Method for bpca Objects}

\description{
  Returns (and prints) a summary list for \code{bpca} (\code{bpca.2d} and
  \code{bpca.3d}) objects.
}

\usage{
  \method{summary}{bpca}(object, \dots)
}

\arguments{
  \item{object}{A given object of the class \code{bpca} (\code{bpca.2d} or
    \code{bpca.3d}).}
  \item{\dots}{Potential further arguments (require by generic).}
}

\author{
  Jose Claudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  and\cr
  Clarice Garcia Borges Demetrio (\email{clarice@esalq.usp.br})
}

\seealso{\code{\link{bpca}}}

\examples{
  ##
  ## Example 1
  ## bpca - 2d
  ##

  bp <- bpca(gabriel1971)
  bp

  summary(bp)

  ##
  ## Example 2
  ## bpca - 3d
  ##

  bp <- bpca(gabriel1971, d=1:3)
  bp

  summary(bp)
}

\keyword{multivariate}
