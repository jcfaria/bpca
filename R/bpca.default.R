# José Cláudio Faria
bpca.default <- function(x,
                         d=1:2,
                         center=2,
                         scale=TRUE,
                         method=c('hj', 'sqrt', 'jk', 'gh'),
                         iec=FALSE,
                         var.rb=FALSE,
                         var.rd=FALSE,
                         limit=10, ...)
{
  stopifnot(is.matrix(x) || is.data.frame(x))
  if (!is.numeric(center) || length(center) != 1 || !(center %in% 0:3))
    stop("'center' must be one of 0, 1, 2, or 3.")

  li <- d[1]
  le <- d[length(d)]
  n.lambda <- (le - li + 1)

  if(n.lambda < 2 || n.lambda > 3)
    stop('Please, check the parameter d:\n',
         'The (d[1] - d[length(d)] + 1) must equal to 2 (for bpca.2d) or 3 (for bpca.3d).\n\n')

  x <- as.matrix(x)
  if (!is.numeric(x))
    stop("'x' must contain only numeric values.")
  if (!is.finite(limit) || length(limit) != 1 || limit < 0)
    stop("'limit' must be a non-negative numeric value.")
  if (li < 1 || le > min(dim(x)))
    stop("Requested dimensions in 'd' are out of bounds for input matrix.")

  # Centring and scaling delegated to the shared helper (.center_scale),
  # eliminating duplication with dt.tools().
  x.scal <- .center_scale(x,
                          center,
                          scale)

  svdx.scal <- svd(x.scal)

  rownames(svdx.scal$u) <- rownames(x) # obj
  rownames(svdx.scal$v) <- colnames(x) # var

  # pc.names generated once and reused for svdx.scal$v, g.scal and hl.scal,
  # eliminating the duplicate generation that existed previously.
  pc.names <- paste('PC',
                    seq_along(svdx.scal$d),
                    sep='')

  colnames(svdx.scal$v) <- pc.names

  s2.scal <- diag(svdx.scal$d)

  switch(match.arg(method),
         hj={
           g.scal  <- svdx.scal$u %*% s2.scal
           h.scal  <- s2.scal %*% t(svdx.scal$v)
           hl.scal <- t(h.scal)
         },
         sqrt={
           g.scal  <- svdx.scal$u %*% sqrt(s2.scal)
           h.scal  <- sqrt(s2.scal) %*% t(svdx.scal$v)
           hl.scal <- t(h.scal)
         },
         jk={
           g.scal  <- svdx.scal$u %*% s2.scal
           hl.scal <- svdx.scal$v
         },
         gh={
           g.scal  <- sqrt(nrow(x)-1) * svdx.scal$u
           h.scal  <- 1/sqrt(nrow(x)-1) * s2.scal %*% t(svdx.scal$v)
           hl.scal <- t(h.scal)
         })

  # Row and column labels for the coordinate matrices, using the already-computed pc.names.
  if(is.null(rownames(x.scal)))
    rownames(g.scal) <- seq_len(nrow(x.scal))
  else
    rownames(g.scal) <- rownames(x.scal)

  colnames(g.scal) <- pc.names

  if(is.null(colnames(x.scal)))
    rownames(hl.scal) <- paste('V',
                               seq_len(ncol(x)),
                               sep='')
  else
    rownames(hl.scal) <- colnames(x.scal)

  colnames(hl.scal) <- pc.names

  # Computation of representation quality matrices (optional).
  if(isTRUE(var.rb))
    var.rb.res <- var.rbf(hl.scal[, d[1]:d[length(d)]])
  else
    var.rb.res <- NA

  if(isTRUE(var.rb) && isTRUE(var.rd))
    var.rd.res <- var.rdf(x.scal,
                          var.rb.res,
                          limit)
  else
    var.rd.res <- NA

  # Optional sign inversion (iec = invert eigenvector convention).
  if(iec){
    svdx.scal$v <- (-1) * svdx.scal$v
    g.scal      <- (-1) * g.scal
    hl.scal     <- (-1) * hl.scal
  }

  res <- list(call=match.call(),
              eigenvalues=svdx.scal$d,
              eigenvectors=svdx.scal$v,
              number=seq(li, le, 1),
              importance=rbind(general=round(sum(svdx.scal$d[li:le]^2) /
                                             sum(svdx.scal$d^2), 3),
                               partial=round(sum(svdx.scal$d[li:le]^2) /
                                             sum(svdx.scal$d[li:length(svdx.scal$d)]^2), 3)),
              coord=list(objects=g.scal,
                         variables=hl.scal),
              var.rb=var.rb.res,
              var.rd=var.rd.res)

  colnames(res$importance) <- 'explained'

  if(n.lambda == 2)
    class(res) <- c('bpca.2d',
                    'bpca',
                    'list')
  else if(n.lambda == 3)
    class(res) <- c('bpca.3d',
                    'bpca',
                    'list')

  invisible(res)
}
