### R code from vignette source 'latex-bpca.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: latex-bpca.Rnw:72-80
###################################################
library(xtable) 
library(bpca)

## Example: the simplest possible 
bp1 <- bpca(iris[-5],
            d=1:3)

xtable(bp1)


###################################################
### code chunk number 2: latex-bpca.Rnw:86-92
###################################################
## Example: with caption and label 
bp2 <- bpca(gabriel1971) 

xtable(bp2,
       caption='Biplot of gabriel1971 data.',
       label='tbl_bp2')


###################################################
### code chunk number 3: latex-bpca.Rnw:97-111
###################################################
## Example: principal labels in portuguese
tbl <- xtable(bp2)
rownames(tbl) <- gsub('Eigenvectors',
                      'Autovetores',
                      rownames(tbl))

rownames(tbl) <- c(rownames(tbl)[1:9],
                   'Autovalores',
                   'Variância retida',
                   'Variância acumulada')

dimnames(tbl)[[2]] <- c('CP1','CP2')

print(tbl)


###################################################
### code chunk number 4: latex-bpca.Rnw:116-121
###################################################
## Example: with caption and label 
xtable(bpca(ontario, 
            d=1:3),
       caption='Biplot of ontario data.',
       label='tbl_ontario')


###################################################
### code chunk number 5: latex-bpca.Rnw:126-138
###################################################
## Example: with bold in the column  
tbl1 <- xtable(bp2,
               caption='Biplot of gabriel1971 data.',
               label='tbl_gabriel1971')
bold <- function(x){
  paste('\\textbf{',
        x, 
        '}')
}

print(tbl1,
      sanitize.colnames.function = bold)


###################################################
### code chunk number 6: latex-bpca.Rnw:144-155
###################################################
# Example: with italic in the rows
tbl2 <- xtable(bp2)
italic <- function(x)
{
  paste('& \\textit{',
        x, 
        '}')
} # It is necessary the character "&" to adapt the number of column of the table!

print(tbl2,
      sanitize.rownames.function = italic)


###################################################
### code chunk number 7: latex-bpca.Rnw:159-172
###################################################
##Example: I don't want this formatations (print.xtable.bpca)! Then you can to call directaly the print.xtable function.
italic1 <- function(x)
{
  paste('\\textit{',
        x, 
        '}')
} 
 
print.xtable(tbl,
             sanitize.colnames.function=bold,
             sanitize.rownames.function=italic1)

## To others formatations see ?xtable and/or ?print.xtable!


