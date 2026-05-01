# José Cláudio Faria
qbpca <- function(x,
                  bpca)
{
  if (missing(x) || missing(bpca))
    stop('Please, check the parameters x and bpca!')
  if (!inherits(bpca, 'bpca'))
    stop("'bpca' must be an object of class 'bpca'.")

  if (length(bpca$var.rb) == 1)
    if (is.na(bpca$var.rb))
      stop("Please, check parameter 'bpca': var.rb is not available (NA)!")

  cmat <- cor(x)
  comb <- combn(colnames(cmat), 2)
  pair.labels <- apply(comb, 2, paste, collapse=' vs. ')
  qb <- data.frame(obs=cmat[lower.tri(cmat)],
                   var.rb=bpca$var.rb[lower.tri(bpca$var.rb)])
  rownames(qb) <- pair.labels

  class(qb) <- c('qbpca', 'data.frame')
  invisible(qb)
}
