\name{summary.bpca}
\alias{summary.bpca}

\title{
  Summary Method for bpca Objects
}

\description{
  Returns (and optionally prints) a summary for \code{bpca} (\code{bpca.2d} and
  \code{bpca.3d}) objects.
}

\usage{
  \method{summary}{bpca}(object,
        presentation=FALSE, \dots)
}

\arguments{
  \item{object}{An object of class \code{bpca} (\code{bpca.2d} or \code{bpca.3d}).}
  \item{presentation}{Logical.
    If \code{TRUE}, the summary is printed in a formatted layout; otherwise, a list is returned.
    The default is \code{FALSE}.}
  \item{\dots}{Potential further arguments (required by the generic).}
}

\author{
  Faria, J. C. \cr
  Allaman, I. B. \cr
  Demétrio C. G. B.
}

\seealso{
  \code{\link{bpca}},
  \code{\link{xtable.bpca}}
}

\examples{
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
}

\keyword{bpca}
\keyword{summary}
\keyword{multivariate}
