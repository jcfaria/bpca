\name{table.bpca.latex}
\alias{table.bpca.latex}

\title{LaTeX table of the Biplot}

\description{
  This function returns a LaTeX table of the Biplot.
}

\usage{
table.bpca.latex(x,
                 round=4,
                 v.retained="Variance retained (\%)",
                 v.partial="Partial",
                 v.accumulated="Accumulated",
                 eigenvalues="Eigenvalues",
                 eigenvectors="Eigenvectors",
                 cen.just="l",
                 cev.just="r",
                 pc.label="PC",
                 ft.variable='', \dots)
}

\arguments{
  \item{x}{A object of the class \code{\link{bpca}}.}
  \item{round}{The numbers of decimal places to be used. The same function of the package base. The default is 4.}
  \item{v.retained}{The name of the variance retained to be labeled in the table. The default is \code{"Partial"}.}
  \item{v.partial}{The name of the variace partial to be labeled in the table. The default is \code{"Accumulated"}.}
  \item{v.accumulated}{The name of the variance accumulated to be labeled in the table. The default is \code{"Eigenvalues"}.}
  \item{eigenvalues}{The name of eigenvalues to be labeled in the table. The default is \code{"Eigenvalues"}.}
  \item{eigenvectors}{The name of eigenvectors to be labeled in the table. The default is \code{"Eigenvectors"}.}
  \item{cen.just}{Specifies the justification of row label. The default is \code{"l"}.
    Possible values are the tabular environment tabular same, e.g., \code{"l"}, \code{"c"} and \code{"r"}.}
  \item{cev.just}{Specifies the justification of principal components column.
    The default is \code{"r"}. Possible values are the tabular environment tabular same, e.g., \code{"l"}, \code{"c"} and \code{"r"}.}
  \item{pc.label}{The name of the principal components to be labeled in the table. The default is \code{"PC"}.}
  \item{ft.variable}{Formatation of the variable names. Possible values are: \code{"bold"} or \code{"italic"}. The default is empty.}  
  \item{\dots}{Other arguments to be passed to the function \code{\link[xtable]{xtable}} (\code{\link[Hmisc]{Hmisc.Overview}}).}                
}

