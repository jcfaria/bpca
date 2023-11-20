\name{print.xtable}
\alias{print.xtable}
\alias{print.xtable.bpca}
\alias{print.xtable.default}

\title{
  Print Method for xtable.bpca Objects
}

\description{
  Returns (and prints) a summary list for \code{xtable.bpca} objects.
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
  \item{x}{A given object of the class \code{xtable} or \code{xtable.bpca}.}
  \item{hline.after}{When type="latex", a vector of numbers between -1 and nrow(x), 
    inclusive, indicating the rows after which a horizontal line should appear.
    Default value is NULL which means draw a line before and after the columns names, 
    draw a line before variables and at the end of the table.}
  \item{include.colnames}{If TRUE the columns names are printed.
    Default value is FALSE which means a column more elaborate was done.} 
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
  \item{\dots}{Other arguments of the print.xtable function (see xtable package).}
}

\author{
  Faria, J. C. \cr
  Allaman, I. B. \cr
  Demétrio C. G. B.
}

\seealso{\code{\link{xtable.bpca}}; \code{\link{xtable}}}

\examples{

## Example 1: Principal labels in portuguese
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

# Example 3: With italic in the rows
tbl2 <- xtable(bp2)
italic <- function(x){
  paste('& \\textit{',
        x, 
        '}')
} # It is necessary the character "&" to adapt the number of column of the table!

print(tbl2,
      sanitize.rownames.function = italic)

}

\keyword{multivariate}
