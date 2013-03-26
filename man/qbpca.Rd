\name{qbpca}
\alias{qbpca}

\title{
  Quality of the Representation of Variables by Biplot
}

\description{
  This function returns an object of the class \code{qbpca}. It is a simple
  measure of the quality of biplot representation of the variables. The
  observed (in the data) and projected (under biplot reduction) correlations
  are computed.
}

\usage{
  qbpca(x,
        bpca)
}

\arguments{
  \item{x}{A \code{data.frame} or \code{matrix} object.}
  \item{bpca}{A object of the class \code{\link{bpca}}.}
}

\details{
  This function binds the vectors of observed (from the matrix or data.frame)
  and projected (under biplot reduction) correlations for all variables.
}

\value{
  An object of class \code{qbpca} and \code{data.frame} with two columns:
  \item{obs}{A vector of the observed correlations for all variables.}
  \item{var.rb}{A vector of the projected correlations for all variables
    determined under biplot reduction).}
}

\author{
  José Cláudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  Clarice Garcia Borges Demétrio (\email{clarice@esalq.usp.br})\cr
  and\cr
  Ivan Bezerra Allaman (\email{ivanalaman@gmail.com})
}

\references{
  Johnson, R. A. and Wichern, D. W. (1988)
  \emph{Applied multivariate statistical analysis}.
  Prentice-Hall, Inc., Upper Saddle River, NJ, USA, 6 ed.
}

\seealso{\code{\link{bpca}}}

\examples{
##
## Example 1
## Example of 'var.rb=TRUE' parameter as a measure of the quality of the biplot - 2d
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

## Differences between methods of factorization
# SQRT
bp1 <- bpca(gabriel1971,
            meth='sqrt',
            var.rb=TRUE)

qbp1 <- qbpca(gabriel1971,
              bp1)

plot(qbp1,
     main='sqrt - 2d \n (poor)')


# JK
bp2 <- bpca(gabriel1971,
            meth='jk',
            var.rb=TRUE)

qbp2 <- qbpca(gabriel1971,
              bp2)

plot(qbp2,
     main='jk - 2d \n (very poor)')


# GH
bp3 <- bpca(gabriel1971,
            meth='gh',
            var.rb=TRUE)

qbp3 <- qbpca(gabriel1971,
              bp3)

plot(qbp3,
     main='gh - 2d \n (good)')


# HJ
bp4 <- bpca(gabriel1971,
            meth='hj',
            var.rb=TRUE)

qbp4 <- qbpca(gabriel1971,
             bp4)

plot(qbp4,
     main='hj - 2d \n (good)')

##
## Example 2
## Example of 'var.rb=TRUE' parameter as a measure of the quality of the biplot - 3d
##

## Differences between methods of factorization
# SQRT
bp1 <- bpca(gabriel1971,
            meth='sqrt',
            d=1:3,
            var.rb=TRUE)

qbp1 <- qbpca(gabriel1971,
              bp1)

plot(qbp1,
     main='sqrt - 3d \n (poor)')


# JK
bp2 <- bpca(gabriel1971,
            meth='jk',
            d=1:3,
            var.rb=TRUE)

qbp2 <- qbpca(gabriel1971,
             bp2)

plot(qbp2,
     main='jk - 3d \n (very poor)')


# GH
bp3 <- bpca(gabriel1971,
            meth='gh',
            d=1:3,
            var.rb=TRUE)

qbp3 <- qbpca(gabriel1971,
              bp3)

plot(qbp3,
     main='gh - 3d \n (whow!)')


# HJ
bp4 <- bpca(gabriel1971,
            meth='hj',
            d=1:3,
            var.rb=TRUE)

qbp4 <- qbpca(gabriel1971,
              bp4)

plot(qbp4,
     main='hj - 3d \n (whow!)')

devAskNewPage(oask)  
}

\keyword{multivariate}
