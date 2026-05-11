\name{print.xtable}
\alias{print.xtable}
\alias{print.xtable.bpca}
\alias{print.xtable.default}

\title{
  Print Method for xtable.bpca Objects
}

\description{
  Formatted printing for \code{xtable.bpca} objects produced by
  \code{xtable::xtable(bpca(...))}. By default (\code{type = "latex"}) the output
  matches the biplot-style LaTeX table (multirow headers and eigenvalues in
  column titles). With \code{type = "html"}, a simpler HTML table is produced
  for R Markdown and web publishing; column headings include numeric eigenvalues.
}

\usage{
\method{print}{xtable.bpca}(x, 
      hline.after = getOption("xtable.hline.after", NULL), 
      include.colnames = getOption("xtable.include.colnames", FALSE), 
      add.to.row = getOption("xtable.add.to.row", NULL), 
      sanitize.text.function = getOption("xtable.sanitize.text.function", NULL),
      sanitize.rownames.function = getOption("xtable.sanitize.rownames.function", 
                                             sanitize.text.function), 
      sanitize.colnames.function = getOption("xtable.sanitize.rownames.function", 
                                             sanitize.text.function),\dots)
}

\arguments{
  \item{x}{An object of class \code{xtable} or \code{xtable.bpca}.}
  \item{hline.after}{When type="latex", a vector of numbers between -1 and nrow(x), 
    inclusive, indicating the rows after which a horizontal line should appear.
    Default value is NULL, which means drawing a line before and after the column names,
    draw a line before variables and at the end of the table.}
  \item{include.colnames}{If \code{TRUE}, column names are printed. The formal
    argument defaults to \code{getOption("xtable.include.colnames", FALSE)}.
    When \code{type = "html"} is requested and \code{include.colnames} is
    \emph{not} supplied in the call, the method defaults to \code{TRUE} so PC
    columns (with eigenvalues in the header) are shown; set
    \code{include.colnames = FALSE} explicitly to omit them.} 
  \item{add.to.row}{A list of two components. The first component (which should be called 'pos') 
    is a list that contains the position of rows on which extra commands should be added at the end.
    The second component (which should be called 'command') is a character vector of the same length
    as the first component, which contains the command that should be added at the end of the specified rows. 
    Default value is NULL.}
  \item{sanitize.text.function}{All non-numeric entries (except row and column names) are sanitized 
    in an attempt to remove characters which have special meaning for the output format. 
    If sanitize.text.function is not NULL, it should be a function taking a character vector and returning one,
    and will be used for the sanitization instead of the default internal function. Default value is NULL.}
  \item{sanitize.rownames.function}{Like the sanitize.text.function, but applicable to row names. 
    The default uses the sanitize.text.function.}
  \item{sanitize.colnames.function}{Like the sanitize.text.function, but applicable to column names. 
    The default uses the sanitize.text.function.}
  \item{\dots}{Other arguments passed to \code{xtable::print.xtable}, in particular
    \code{type}: use \code{type = "html"} for HTML tables (e.g. R Markdown HTML
    output) and the default \code{"latex"} (or \code{getOption("xtable.type")})
    for the biplot-style LaTeX table. For HTML, row continuations do not use
    the LaTeX \code{&} prefix; custom \code{sanitize.rownames.function} should
    return plain text suitable for HTML if you use this type.}
}

\author{
  Faria, J. C. \cr
  Allaman, I. B. \cr
  Demétrio C. G. B.
}

%\seealso{
%  \code{\link{bpca}},
%  \code{\link[xtable]{xtable}}
%}

\examples{

## Example 1: Principal labels in Portuguese
library(xtable)

bp2 <- bpca(gabriel1971)  
tbl <- xtable(bp2)
rownames(tbl) <- gsub('Eigenvectors','Autovetores',rownames(tbl))
rownames(tbl) <- c(rownames(tbl)[1:9],'Autovalores','Variância retida','Variância acumulada')
dimnames(tbl)[[2]] <- c('CP 1','CP 2')

print(tbl)

## Example 2: With bold in the column  
tbl1 <- xtable(bp2)
bold <- function(x){
  paste('\\textbf{',
        x, 
        '}')
}

print(tbl1,
      sanitize.colnames.function = bold)

# Example 3: With italic row labels
tbl2 <- xtable(bp2)
italic <- function(x){
  paste('& \\textit{',
        x, 
        '}')
} # The "&" keeps the correct number of table columns.

print(tbl2,
      sanitize.rownames.function = italic)

## HTML table (e.g. R Markdown HTML): pass type via print()
print(tbl,
      type = "html")
}

\keyword{multivariate}
