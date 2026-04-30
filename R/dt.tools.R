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

  x <- as.matrix(x[,bCol])

  n <- ncol(x)
  if (n < 2 )
    stop('x has less than two columns (variables)!')

  switch(center,                                     # of course, if center=1:3
         x <- sweep(x, 1, mean(x)),                  # 1: row mean centering
         x <- sweep(x, 2, apply(x, 2, mean)),        # 2: column mean centering
         x <- sweep(sweep(x, 1, apply(x, 1, mean)),  # 3: double-centering
                    2, apply(x, 2, mean)) + mean(x))

  if(scale) {
    sds <- apply(x, 2, sd)
    sds[sds == 0] <- 1
    x <- sweep(x, 2, sds, '/')
  } else
    x <- x

  lv <- function(x) sqrt(t(x) %*% x)  # length of vector
  l  <- apply(x,
              2,
              lv)
  r  <- diag(n)

  for (i in seq_len(n - 1)) {
    for (j in (i + 1):n) {
      cost <- (t(x[,i]) %*%
               x[,j]) /
      (l[i] * l[j])

    r[j,i] <- cost    # fill lower.tri
    r[i,j] <- r[j,i]  # fill upper.tri
    }
  }

  a <- acos(r) * 180 / pi

  dimnames(r) <- list(colnames(x),
                      colnames(x))

  dimnames(a) <- dimnames(r)

  res <- list(length=l,
              angle=a,
              r=r)

  invisible(res)
}
