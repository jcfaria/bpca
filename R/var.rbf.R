# José Cláudio Faria
var.rbf <- function(x)
{
  if (!is.matrix(x))
    x <- as.matrix(x)
  lv <- function(x) sqrt(t(x) %*% x)  # length of vector
  l  <- apply(x,
              1,
              lv)
  n  <- nrow(x)
  var.rb <- diag(n)

  if (n < 2)
    return(var.rb)

  for (i in seq_len(n - 1)) {
    for (j in (i+1):n) {

      cost <- (t(x[i,]) %*%
               x[j,]) /
      (l[i]*l[j])

      var.rb[j,i] <- cost         # fill lower.tri
      var.rb[i,j] <- var.rb[j,i]  # fill upper.tri
    }
  }

  dimnames(var.rb) <- list(dimnames(x)[[1]],
                           dimnames(x)[[1]])
  return(var.rb)
}
