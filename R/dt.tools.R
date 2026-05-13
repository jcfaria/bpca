# José Cláudio Faria
dt.tools <- function(x,
                     center=2,
                     scale=TRUE)
{
  stopifnot(is.matrix(x) || is.data.frame(x))
  if (!is.numeric(center) || length(center) != 1 || !(center %in% 0:3))
    stop("'center' must be one of 0, 1, 2, or 3.")

  bCol <- sapply(x,
                 is.numeric)

  x <- as.matrix(x[, bCol])

  n <- ncol(x)
  if(n < 2)
    stop('x has less than two columns (variables)!')

  # Centring and scaling delegated to the shared helper (.center_scale),
  # eliminating duplication with bpca.default().
  x <- .center_scale(x,
                     center,
                     scale)

  # Cosine matrix via the shared helper (.cosine_matrix).
  # dt.tools operates on columns, so x is transposed so that .cosine_matrix
  # computes cosines between columns of x (= rows of t(x)).
  r <- .cosine_matrix(t(x))

  dimnames(r) <- list(colnames(x),
                      colnames(x))

  # Angle between column vectors (in degrees).
  a <- acos(r) * 180 / pi

  dimnames(a) <- dimnames(r)

  # L2 norm of each column (vector length in the object space).
  l <- apply(x,
             2,
             function(v) sqrt(crossprod(v)))

  res <- list(length=l,
              angle=a,
              r=r)

  invisible(res)
}
