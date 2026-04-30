\name{qbpca}
\alias{qbpca}

\title{
  Quality of the Representation of Variables by Biplot
}

\description{
  This function returns an object of class \code{qbpca}. It is a simple
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
  \item{bpca}{An object of class \code{\link{bpca}}.}
}

\details{
  This function combines the vectors of observed (from the matrix or data.frame)
  and projected (under biplot reduction) correlations for all variables.
}

\value{
  An object of class \code{qbpca} and \code{data.frame} with two columns:
  \item{obs}{A vector of the observed correlations for all variables.}
  \item{var.rb}{A vector of projected correlations for all variables
    determined under biplot reduction.}
}

\author{
  Faria, J. C. \cr
  Allaman, I. B. \cr
  Demétrio C. G. B.
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
## Example of the `var.rb=TRUE` parameter as a quality measure (2D)
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
     main='sqrt - 2D \n (poor)')


# JK
bp2 <- bpca(gabriel1971,
            meth='jk',
            var.rb=TRUE)

qbp2 <- qbpca(gabriel1971,
              bp2)

plot(qbp2,
     main='jk - 2D \n (very poor)')


# GH
bp3 <- bpca(gabriel1971,
            meth='gh',
            var.rb=TRUE)

qbp3 <- qbpca(gabriel1971,
              bp3)

plot(qbp3,
     main='gh - 2D \n (good)')


# HJ
bp4 <- bpca(gabriel1971,
            meth='hj',
            var.rb=TRUE)

qbp4 <- qbpca(gabriel1971,
             bp4)

plot(qbp4,
     main='hj - 2D \n (good)')

##
## Example 2
## Example of the `var.rb=TRUE` parameter as a quality measure (3D)
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
     main='sqrt - 3D \n (poor)')


# JK
bp2 <- bpca(gabriel1971,
            meth='jk',
            d=1:3,
            var.rb=TRUE)

qbp2 <- qbpca(gabriel1971,
             bp2)

plot(qbp2,
     main='jk - 3D \n (very poor)')


# GH
bp3 <- bpca(gabriel1971,
            meth='gh',
            d=1:3,
            var.rb=TRUE)

qbp3 <- qbpca(gabriel1971,
              bp3)

plot(qbp3,
     main='gh - 3D \n (wow!)')


# HJ
bp4 <- bpca(gabriel1971,
            meth='hj',
            d=1:3,
            var.rb=TRUE)

qbp4 <- qbpca(gabriel1971,
              bp4)

plot(qbp4,
     main='hj - 3D \n (wow!)')

devAskNewPage(oask)  
}

\keyword{multivariate}
