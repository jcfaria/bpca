test_that("bpca returns expected classes and key components", {
  bp2 <- bpca::bpca(iris[, 1:4], d = 1:2)
  bp3 <- bpca::bpca(iris[, 1:4], d = 1:3)

  expect_s3_class(bp2, "bpca.2d")
  expect_s3_class(bp3, "bpca.3d")

  expect_true(all(c("coord", "importance", "eigenvalues", "eigenvectors") %in% names(bp2)))
  expect_true(all(c("coord", "importance", "eigenvalues", "eigenvectors") %in% names(bp3)))
})

test_that("summary and qbpca run on standard examples", {
  x <- iris[, 1:4]
  bp <- bpca::bpca(x, d = 1:2, var.rb = TRUE)

  expect_no_error(summary(bp))
  expect_no_error(bpca::qbpca(x, bp))
})

test_that("plot methods run without error in non-interactive mode", {
  bp2 <- bpca::bpca(iris[, 1:4], d = 1:2)
  bp3 <- bpca::bpca(iris[, 1:4], d = 1:3)

  expect_no_error(plot(bp2))
  expect_no_error(plot(bp3, rgl.use = FALSE))
})
