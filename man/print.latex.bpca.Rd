\name{print}
\alias{print.latex.bpca}

\title{
  Print Method for latex.bpca Objects
}

\description{
  Returns (and prints) a summary list for \code{latex.bpca} objects.
}

\usage{
  \method{print}{latex.bpca}(x, \dots)
}

\arguments{
  \item{x}{A given object of the class \code{latex.bpca}.}
  \item{\dots}{Potential further arguments (require by generic).}
}

\author{
  José Cláudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  Clarice Garcia Borges Demétrio (\email{clarice@esalq.usp.br})\cr
  and\cr
  Ivan Bezerra Allaman (\email{ivanalaman@gmail.com})
}

\seealso{\code{\link{latex.bpca}}}

\examples{
##
## Example 1
## one bpca objects
##

bp <- bpca(gabriel1971)

lbp <- latex.bpca(bp)

lbp

##
## Example 2
## two bpca objects
##
y_2007 <- subset(marina,
                 year==2007)

y_2008 <- subset(marina,
                 year==2008)  

bp_2007 <- bpca(y_2007[,-c(1:2)],
                d=1:3)

bp_2008 <- bpca(y_2008[,-c(1:2)],
                d=1:2)             

lbp <- latex.bpca(list(bp_2007,
                       bp_2008))

lbp
}

\keyword{multivariate}
