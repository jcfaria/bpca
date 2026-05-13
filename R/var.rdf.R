# José Cláudio Faria

# var.rdf: computes the discrepancy between the observed correlation and the
# correlation estimated by the biplot (var.rb), flagging pairs where discrepancy > limit.
#
# Returns a structured list (class 'var.rdf') instead of a plain character data.frame,
# enabling programmatic use beyond tabular display.
# Fields:
#   $display - character data.frame ('*', '', '-') for immediate display.
#   $numeric - numeric matrix of absolute percentage differences.
#   $flagged - logical matrix: TRUE where discrepancy exceeds the limit.
var.rdf <- function(x,
                    var.rb,
                    limit)
{
  if(!is.finite(limit) || length(limit) != 1 || limit < 0)
    stop("'limit' must be a non-negative numeric value.")

  # Absolute percentage difference between observed and biplot correlations.
  dif.num <- 100 * abs(var.rb - cor(x))

  # Logical mask: TRUE where discrepancy exceeds the limit.
  flagged <- dif.num > limit

  # Character representation for tabular display.
  dif.chr          <- matrix('',
                             nrow=nrow(dif.num),
                             ncol=ncol(dif.num))
  dif.chr[flagged] <- '*'    # pair with relevant discrepancy
  diag(dif.chr)    <- '-'    # diagonal: variable against itself

  dif.df <- as.data.frame(dif.chr)
  dimnames(dif.df) <- list(dimnames(x)[[2]],
                           dimnames(x)[[2]])

  dimnames(dif.num) <- list(dimnames(x)[[2]],
                            dimnames(x)[[2]])
  dimnames(flagged) <- list(dimnames(x)[[2]],
                            dimnames(x)[[2]])

  res <- list(display=dif.df,   # character data.frame — for display
              numeric=dif.num,  # numeric matrix of differences in %
              flagged=flagged)  # logical mask for programmatic use

  class(res) <- 'var.rdf'

  return(res)
}

# print.var.rdf: displays the character tabular representation.
# Registered as an S3 method so that print(bp$var.rd) shows the display field.
print.var.rdf <- function(x, ...)
{
  print(x$display, ...)
  invisible(x)
}
