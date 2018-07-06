print.xtable.bpca <- function(x,
                              hline.after=getOption("xtable.hline.after", NULL),
                              include.colnames=getOption("xtable.include.colnames", FALSE),
                              add.to.row=getOption("xtable.add.to.row", NULL), 
                              sanitize.text.function=getOption("xtable.sanitize.text.function", NULL), 
                              sanitize.rownames.function=getOption("xtable.sanitize.rownames.function", sanitize.text.function),
                              sanitize.colnames.function=getOption("xtable.sanitize.rownames.function", sanitize.text.function), ...)
{
  aux_attr <- attr(x,'align')
  attr(x,'align') <- c('l', aux_attr)

  if(is.null(sanitize.rownames.function)){
    morerow <- function(x) paste("&",
                                 x,
                                 collpase='')
    sanitize.rownames.function <- morerow
  }

  if(is.null(sanitize.colnames.function)){
    sanitize.colnames.function <- function(x) x
  }

  if(is.null(add.to.row)){
    variables <- rownames(x)[1:(length(rownames(x))-3)]
    nvariables <- length(variables)
    components <- dimnames(x)[[2]]
    ncomponents <- length(components)
    whatcomponents <- as.numeric(gsub("[A-Za-z]*","",components))

    label_eigenvec <- unique(gsub("(\\\\_[\\s\\S]*)",
                                  "",
                                  variables,
                                  perl=TRUE))
    label_eigenval <- rownames(x)[length(rownames(x))-2]
    label_variance <- rownames(x)[-(1:(nvariables+1))]

    newvariables <- gsub(paste(label_eigenvec,
                               "\\\\_",
                               sep=""),
                         "",
                         variables)

    head1 <- paste("&&\\multicolumn{",
                   ncomponents,
                   "}{c}{",
                   sanitize.colnames.function(label_eigenval),
                   "} \\\\ \\cline{3-",
                   length(aux_attr)+1,
                   "}\n",
                   sep="")

    aux_head21 <- c("&& ",
                    rep("",
                        ncomponents-1))

    aux_head22 <- paste(components,
                        " $(\\lambda_",
                        whatcomponents,
                        "=",
                        round(as.numeric(x[nvariables+1,]),
                              attr(x,
                                   'digits')[2]),
                        ")$",
                        sep='')         

    aux_head23 <- paste(aux_head21,
                        sanitize.colnames.function(aux_head22),
                        collapse='&') 

    head2 <- paste(aux_head23,
                   "\\\\ \n ",
                   collapse="")

    aux_com1 <- paste(paste("\\hline \n \\multirow{",
                            nvariables,
                            "}{*}{",
                            sanitize.rownames.function(label_eigenvec),
                            "}",
                            sep=''),
                      newvariables[1],
                      sep='&')

    aux_com11 <- gsub("(&\\s)",
                      "",
                      aux_com1,
                      perl=TRUE)
    aux_com2 <- paste(round(x[1,],
                            attr(x,
                                 'digits')[2]),
                      collapse='&')

    if(include.colnames){
      add.to.row <- list(pos=list(0, 0, 0, 0), 
                         command=NULL)
      aux_head01 <- paste("&",
                          colnames(x))
      aux_head02 <- paste(aux_head01, 
                          collapse="")
      head0 <- paste("&",
                     aux_head02,
                     "\\\\ \n")

      command <- c(head0,
                   head1,
                   head2,
                   paste(paste(aux_com11,
                               aux_com2,
                               sep='&'),
                         '\\\\ \n')) 
    } else {
      add.to.row <- list(pos=list(0, 0, 0), 
                         command=NULL)
      command <- c(head1,
                   head2,
                   paste(paste(aux_com11,
                               aux_com2,
                               sep='&'),
                         '\\\\ \n'))
    }

    add.to.row$command <- command
  }

  rownames(x) <- c(newvariables, 
                   label_eigenval, 
                   label_variance)

  if(is.null(hline.after)){

    hline.after <- c(-1,
                     nrow(x[-c(1,nvariables+1),])-2,
                     nrow(x[-c(1,nvariables+1),]))

  }

  xtable::print.xtable(x[-c(1,nvariables+1),],
                       hline.after=hline.after,
                       include.colnames=FALSE,
                       sanitize.rownames.function=sanitize.rownames.function,
                       add.to.row=add.to.row,
                       ...)

}
