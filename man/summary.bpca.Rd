\name{summary.bpca}
\alias{summary.bpca}
\alias{print.summary.bpca}

\title{
  Summary Method for bpca Objects
}

\description{
  \code{summary.bpca} computes and returns a summary of the dimensionality
  reduction for \code{bpca} (\code{bpca.2d} and \code{bpca.3d}) objects.

  \code{print.summary.bpca} displays the summary on the console, following
  the standard S3 convention where \code{summary()} returns an object and
  \code{print()} handles the presentation.
  It replaces the former \code{presentation = TRUE} argument of
  \code{summary.bpca}.
}

\usage{
  \method{summary}{bpca}(object, \dots)

  \method{print}{summary.bpca}(x, \dots)
}

\arguments{
  \item{object}{An object of class \code{bpca} (\code{bpca.2d} or \code{bpca.3d}).}
  \item{x}{An object of class \code{summary.bpca}, as returned by \code{summary.bpca}.}
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
bp <- bpca(gabriel1971)

# Returns a summary object.
sm <- summary(bp)
sm

# Prints the summary in a formatted layout.
print(sm)

##
## Example 2
## bpca - 3D
##
bp <- bpca(gabriel1971,
           d=1:3)

sm <- summary(bp)
str(sm)
print(sm)
}

\keyword{bpca}
\keyword{summary}
\keyword{multivariate}
