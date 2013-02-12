\name{summary}
\alias{summary.bpca}

\title{Summary Method for bpca Objects}

\description{
  Returns (and prints) a summary list for \code{bpca} (\code{bpca.2d} and
  \code{bpca.3d}) objects.
}

\usage{
  \method{summary}{bpca}(object,
                         presentation=FALSE, \dots)
}

\arguments{
  \item{object}{A given object of the class \code{bpca} (\code{bpca.2d} or
    \code{bpca.3d}).}
  \item{presentation}{Logic. If \code{TRUE} the summary is showed well formated in the screen, else,
    return a list. The default is \code{FALSE}.}
  \item{\dots}{Potential further arguments (require by generic).}
}

\author{
  Jose Claudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  Clarice Garcia Borges Demetrio (\email{clarice@esalq.usp.br})\cr
  and\cr
  Ivan Bezerra Allaman (\email{ivanalaman@gmail.com})
}

\seealso{\code{\link{bpca}}}

\examples{
##
## Example 1
## bpca - 2d
##

(bp <- bpca(gabriel1971))

summary(bp)

##
## Example 2
## bpca - 3d
##

bp <- bpca(gabriel1971,
            d=1:3)

sm <- summary(bp)
str(sm)
sm

summary(bp, presentation=TRUE)
}

\keyword{multivariate}
