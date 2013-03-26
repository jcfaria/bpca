\name{summary.latex.bpca}
\alias{summary.latex.bpca}

\title{
  Summary Method for latex.bpca Objects
}

\description{
  Returns (and prints) a summary list for code{latex.bpca} objects.
}

\usage{
  \method{summary}{latex.bpca}(object, \dots)
}

\arguments{
  \item{object}{A given object of the class \code{\link{latex.bpca}}.}
  \item{\dots}{Potential further arguments (require by generic).}
}

\author{
  José Cláudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  Clarice Garcia Borges Demétrio (\email{clarice@esalq.usp.br})\cr
  and\cr
  Ivan Bezerra Allaman (\email{ivanalaman@gmail.com})
}

\seealso{
  \code{\link{bpca}},
  \code{\link{latex.bpca}}
}

\examples{
##
## Example 1
## bpca - 2d
##
# bpca
bp <- bpca(gabriel1971)

lbp <- latex.bpca(bp)
summary(lbp)

##
## Example 2
## bpca - 3d
##
lbp <- latex.bpca(bpca(gabriel1971,
                       d=1:3))

summary(lbp)

##
## Example 3
## two bpca objects
##
y_2007 <- subset(marina,
                 year == 2007)

y_2008 <- subset(marina,
                 year == 2008)  

bp_2007 <- bpca(y_2007[,-c(1:2)],
                d=1:3)

bp_2008 <- bpca(y_2008[,-c(1:2)],
                d=1:2)             

lbp <- latex.bpca(list(bp_2007,
                       bp_2008))

summary(lbp)
}

\keyword{bpca}
\keyword{latex.bpca}
\keyword{summary}
