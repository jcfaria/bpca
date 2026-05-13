# José Cláudio Faria

# summary.bpca: computes and returns an object summarising the dimensionality
# reduction. Printing is handled by print.summary.bpca (S3 convention),
# separating computation from display and removing the 'presentation' parameter.
summary.bpca <- function(object, ...)
{
  if(!inherits(object, 'bpca'))
    stop("Use this function only with 'bpca' class!")

  d   <- length(object$number)
  sel <- object$number[1]:object$number[d]
  eig <- object$eigenvalues

  var_each <- eig[sel]^2 / sum(eig^2)
  var_cum  <- cumsum(eig[sel]^2) / sum(eig^2)

  res <- list('Eigenvalue(s)'                   = eig,
              'Considered on reduction'          = eig[sel],
              'Variance retained by each'        = var_each,
              'Cumulative variance retained'     = var_cum,
              'Prop. of total variance retained' = object$importance[1])

  # Partial variance included only when it differs from the total (d > 1 PCs).
  if(object$importance[1] != object$importance[2])
    res$'Prop. of partial variance retained' <- object$importance[2]

  class(res) <- c('summary.bpca', 'listof')

  res
}

# print.summary.bpca: displays the summary on the console.
# Separated from summary.bpca to follow R's S3 convention, where summary()
# returns an object and print() handles the presentation.
# Equivalent to the previous summary.bpca(presentation=TRUE) behaviour.
print.summary.bpca <- function(x, ...)
{
  cat(' Eigenvalue(s):\t\t\t\t',
      x[['Eigenvalue(s)']])

  cat('\n  - Considered on reduction:\t\t',
      x[['Considered on reduction']])

  cat('\n  - Variance retained by each:\t\t',
      x[['Variance retained by each']])

  cat('\n  - Cumulative variance retained:\t',
      x[['Cumulative variance retained']])

  cat('\n  - Prop. of total variance retained:\t',
      x[['Prop. of total variance retained']])

  if(!is.null(x[['Prop. of partial variance retained']]))
    cat('\n  - Prop. of partial variance retained:\t',
        x[['Prop. of partial variance retained']])

  cat('\n')

  invisible(x)
}
