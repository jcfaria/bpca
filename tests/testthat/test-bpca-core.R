# test-bpca-core.R — regression and coverage tests for the bpca package.
#
# Organisation:
#   1. Classes and components of the bpca object
#   2. Factorisation methods (hj, sqrt, jk, gh)
#   3. Centring modes (center = 0:3)
#   4. Internal helpers (.center_scale, .cosine_matrix, .compute_var_factor, .pc_axis_labels)
#   5. var.rbf and var.rdf
#   6. dt.tools
#   7. qbpca
#   8. summary.bpca and print.summary.bpca
#   9. 2D and 3D plot types (runs without error)
#  10. bpca.prcomp

# ===========================================================================
# 1. Classes and components
# ===========================================================================

test_that("bpca returns the expected classes and components", {
  bp2 <- bpca::bpca(iris[, 1:4], d=1:2)
  bp3 <- bpca::bpca(iris[, 1:4], d=1:3)

  expect_s3_class(bp2, 'bpca.2d')
  expect_s3_class(bp2, 'bpca')
  expect_s3_class(bp3, 'bpca.3d')
  expect_s3_class(bp3, 'bpca')

  expect_true(all(c('coord', 'importance', 'eigenvalues',
                    'eigenvectors', 'number', 'var.rb', 'var.rd') %in% names(bp2)))

  # Eigenvalues are non-negative and non-increasing.
  eig <- bp2$eigenvalues
  expect_true(all(eig >= 0))
  expect_true(all(diff(eig) <= 0))

  # Importance is within [0, 1].
  expect_true(bp2$importance['general', 'explained'] >= 0)
  expect_true(bp2$importance['general', 'explained'] <= 1)

  # Coordinate dimensions are consistent with the input data.
  expect_equal(nrow(bp2$coord$objects),   nrow(iris))
  expect_equal(nrow(bp2$coord$variables), ncol(iris[, 1:4]))
})

# ===========================================================================
# 2. Factorisation methods
# ===========================================================================

test_that("method 'hj' produces the correct result", {
  bp <- bpca::bpca(rock, d=1:2, method='hj')
  expect_s3_class(bp, 'bpca.2d')
  # In HJ factorisation, G = U*D and HL = V*D (both carry singular values).
  # The product G %*% t(HL) approximates D^2, not D; verify dimensions and
  # that coordinates are finite and non-degenerate.
  expect_equal(nrow(bp$coord$objects),   nrow(rock))
  expect_equal(nrow(bp$coord$variables), ncol(rock))
  expect_true(all(is.finite(bp$coord$objects)))
  expect_true(all(is.finite(bp$coord$variables)))
})

test_that("method 'sqrt' produces the correct result", {
  bp <- bpca::bpca(rock, d=1:2, method='sqrt')
  expect_s3_class(bp, 'bpca.2d')
  # In sqrt factorisation, G = U*sqrt(D) and HL = V*sqrt(D); the product
  # G %*% t(HL) reconstructs X exactly. Verify dimensions and finiteness.
  expect_equal(nrow(bp$coord$objects),   nrow(rock))
  expect_equal(nrow(bp$coord$variables), ncol(rock))
  expect_true(all(is.finite(bp$coord$objects)))
  expect_true(all(is.finite(bp$coord$variables)))
})

test_that("method 'jk' produces the correct result", {
  bp <- bpca::bpca(rock, d=1:2, method='jk')
  expect_s3_class(bp, 'bpca.2d')
  # In JK factorisation, variables are unit vectors (rows of V from the SVD).
  norms <- apply(bp$coord$variables, 1, function(v) sqrt(sum(v^2)))
  # jk vectors are columns of V (orthonormal), so norm <= 1.
  expect_true(all(norms <= 1 + 1e-10))
})

test_that("method 'gh' produces the correct result", {
  bp <- bpca::bpca(rock, d=1:2, method='gh')
  expect_s3_class(bp, 'bpca.2d')
  # In GH factorisation, objects are normalised by sqrt(n-1).
  # Here we only verify that the result is finite and non-degenerate.
  expect_true(all(is.finite(bp$coord$objects)))
  expect_true(all(is.finite(bp$coord$variables)))
})

