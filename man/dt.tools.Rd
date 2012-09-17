\name{dt.tools}
\alias{dt.tools}

\title{Data Tools for Multivariate}

\description{
  Calculates vector variable lengths, angles between vector variables and
  variable correlations from `data.frame' or `matrix' objects
}

\usage{
  dt.tools(x,
           center=2,
           scale=TRUE)
}

\arguments{
  \item{x}{A \code{data.frame} or \code{matrix} object.}
  \item{center}{Numeric. The type of centering to be performed: \cr
    \code{0}: no centering; \cr
    \code{1}: global-centered: sweep(x, 1, mean(x)); \cr
    \code{2}: column-centered: sweep(x, 2, apply(x, 2, mean)); \cr
    \code{3}: double-centered: sweep(sweep(x, 1, apply(x, 1, mean)),
                              2, apply(x, 2, mean)) + mean(x)). \cr
    The default is \code{2}.}
  \item{scale}{Logical. A value indicating whether the variables should be
    scaled to have unit variance before the analysis takes place: \cr
    \code{FALSE}: no scale; \cr
    \code{TRUE}: scale.}
}

\details{
  This function computes: vector variable lengths, angles between vector
  variables and variable correlations from \code{data.frame} or
  \code{matrix} objects.

  If the data are centered (\emph{center=2}), the correlations are the
  same as those obtained by the \code{cor} function.
}

\value{
  An \emph{list} with the components:
  \item{length}{A vector of the lengths.}
  \item{angle}{A matrix of the angles.}
  \item{r}{A matrix of the observed correlations.}
}

\author{
  Jose Claudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  and\cr
  Clarice Garcia Borges Demetrio (\email{clarice@esalq.usp.br})
}

\references{
  Johnson, R. A. and Wichern, D. W. (1988)
  \emph{Applied multivariate statistical analysis}.
  Prentice-Hall, Inc., Upper Saddle River, NJ, USA, 6 ed.
}

\seealso{\code{\link{bpca}}}

\examples{
##
## Computes: vector variable lengths, angles between vector variables and
## variable correlations from dataframe or matrix objects (n x p)
## n = rows (objects)
## p = columns (variables)
##

dt <- dt.tools(iris, 2)  # No mumeric columns are removed in dt.tools 

# Exploring the object 'bp' created by the function 'var.tools'
class(dt)
names(dt)
str(dt)

dt$length
dt$angle
dt$r
dt

# Checking the determinations
(iris.tools <- round(dt.tools(iris, center=2)$r, 5))
(iris.obsv  <- round(cor(iris[-5]), 5))
all(iris.tools == iris.obsv)
}

\keyword{multivariate}
