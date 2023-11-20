\name{xtable.bpca}
\alias{xtable.bpca}

\title{
  LaTeX table of the Biplot.
}

\description{
  This function returns a LaTeX table of the bpca objects.
}

\usage{
\method{xtable}{bpca}(x,
       caption = NULL,
       label = NULL,
       align = NULL,
       digits = NULL,
       display = NULL,
       auto = FALSE, \dots)
}

\arguments{
  \item{x}{A object of the class \code{\link{bpca}} objects.}
  \item{caption}{Character vector of length 1 or 2 containing the table's
    caption or title. If length is 2, the second item is the "short
    caption" used when LaTeX generates a "List of Tables".
    Set to NULL to suppress the caption. Default value is \code{NULL}.}
  \item{label}{Character vector of length 1 containing the
    LaTeX \samp{\\label} or HTML anchor. Set to \code{NULL} to suppress
    the label. Default value is \code{NULL}.}
  \item{align}{Character vector of length equal to the number of columns of
    the resulting table, indicating the alignment of the corresponding
    columns. Also, "|" may be used to produce vertical lines between
    columns in LaTeX tables, but these are effectively ignored when
    considering the required length of the supplied vector.
    If a character vector of length one is supplied, it is split as
    strsplit(align, "")[[1]] before processing. Since the row names
    are printed in the first column, the length of align is one greater
    than ncol(x) if x is a data.frame. Use "l", "r", and "c" to denote
    left, right, and center alignment, respectively. for a LaTeX column
    of the specified width. For HTML output the "p" alignment is interpreted
    as "l", ignoring the width request.
    Default depends on the class of x.}
  \item{digits}{Numeric vector of length equal to one (in which case it
    will be replicated as necessary) or to the number of columns of
    the resulting \code{table} or \code{matrix} of the same size as
    the resulting table, indicating the number of digits to display
    in the corresponding columns. Since the row names are printed
    in the first column, the length of the vector digits or the number
    of columns of the matrix digits is one greater than ncol(x) if x
    is a \code{data.frame}. Default depends on the class of x.
    If values of digits are negative, the corresponding values of x
    are displayed in scientific format with abs(digits) digits.}
  \item{display}{Character vector of length equal to the number of columns
    of the resulting table, indicating the format for the corresponding
    columns. Since the row names are printed in the first column, the
    length of display is one greater than ncol(x) if x is a data.frame.
    These values are passed to the formatC function. Use "d" (for integers),
    "f", "e", "E", "g", "G", "fg" (for reals), or "s" (for strings).
    "f" gives numbers in the usual xxx.xxx format; "e" and "E" give
    n.ddde+nn or n.dddE+nn (scientific format); "g" and "G" put x[i] into
    scientific format only if it saves space to do so. "fg" uses fixed
    format as "f", but digits as number of significant digits. Note that
    this can lead to quite long result strings.
    Default depends on the class of x.}
  \item{auto}{Logical, indicating whether to apply automatic format when no
    value is passed to align, digits, or display. This autoformat
    (based on xalign, xdigits, and xdisplay) can be useful to quickly
    format a typical \code{matrix} or \code{data.frame}.
    Default value is \code{FALSE}.}
  \item{\dots}{Additional arguments. (Currently ignored.)}
}

\details{
  This function extracts tabular information from x and returns an object of class "xtable.bpca", "xtable" or "data.frame". 

  It is necessary to declare the latex packages: \samp{multirow} in the preamble of the Rnoweb file to make available all the 
  resources of the function \code{xtable.bpca}.
}

\value{
  An object of the class \code{xtable.bpca}.
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

\seealso{
  \code{\link{bpca}},
  \code{\link[xtable]{xtable}}
}  

\examples{
## Example 1: The simplest possible 
library(xtable)

bp <- bpca(iris[-5],
           d=1:3)

xtable(bp)

## Example 2: With caption and label 
bp2 <- bpca(gabriel1971) 

xtable(bp2,
       caption='Biplot gabriel1971',
       label='example_2')
}

\keyword{multivariate}
\keyword{table}
\keyword{latex}
\keyword{bpca}

