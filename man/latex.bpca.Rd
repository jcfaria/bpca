\name{latex.bpca}
\alias{latex.bpca}

\title{LaTeX table of the Biplot}

\description{
  This function returns a LaTeX table of the bpca objects.
}

\usage{
latex.bpca(x,
           round=4, 
           where='!tbp',
           caption=NULL,
           label=NULL,
           size='', 
           v.retained='Variance retained (\%)',
           v.partial='Partial',
           v.accumulated='Accumulated',
           eigenvalues='Eigenvalues',
           eigenvectors='Eigenvectors',
           algtable='\\\\flushleft',
           alg1='l',
           alg2='l',
           algnumbers='r',
           algheader='c',
           algsubheader='c',
           pc.label='PC',
           bpca.label=NULL,
           ft.variable='',
           ft.components='',
           hline1='\\\\hline',
           hline2='\\\\hline',
           footnote='')                    
}

\arguments{
  \item{x}{A object of the class \code{\link{bpca}} or a list of the \code{\link{bpca}} objetcs.}
  \item{round}{The numbers of decimal places to be used.
    The default is 4.}
  \item{where}{Specifies the location to which the floating body can move.
    The default is \code{'!tbp'}.
    Possible values are the tabular environment same, e.g., \code{'h'}, \code{'b'} and \code{'p'}.}
  \item{caption}{Is a legend of table. The defaul is \code{NULL}.}
  \item{label}{A text string representing a symbolic label for the table for referencing in the LaTeX
   \code{\\label} and \code{\\ref} commands. \code{label} is useful in a Rnoweb document only if
   caption is also provided.}
  \item{size}{Specifies the font size of the table.
    The default is empty.
    The possible values are the same size used for letters in latex, e.g.,
    \code{'\\\\scriptsize'}, \code{'\\\\large'} and \code{'\\\\LARGE'}.}
  \item{v.retained}{The name of the variance retained to be labeled in the table.
    The default is \code{'Variance retained'}.}
  \item{v.partial}{The name of the variace partial to be labeled in the table. 
    The default is \code{'Partial'}.}
  \item{v.accumulated}{The name of the variance accumulated to be labeled in the table.
    The default is \code{'Accumalated'}.}
  \item{eigenvalues}{The name of eigenvalues to be labeled in the table.
    The default is \code{'Eigenvalues'}.}
  \item{eigenvectors}{The name of eigenvectors to be labeled in the table.
    The default is \code{'Eigenvectors'}.}
  \item{algtable}{Specifies the alignment of the table on page.
    The default is \code{'\\\\flushleft'}. 
    Possible values are: \code{'\\\\flushleft'}, \code{'\\\\centering'} and \code{'\\\\flushright'}.} 
  \item{alg1}{Specifies the alignment of the first column.
    The default is \code{'l'}.
    Possible values are the tabular environment same, e.g., \code{'l'}, \code{'r'} and \code{'c'}.}
  \item{alg2}{Specifies the alignment of the second column.
    The default is \code{'l'}.
    Possible values are the tabular environment same, e.g., \code{'l'}, \code{'r'} and \code{'c'}.} 
  \item{algnumbers}{Specifies the alignment of the numbers column.
    The default is \code{'r'}.
    Possible values are the tabular environment same, e.g., \code{'l'}, \code{'r'} and \code{'c'}.}
  \item{algheader}{Specifies the alignment of the name main column header.
    The default is \code{'c'}.
    Possible values are the tabular environment same, e.g., \code{'l'}, \code{'r'} and \code{'c'}.}
  \item{algsubheader}{Specifies the alignment of the name of the bpca objects. 
    It only works where there is a list of the \code{\link{bpca}} objetcs. 
    The default is \code{'c'}.
    Possible values are the tabular environment same, e.g., \code{'l'}, \code{'r'} and \code{'c'}.}
  \item{pc.label}{The name of principal components to be labeled in the table.
    The default is \code{'PC'}.}
  \item{bpca.label}{The labels of the \code{\link{bpca}} objects.
    Must be used only with a list of the \code{\link{bpca}} objects.} 
  \item{ft.variable}{\code{'bold'} or \code{'italic'} variable names?
    The default is empty.}
  \item{ft.components}{\code{'bold'} or \code{'italic'} components names?
    The default is empty.}
  \item{hline1}{The line type of the table top.
    The default is \code{'\\\\hline'}.} 
  \item{hline2}{The line type of the lower table header.
    The default is \code{'\\\\hline'}.}
  \item{footnote}{To insert footer in the table.
    The default is empty.}
}

\details{ 
  It is necessary to declare the latex packages: \code{threeparttable}, \code{multirow},
  \code{array} and \code{colortbl} in the preable of the Rnoweb file to make available all the 
  resources of the function \code{latex.bpca}.
  
  The function \code{latex.bpca} was developed to make the life easier for those
  who make latex tables with the results of the bpca function.

  Some people could ask: why do not use the \code{\link[Hmisc]{latex}} or \code{\link[xtable]{xtable}} function?
  The \code{\link[Hmisc]{latex}} or \code{\link[xtable]{xtable}} function is a bit complex with many parameters
  for constructing tables.
  It is not always intuitive to all users, discouraging some people to use the \code{\link[Hmisc]{latex}} or
  \code{\link[xtable]{xtable}} function for constructing tables, making the preparation of the bpca analysis
  reports data laborious. 

  The function \code{latex.bpca} is extremely easy to use, requiring only that users provide the names they want
  to print the table. Obviously, the function provides a formatting pre-set according to what the authors think ideal
  for presentation in articles, reports, among others.

  If the user is not satisfied with the formatting provided by function, the functions \code{\link[Hmisc]{latex}} and
  \code{\link[xtable]{xtable}} provides arguments that allow formatting of tables according to user need.
}

