# utils.R — internal shared helpers for the bpca package.
# None of these functions is exported.
# Created during refactoring to eliminate duplication across bpca.default(),
# dt.tools(), var.rbf(), plot.bpca.2d() and plot.bpca.3d().

# ---------------------------------------------------------------------------
# .center_scale: centres and/or scales a numeric matrix.
#
# Extracted from bpca.default() and dt.tools() to eliminate code duplication.
#
# Arguments:
#   x      - numeric matrix already validated by the caller.
#   center - integer 0:3 with semantics:
#              0: no centring
#              1: global centring (subtracts the grand mean)
#              2: column centring (subtracts each column mean)
#              3: double centring (by row and column)
#   scale  - logical; if TRUE divides each column by its standard deviation.
#
# Returns the processed matrix.
# ---------------------------------------------------------------------------
.center_scale <- function(x,
                          center,
                          scale)
{
  x.out <- x                                                  # 0: no centring

  switch(center,
         x.out <- sweep(x, 1, mean(x)),                      # 1: globally centred
         x.out <- sweep(x, 2, apply(x, 2, mean)),            # 2: column centred
         x.out <- sweep(sweep(x, 1, apply(x, 1, mean)),      # 3: double centred
                        2, apply(x, 2, mean)) + mean(x))

  if(scale) {
    sds <- apply(x.out, 2, sd)
    sds[sds == 0] <- 1                                        # avoids division by zero
    x.out <- sweep(x.out, 2, sds, '/')
  }

  x.out
}

# ---------------------------------------------------------------------------
# .cosine_matrix: pairwise cosine similarity matrix between rows of m.
#
# Extracted from var.rbf() and dt.tools() to eliminate algorithmic duplication.
# var.rbf() operates on rows (variables x PCs); dt.tools() operates on columns
# and transposes before calling this function.
#
# Argument:
#   m - matrix; cosines are computed between each pair of rows.
#
# Returns a square symmetric matrix with 1 on the diagonal.
# ---------------------------------------------------------------------------
.cosine_matrix <- function(m)
{
  n  <- nrow(m)
  lv <- function(v) sqrt(crossprod(v))    # L2 norm of a column vector
  l  <- apply(m, 1, lv)                   # norm of each row
  cm <- diag(n)                           # diagonal = 1 (cosine of a vector with itself)

  if(n < 2)
    return(cm)

  for(i in seq_len(n - 1)) {
    for(j in (i + 1):n) {
      # cosine = dot product / product of norms
      cost     <- as.numeric(crossprod(m[i,], m[j,])) / (l[i] * l[j])
      cm[j, i] <- cost     # lower triangle
      cm[i, j] <- cost     # upper triangle (symmetric matrix)
    }
  }

  cm
}

# ---------------------------------------------------------------------------
# .compute_var_factor: automatic scaling factor for variable vectors
#   in biplots, so that variables and objects share the same spread.
#
# Extracted from plot.bpca.2d() and plot.bpca.3d() to eliminate duplication.
#
# Arguments:
#   coobj - object coordinate matrix.
#   covar - variable coordinate matrix.
#
# Returns a single positive numeric value.
# ---------------------------------------------------------------------------
.compute_var_factor <- function(coobj,
                                covar)
{
  max_covar <- max(abs(covar), na.rm=TRUE)

  if(!is.finite(max_covar) || max_covar == 0)
    stop("Cannot compute 'var.factor' automatically: variable coordinates are all zero or non-finite.")

  max(abs(coobj), na.rm=TRUE) / max_covar
}

# ---------------------------------------------------------------------------
# .pc_axis_labels: axis labels in the format "PC1 (38.5%)" for biplots.
#
# Extracted from plot.bpca.2d() and plot.bpca.3d() to eliminate duplication.
#
# Arguments:
#   eigenvalues - full eigenvalue vector from the bpca object.
#   dims        - integer vector of selected PC indices.
#
# Returns a character vector, one label per element of dims.
# ---------------------------------------------------------------------------
.pc_axis_labels <- function(eigenvalues,
                            dims)
{
  prop <- 100 * eigenvalues^2 / sum(eigenvalues^2)

  paste0('PC',
         dims,
         ' (',
         round(prop[dims], 2),
         '%)')
}