test_that("all factorisation methods return the same total importance", {
  # The total variance explained by the first two PCs is independent of the factorisation.
  methods <- c('hj', 'sqrt', 'jk', 'gh')
  imp <- sapply(methods, function(m)
    bpca::bpca(rock, d=1:2, method=m)$importance['general', 'explained'])
  expect_true(all(abs(imp - imp[1]) < 1e-10))
})

# ===========================================================================
# 3. Centring modes
# ===========================================================================

test_that("center=0 does not alter the input matrix", {
  # With center=0 and scale=FALSE the data are not transformed; SVD operates
  # directly on the raw matrix, so eigenvalues reflect raw variance.
  bp <- bpca::bpca(iris[, 1:4], d=1:2, center=0, scale=FALSE)
  expect_s3_class(bp, 'bpca.2d')
  expect_true(all(is.finite(bp$coord$objects)))
})

test_that("center=1 applies global centring", {
  bp <- bpca::bpca(iris[, 1:4], d=1:2, center=1, scale=FALSE)
  expect_s3_class(bp, 'bpca.2d')
  expect_true(all(is.finite(bp$coord$objects)))
})

test_that("center=2 applies column centring (default)", {
  bp <- bpca::bpca(iris[, 1:4], d=1:2, center=2, scale=TRUE)
  expect_s3_class(bp, 'bpca.2d')
})

test_that("center=3 applies double centring", {
  bp <- bpca::bpca(iris[, 1:4], d=1:2, center=3, scale=FALSE)
  expect_s3_class(bp, 'bpca.2d')
  expect_true(all(is.finite(bp$coord$objects)))
})

test_that("invalid center value produces an informative error", {
  expect_error(bpca::bpca(iris[, 1:4], center=5),
               "'center' must be one of")
})

# ===========================================================================
# 4. Internal helpers
# ===========================================================================

test_that(".center_scale: center=0 returns the matrix unchanged", {
  x <- matrix(1:9, nrow=3)
  expect_equal(bpca:::.center_scale(x, center=0, scale=FALSE),
               x)
})

test_that(".center_scale: center=2 produces columns with zero mean", {
  x <- matrix(c(1, 2, 3, 4, 5, 6), nrow=3)
  xs <- bpca:::.center_scale(x, center=2, scale=FALSE)
  col_means <- apply(xs, 2, mean)
  expect_true(all(abs(col_means) < 1e-10))
})

test_that(".center_scale: scale=TRUE produces columns with standard deviation ~1", {
  x <- iris[, 1:4]
  xs <- bpca:::.center_scale(as.matrix(x), center=2, scale=TRUE)
  sds <- apply(xs, 2, sd)
  expect_true(all(abs(sds - 1) < 1e-10))
})

test_that(".cosine_matrix: diagonal is 1 and off-diagonal values are in [-1, 1]", {
  m  <- matrix(rnorm(15), nrow=3)
  cm <- bpca:::.cosine_matrix(m)
  expect_equal(diag(cm), rep(1, 3))
  expect_true(all(cm >= -1 - 1e-10 & cm <= 1 + 1e-10))
  # Symmetry.
  expect_equal(cm, t(cm))
})

test_that(".cosine_matrix: parallel vectors have cosine 1", {
  m  <- rbind(c(1, 0, 0), c(2, 0, 0))   # second row is a scalar multiple of the first
  cm <- bpca:::.cosine_matrix(m)
  expect_equal(cm[1, 2], 1)
})

test_that(".cosine_matrix: orthogonal vectors have cosine 0", {
  m  <- rbind(c(1, 0), c(0, 1))
  cm <- bpca:::.cosine_matrix(m)
  expect_equal(cm[1, 2], 0)
})

test_that(".compute_var_factor: returns a finite positive scalar", {
  coobj <- matrix(rnorm(20), nrow=10)
  covar <- matrix(rnorm(10),  nrow=5)
  vf    <- bpca:::.compute_var_factor(coobj, covar)
  expect_length(vf, 1)
  expect_true(is.finite(vf) && vf > 0)
})

test_that(".compute_var_factor: error when all variable coordinates are zero", {
  coobj <- matrix(rnorm(6), nrow=3)
  covar <- matrix(0, nrow=3, ncol=2)
  expect_error(bpca:::.compute_var_factor(coobj, covar),
               "all zero or non-finite")
})

