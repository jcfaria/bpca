# José Cláudio Faria
summary.bpca <- function(object,
                         presentation=FALSE, ...)
{
  if (!inherits(object, 'bpca'))
    stop("Use this function only with 'bpca' class!")

  d <- length(object$number)
  sel <- object$number[1]:object$number[d]
  eig <- object$eigenvalues
  var_each <- eig[sel]^2 / sum(eig^2)
  var_cum <- cumsum(eig[sel]^2) / sum(eig^2)

  if(!presentation){
    x <- list('Eigenvalue(s)' = eig,
              'Considered on reduction' = eig[sel],
              'Variance retained by each' = var_each,
              'Cumulative variance retained' = var_cum,
              'Prop. of total variance retained' = object$importance[1]) 

    if(object$importance[1] != object$importance[2]) 
      x$'Prop. of partial variance retained' = object$importance[2]

    class(x) <- c('summary.bpca', 'listof')

    x

  } else {

    cat(' Eigenvalue(s):\t\t\t\t',
        eig)

    cat('\n  - Considered on reduction:\t\t',
        eig[sel])

    cat('\n  - Variance retained by each:\t\t',
        var_each)

    cat('\n  - Cumulative variance retained:\t',
        var_cum)

    cat('\n  - Prop. of total variance retained:\t',
        object$importance[1])

    if(object$importance[1] != object$importance[2])
      cat('\n  - Prop. of partial variance retained:\t',
          object$importance[2])

    cat('\n')
  }
}
