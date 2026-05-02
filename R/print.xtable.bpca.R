# José Cláudio Faria
print.xtable.bpca <- function(x,
                              hline.after=getOption("xtable.hline.after", NULL),
                              include.colnames=getOption("xtable.include.colnames", FALSE),
                              add.to.row=getOption("xtable.add.to.row", NULL),
                              sanitize.text.function=getOption("xtable.sanitize.text.function", NULL),
                              sanitize.rownames.function=getOption("xtable.sanitize.rownames.function", sanitize.text.function),
                              sanitize.colnames.function=getOption("xtable.sanitize.rownames.function", sanitize.text.function), ...)
{
  dots <- list(...)
  type <- if (!is.null(dots$type)) {
    tolower(as.character(dots$type)[1L])
  } else {
    tolower(getOption("xtable.type", "latex"))
  }
  html_out <- identical(type, "html")

  aux_attr <- attr(x,'align')
  attr(x,'align') <- c('l', aux_attr)

  ## LaTeX continuation rows use leading "&"; HTML tables do not.
  if (html_out) {
    sanitizerownamesfunction <- sanitize.rownames.function
  } else if (is.null(sanitize.rownames.function)) {
    morerow <- function(x) paste0("&", x)
    sanitizerownamesfunction <- morerow
  } else {
    morerow <- function(x) paste0("&", sanitize.rownames.function(x))
    sanitizerownamesfunction <- morerow
  }

  if (is.null(sanitize.colnames.function)) {
    sanitize.colnames.function <- function(x) x
  }

  if (is.null(add.to.row)) {
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

    if (html_out) {
      rownames(x) <- c(newvariables,
                       label_eigenval,
                       label_variance)

      cn <- paste0(
        components,
        " (\u03bb",
        whatcomponents,
        "=",
        round(as.numeric(x[nvariables + 1L, ]),
              attr(x, "digits")[2]),
        ")"
      )
      colnames(x) <- sanitize.colnames.function(cn)

      ## Omit only the eigenvalues row (values appear in column headings); keep all
      ## variable rows (LaTeX merges row 1 into \\multirow via add.to.row).
      xsub <- x[-(nvariables + 1L), , drop = FALSE]

      if (is.null(hline.after)) {
        hline.after <- c(-1L, 0L, nrow(xsub))
      }

      ## Prefer visible column headers for HTML unless the caller set include.colnames.
      mc <- match.call(expand.dots = TRUE)
      inc_col <- if ("include.colnames" %in% names(mc)) {
        include.colnames
      } else {
        TRUE
      }

      dots_pass <- dots[setdiff(names(dots), c("type", "include.colnames"))]
      do.call(
        xtable::print.xtable,
        c(
          list(
            x = xsub,
            hline.after = hline.after,
            include.colnames = inc_col,
            sanitize.rownames.function = sanitizerownamesfunction,
            sanitize.colnames.function = sanitize.colnames.function,
            add.to.row = NULL,
            type = "html"
          ),
          dots_pass
        )
      )
      return(invisible(NULL))
    }

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

    if (!is.null(sanitize.rownames.function)) {
      label_eigenvec <- sanitize.rownames.function(label_eigenvec)
      firstvariablerow <- sanitize.rownames.function(newvariables[1])
    } else {
      firstvariablerow <- newvariables[1]
    }
    aux_com1 <- paste(paste("\\hline \n \\multirow{",
                            nvariables,
                            "}{*}{",
                            label_eigenvec,
                            "}",
                            sep=''),
                      firstvariablerow,
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

  if (is.null(hline.after)){

    hline.after <- c(-1,
                     nrow(x[-c(1,nvariables+1),])-2,
                     nrow(x[-c(1,nvariables+1),]))

  }

  print.xtable(x[-c(1,nvariables+1),],
               hline.after=hline.after,
               include.colnames=include.colnames,
               sanitize.rownames.function=sanitizerownamesfunction,
               add.to.row=add.to.row,
               ...)

}