\details{ 
  The table.bpca.latex is a function developed in order to make life easier for those who make latex tables
  with the results of the bpca function. In essence, the table.bpca.latex function uses the powerful \code{\link[Hmisc]{latex}}
  function of the package \code{Hmisc}.

  Some may wonder, why not use directly the latex function?
  The latex function is a bit complex with many parameters for constructing tables and it is not always intuitive to users.
  So, this makes the preparation of analysis reports data laborious.

  The function table.bpca.latex is extremely easy to use, requiring only that users provide the names they want to print the table.
  Obviously the function provides a formatting pre-set according to what the authors think ideal for presentation in articles,
  reports, among others.

  If the user is not satisfied with the formatting provided by function, the packages
  \code{\link[Hmisc]{Hmisc.Overview}} and \code{\link[xtable]{xtable}}
  provides functions that allow formatting of tables according to user need.

  The LaTeX packages \code{multirow} must be declared in the preable of the R noweb file (\code{\\usepackage{multirow}} to all
  examples and the package \code{colortbl} to the Example 12 \code{\\usepackage{colortbl}}.
}

\value{
  An object of class \emph{latex}.
}

\author{
  Jose Claudio Faria (\email{joseclaudio.faria@gmail.com})\cr
  Clarice Garcia Borges Demetrio (\email{clarice@esalq.usp.br})\cr
  and\cr
  Ivan Bezerra Allaman (\email{ivanalaman@gmail.com})
}

\references{
  Johnson, R. A. and Wichern, D. W. (1988)
  \emph{Applied multivariate statistical analysis}.
  Prentice-Hall, Inc., Upper Saddle River, NJ, USA, 6 ed.
}

\seealso{
  \code{\link[Hmisc]{latex}}, \code{\link[xtable]{xtable}}.
}

\examples{

# Example 1: Default       
bp <- bpca(iris[-5],
           d=1:2)

table.bpca.latex(bp,
                 file='')                         # Argument latex/Hmisc 

# Example 2: Almost worked 

bp2 <- bpca(gabriel1971) 

table.bpca.latex(bp2,
                 caption='Biplot gabriel1971',    # Argument latex/Hmisc  
                 cen.just='r',
                 cev.just='l',
                 file='')                         # Argument latex/Hmisc 


# Example 3: Changing a lot to Portuguese 
table.bpca.latex(bp,
                 caption="Biplot da base de dados iris",   # Argument latex/Hmisc  
                 v.partial="Parcial",
                 v.accumulated="Acumulada",
                 eigenvalues="Autovalores",
                 eigenvectors="Autovetores",
                 v.retained="Var. retida (\%)",
                 cen.just="l",
                 cev.just="r", 
                 pc.label="CP",
                 first.hline.double=FALSE,                 # Argument latex/Hmisc 
                 file='')                                  # Argument latex/Hmisc 

# Example 4: Changing the column width
bp3 <- bpca(gge2003,
            d=1:2)

table.bpca.latex(bp3,
                 caption='Biplot gge2003',    # Argument latex/Hmisc 
                 cev.just='p{2.5cm}',
                 pc.label='Principal Components-',
                 file='')                     # Argument latex/Hmisc 

# Example 5: I want only two places decimal
table.bpca.latex(bp3,
                 round=2,
                 caption='Biplot gge2003',    # Argument latex/Hmisc
                 pc.label='Principal Component-',
                 file='')                     # Argument latex/Hmisc 

# Example 6: Without bold in the column header
table.bpca.latex(bp3,
                 round=2,
                 caption='Biplot gge2003',    # Argument latex/Hmisc    
                 cgroupTexCmd='',             # Argument latex/Hmisc 
                 file='')                     # Argument latex/Hmisc 

# Example 7: Bold in the subheader of the column 
table.bpca.latex(bp3,
                 round=2,
                 caption='Biplot gge2003',    # Argument latex/Hmisc
                 pc.label='\\\\textbf{Principal Component-}',
                 file='')                     # Argument latex/Hmisc 

# Example 8: The font of lambdas is very small
table.bpca.latex(bp3,
                 round=2,
                 caption='Biplot gge2003', 
                 pc.label='\\\\textbf{Principal Component-}',   # Argument latex/Hmisc 
                 extracolsize='normalsize',                     # Argument latex/Hmisc 
                 file='')                                       # Argument latex/Hmisc

# Example 9: Bold in the variable names
table.bpca.latex(bp3,
                 round=2,
                 caption='Biplot gge2003',    # Argument latex/Hmisc 
                 pc.label='\\\\textbf{Principal Component-}',
                 extracolsize='normalsize',   # Argument latex/Hmisc 
                 ft.variable='bold',
                 file='')                     # Argument latex/Hmisc 

# Example 10: Italic in the variable names
table.bpca.latex(bp3,
                 round=2,
                 caption='Biplot gge2003',    # Argument latex/Hmisc 
                 pc.label='\\\\textbf{Principal Component-}',
                 extracolsize='normalsize',   # Argument latex/Hmisc 
                 ft.variable='italic',
                 file='')                     # Argument latex/Hmisc 

# Example 11: All bold header
table.bpca.latex(bp3,
                 round=2,
                 caption='Biplot gge2003',    # Argument latex/Hmisc 
                 pc.label='\\\\textbf{Principal Component-}',
                 eigenvectors='\\\\textbf{Eigenvectors}',
                 v.partial='\\textbf{Partial}',
                 v.accumulated='\\textbf{Accumulated}',
                 v.retained='\\\\textbf{Variance retained (\%)}',
                 extracolsize='normalsize',   # Argument latex/Hmisc 
                 ft.variable='bold',
                 file='')                     # Argument latex/Hmisc 

# Example 12: Some curiosities 
# It needs of the latex package: colortbl 
cell.format <- matrix(rep('',
                          15),
                      ncol=3)

cell.format[1,3] <- 'color{red}'
cell.format[2,2] <- 'color{red}'
cell.format[3,2] <- 'color{red}'

cell.format[1,2] <- 'cellcolor{green}'
cell.format[2,3] <- 'cellcolor{green}'
cell.format[3,3] <- 'cellcolor{green}'

table.bpca.latex(bp3,
                 caption='More important in red color',
                 cellTexCmds=cell.format,     # Argument latex/Hmisc
                 file='')                     # Argument latex/Hmisc

# Example 13: Assignment
tbl <- table.bpca.latex(bp3,
                        caption='Assignment',
                        file='')              # Argument latex/Hmisc
tbl 
}

\keyword{multivariate, table, latex}