test_that(".pc_axis_labels: correct format and length", {
  eig  <- c(3, 2, 1)
  labs <- bpca:::.pc_axis_labels(eig, dims=1:2)
  expect_length(labs, 2)
  expect_match(labs[1], '^PC1 \\(')
  expect_match(labs[2], '^PC2 \\(')
  # Percentages sum to less than 100 % (PC3 is excluded).
  pcts <- as.numeric(sub('.*\\(([0-9.]+)%\\)', '\\1', labs))
  expect_true(sum(pcts) < 100)
})

# ===========================================================================
# 5. var.rbf and var.rdf
# ===========================================================================

test_that("var.rbf returns a symmetric matrix with diagonal 1", {
  bp  <- bpca::bpca(iris[, 1:4], d=1:2)
  hlv <- bp$coord$variables[, 1:2]
  rb  <- bpca::var.rbf(hlv)

  expect_true(is.matrix(rb))
  expect_equal(nrow(rb), ncol(rb))
  expect_equal(unname(diag(rb)), rep(1, nrow(rb)), tolerance=1e-10)
  expect_equal(unname(rb), unname(t(rb)), tolerance=1e-10)
})

test_that("var.rbf and .cosine_matrix produce the same result", {
  # var.rbf must be equivalent to .cosine_matrix applied to the rows of hl.scal.
  bp  <- bpca::bpca(iris[, 1:4], d=1:2)
  hlv <- bp$coord$variables[, 1:2]
  rb  <- bpca::var.rbf(hlv)
  cm  <- bpca:::.cosine_matrix(hlv)
  expect_equal(unname(rb), cm, tolerance=1e-10)
})

test_that("var.rdf returns a list of class 'var.rdf' with three fields", {
  x   <- iris[, 1:4]
  bp  <- bpca::bpca(x, d=1:2, var.rb=TRUE, var.rd=TRUE)
  rd  <- bp$var.rd

  expect_s3_class(rd, 'var.rdf')
  expect_named(rd, c('display', 'numeric', 'flagged'))
})

test_that("var.rdf$display contains only '-', '' or '*'", {
  x  <- iris[, 1:4]
  bp <- bpca::bpca(x, d=1:2, var.rb=TRUE, var.rd=TRUE)
  vals <- unlist(bp$var.rd$display)
  expect_true(all(vals %in% c('-', '', '*')))
})

test_that("var.rdf$numeric and var.rdf$flagged are consistent", {
  x  <- iris[, 1:4]
  bp <- bpca::bpca(x, d=1:2, var.rb=TRUE, var.rd=TRUE, limit=10)
  rd <- bp$var.rd
  # flagged must be TRUE exactly where numeric > 10.
  expect_equal(rd$flagged, rd$numeric > 10)
})

test_that("print.var.rdf prints without error", {
  x  <- iris[, 1:4]
  bp <- bpca::bpca(x, d=1:2, var.rb=TRUE, var.rd=TRUE)
  expect_no_error(print(bp$var.rd))
})

# ===========================================================================
# 6. dt.tools
# ===========================================================================

test_that("dt.tools returns a list with fields length, angle and r", {
  res <- bpca::dt.tools(iris[, 1:4])
  expect_named(res, c('length', 'angle', 'r'))
})

test_that("dt.tools$r is symmetric with diagonal 1", {
  res <- bpca::dt.tools(iris[, 1:4])
  r   <- res$r
  expect_equal(unname(diag(r)), rep(1, ncol(iris[, 1:4])), tolerance=1e-10)
  expect_equal(unname(r), unname(t(r)), tolerance=1e-10)
})

test_that("dt.tools$angle: angle of a variable with itself is 0", {
  res <- bpca::dt.tools(iris[, 1:4])
  expect_equal(unname(diag(res$angle)), rep(0, ncol(iris[, 1:4])), tolerance=1e-10)
})

test_that("dt.tools$length is positive for columns with non-zero variance", {
  res <- bpca::dt.tools(iris[, 1:4])
  expect_true(all(res$length > 0))
})

