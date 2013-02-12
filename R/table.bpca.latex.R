table.bpca.latex <- function(x,
                             round=4,
                             v.retained='Variance retained (%)',
                             v.partial='Partial',
                             v.accumulated='Accumulated',
                             eigenvalues='Eigenvalues',
                             eigenvectors='Eigenvectors',
                             cen.just='l',
                             cev.just='r',
                             pc.label='PC',
                             ft.variable='',
                             ...)
{ 
        percent <- length(grep('%',
                               v.retained))
        if(percent)
                v.retained <- sub('%',
                                  '\\\\\\\\%',
                                  v.retained)

        y <- round(x$eigenvectors[, c(x$number)],
                   round)

        eig <- round(x$eigenvalues[c(x$number)],
                     round)

        lambdas <- NULL
        for(i in x$number){
                lambdas[i] <- paste('\\lambda_',
                                    i,
                                    sep='')
        }

        lambdas <- paste('$(',
                         paste(lambdas,
                               eig,
                               sep='='),
                         ')$',
                         sep='')
       
        vret <- x$eigenvalues[x$number[1]:x$number[length(x$number)]]^2 / sum(x$eigenvalues^2)

        if(percent)
                vret <- 100 * vret      

        vret <- round(vret,
                      round)

        vacum <- cumsum(vret)     

        varis <- rownames(y)

        if(ft.variable=='bold')
          varis <- paste('\\textbf{',
                         paste(varis,
                               '}',
                               sep=''),
                         sep='')

        if(ft.variable=='italic')
          varis <- paste('\\textit{',
                         paste(varis,
                               '}',
                               sep=''),
                         sep='') 

        yy <- rbind(y,
                    vret,
                    vacum)

        comp <- colnames(yy)
        
        comp1 <- sub('PC',pc.label,comp)
      
        rownames(yy) <- NULL 

        colnames(yy) <- NULL

        yyy <- cbind(c(varis,
                       v.partial,
                       v.accumulated),
                     yy)

        rowname <- c('\\multirow{numb1}{*}{eigenvectors}',
                     rep('',
                         length(varis) - 1),
                     '\\hline\\multirow{2}{*}{v.retained}','')

        rowname1 <- gsub('eigenvectors',
                         eigenvectors,
                         rowname) 

        rowname2 <- gsub('v.retained',
                         v.retained,
                         rowname1)

        rowname3 <- gsub('numb1',
                         length(varis),
                         rowname2)

        require(Hmisc)

        latex(yyy, 
              collabel.just=rep(cev.just,length(x$number)+3),
              col.just=c(cen.just,
                         rep(cev.just, length(x$number))),
              extracolheads=c('',
                              lambdas),
              cgroup=c('',
                       eigenvalues),
              n.cgroup=c(1,
                         length(x$number)),
              colheads=c('',
                         comp1),
              rowlabel='',
              rowname=rowname3, ...)         
}
