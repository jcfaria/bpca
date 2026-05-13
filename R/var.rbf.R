# José Cláudio Faria
var.rbf <- function(x)
{
  if(!is.matrix(x))
    x <- as.matrix(x)

  # Cosine matrix delegated to the shared helper (.cosine_matrix),
  # eliminating duplication with dt.tools().
  # var.rbf operates on rows (variables x components), passes x directly.
  var.rb <- .cosine_matrix(x)

  dimnames(var.rb) <- list(dimnames(x)[[1]],
                           dimnames(x)[[1]])

  return(var.rb)
}