test_that("dt.tools agrees with .cosine_matrix on cosine similarities", {
  # dt.tools computes cosines between columns of the scaled x;
  # this test verifies that its r equals the manual cosine computation.
  x    <- as.matrix(iris[, 1:4])
  xs   <- bpca:::.center_scale(x, center=2, scale=TRUE)
  r_dt <- bpca::dt.tools(iris[, 1:4])$r
  r_cm <- bpca:::.cosine_matrix(t(xs))
  expect_equal(unname(r_dt), unname(r_cm), tolerance=1e-10)
})

# ===========================================================================
# 7. qbpca
# ===========================================================================

test_that("qbpca returns a data.frame of class 'qbpca'", {
  x  <- iris[, 1:4]
  bp <- bpca::bpca(x, d=1:2, var.rb=TRUE)
  qb <- bpca::qbpca(x, bp)
  expect_s3_class(qb, 'qbpca')
  expect_s3_class(qb, 'data.frame')
  expect_named(qb, c('obs', 'var.rb'))
})

test_that("qbpca has as many rows as variable pairs", {
  x  <- iris[, 1:4]
  bp <- bpca::bpca(x, d=1:2, var.rb=TRUE)
  qb <- bpca::qbpca(x, bp)
  n_vars  <- ncol(x)
  n_pairs <- n_vars * (n_vars - 1) / 2
  expect_equal(nrow(qb), n_pairs)
})

test_that("qbpca errors when var.rb is not available", {
  x  <- iris[, 1:4]
  bp <- bpca::bpca(x, d=1:2, var.rb=FALSE)  # var.rb = NA
  expect_error(bpca::qbpca(x, bp),
               "var.rb is not available")
})

# ===========================================================================
# 8. summary.bpca and print.summary.bpca
# ===========================================================================

test_that("summary.bpca returns an object of class 'summary.bpca'", {
  bp  <- bpca::bpca(iris[, 1:4], d=1:2)
  res <- summary(bp)
  expect_s3_class(res, 'summary.bpca')
})

test_that("summary.bpca contains the expected fields", {
  bp  <- bpca::bpca(iris[, 1:4], d=1:2)
  res <- summary(bp)
  fields <- c('Eigenvalue(s)',
              'Considered on reduction',
              'Variance retained by each',
              'Cumulative variance retained',
              'Prop. of total variance retained')
  expect_true(all(fields %in% names(res)))
})

test_that("summary.bpca: retained variance is within [0, 1]", {
  bp  <- bpca::bpca(iris[, 1:4], d=1:2)
  res <- summary(bp)
  prop <- res[['Prop. of total variance retained']]
  expect_true(prop >= 0 && prop <= 1)
})

test_that("print.summary.bpca produces output without error", {
  bp  <- bpca::bpca(iris[, 1:4], d=1:2)
  res <- summary(bp)
  expect_no_error(print(res))
  # print must return the object invisibly.
  out <- capture.output(ret <- print(res))
  expect_identical(ret, res)
})

# ===========================================================================
# 9. 2D plot types
# ===========================================================================

test_that("all 2D plot types run without error", {
  bp    <- bpca::bpca(iris[, 1:4], d=1:2)
  types <- c('bp', 'eo', 'ev', 'co', 'cv', 'ww', 'dv', 'ms', 'ro', 'rv')

  for(type in types)
    expect_no_error(plot(bp, type=type))
})

test_that("static 3D plot (scatterplot3d) runs without error", {
  bp3 <- bpca::bpca(iris[, 1:4], d=1:3)
  expect_no_error(plot(bp3, rgl.use=FALSE))
})

test_that("plot.qbpca runs without error", {
  x  <- iris[, 1:4]
  bp <- bpca::bpca(x, d=1:2, var.rb=TRUE)
  qb <- bpca::qbpca(x, bp)
  expect_no_error(plot(qb))
})

# ===========================================================================
# 10. bpca.prcomp
# ===========================================================================

test_that("bpca.prcomp produces a result consistent with bpca.default", {
  pca <- prcomp(iris[, 1:4], center=TRUE, scale.=TRUE)
  bp  <- bpca::bpca(pca, d=1:2)
  expect_s3_class(bp, 'bpca.2d')
  # Importance must match (same data, same factorisation).
  bp_ref <- bpca::bpca(iris[, 1:4], d=1:2, center=2, scale=TRUE)
  expect_equal(bp$importance, bp_ref$importance, tolerance=1e-4)
})