\value{
  An object of the class \code{latex.bpca}.
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
  \code{\link{bpca}},
  \code{\link[Hmisc]{latex}},
  \code{\link[xtable]{xtable}}
}  

\examples{
#Example 1: The simplest possible
bp <- bpca(iris[-5],
           d=1:2)

latex.bpca(bp)

#Example 2: with caption 
bp2 <- bpca(gabriel1971) 

latex.bpca(bp2,
           caption='Biplot gabriel1971')

# Example 3: Almost worked
latex.bpca(bp,
           caption='Biplot da base de dados iris',
           v.partial='Parcial',
           v.accumulated='Acumulada',
           eigenvalues='Autovalores',
           eigenvectors='Autovetores',
           v.retained='Var. retida')

# Example 4: Changing the column first alignment
bp3 <- bpca(gge2003,
            d=1:3)

latex.bpca(bp3,
           caption='Biplot gge2003. Changing the column first alignment',    
           alg1='r')

# Example 5: Changing the column second alignment
latex.bpca(bp3,
           caption='Biplot gge2003. Changing the column second alignment',    
           alg2='>{\\\\raggedright}p{0.1cm}')


# Example 6: Changing the column alignment with numbers
latex.bpca(bp3,
           caption='Biplot gge2003. Changing the column alignment with numbers',    
           alg1='r',
           alg2='r',
           algnumbers='>{\\\\raggedleft}p{2.2cm}') 

# Example 7: Changing the header alignment 
latex.bpca(bp3,
           caption='Biplot gge2003. Changing the header alignment',    
           algheader='r')

# Example 8: Changing the table alignment 
latex.bpca(bp3,
           caption='Biplot gge2003. Changing the table alignment',    
           algtable='\\\\flushright')
 
# Example 9: I want only two places decimal
latex.bpca(bp3,
           round=2,
           caption='Biplot gge2003', 
           algnumbers='>{\\\\centering}p{2.2cm}',
           pc.label='Principal Component-')

# Example 10: With bold in the header, subheader and variables
latex.bpca(bp3,
           round=2,
           caption='Biplot gge2003',
           eigenvalues='\\\\textbf{Eigenvalues}',
           eigenvectors='\\\\textbf{Eigenvectors}',
           v.retained='\\\\textbf{Variance retained (\%)}',
           v.partial='\\\\textbf{Partial}',
           v.accumulated='\\\\textbf{Accumulated}',
           ft.variable='bold',
           ft.components='bold')  

# Example 11: The font of table is very large
latex.bpca(bp3,
           round=2,
           caption='Biplot gge2003', 
           pc.label='\\\\textbf{Principal Component-}',           
           size='\\\\tiny')                     

# Example 12: Italic in the variables names
latex.bpca(bp2,
           round=2,
           caption='Biplot gabriel1971',     
           pc.label='\\\\textbf{Principal Component-}',
           algnumbers='>{\\\\centering}p{2.5cm}',
           ft.variable='italic') 

# Example 13: With footnote???
latex.bpca(bp2,
           round=2,
           caption='Biplot gabriel1971',     
           footnote='\\\\scriptsize $^1$ Example with footnote')

# Example 14: Over a footer
latex.bpca(bp2,
           round=2,
           size='\\\\tiny',
           caption='Biplot gabriel1971',     
           footnote='\\\\scriptsize $^1$ Example one.\\\\newline 
           \\\\item $^2$ Example two.')

# Example 15: With others principal components
bp4 <- bpca(gabriel1971,
            d=2:4)

latex.bpca(bp4,
           round=2,
           caption='Biplot gabriel1971')

# Example 16: More than one bpca objects
data(marina)

y_2007 <- subset(marina,
                 year==2007)

y_2008 <- subset(marina,
                 year==2008)

y_2009 <- subset(marina,
                 year==2009)   

bp_2007 <- bpca(y_2007[,-c(1:2)],
                d=1:3)

bp_2008 <- bpca(y_2008[,-c(1:2)],
                d=1:2) 

bp_2009 <- bpca(y_2009[,-c(1:2)],
                d=1:2)      

latex.bpca(list(bp_2007,
                bp_2008),
           round=2,
           caption='Biplot Marina',
           size='\\\\scriptsize')

# Example 17: With two lines in the table
latex.bpca(list(bp_2007,
                bp_2008,
                bp_2009),
           round=4,
           caption='Biplot Marina', 
           pc.label=c('2007','2008','2009'),
           size='\\\\scriptsize',
           hline1='\\\\hline \\\\hline',
           hline2='\\\\hline \\\\hline',
           algnumbers='>{\\\\raggedleft}p{1.3cm}',
           footnote='Note: F - Movie; D - Documentary; DH - Documentary directed by men; DF - Documentary directed by women.')  
}

\keyword{multivariate, table, latex, bpca}

