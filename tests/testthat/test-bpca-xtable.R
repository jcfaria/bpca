test_that("xtable method returns bpca-aware table object", {
  skip_if_not_installed("xtable")

  bp <- bpca::bpca(iris[, 1:4], d = 1:2)
  tb <- xtable::xtable(bp)

  expect_s3_class(tb, "xtable.bpca")
  expect_s3_class(tb, "xtable")
  expect_gt(nrow(tb), 0)
  expect_equal(ncol(tb), 2)
})

test_that("HTML printing includes variance separators and labels", {
  skip_if_not_installed("xtable")

  bp <- bpca::bpca(rock, d = 1:2)
  tb <- xtable::xtable(bp)
  html_out <- capture.output(print(tb, type = "html"))

  expect_true(any(grepl("Variance retained", html_out, fixed = TRUE)))
  expect_true(any(grepl("Variance accumulated", html_out, fixed = TRUE)))
  expect_true(any(grepl("bpca-xtable", html_out, fixed = TRUE)))
  expect_true(any(grepl("nth-child", html_out, fixed = TRUE)))
})

test_that("LaTeX printing works with explicit hline.after", {
  skip_if_not_installed("xtable")

  bp <- bpca::bpca(rock, d = 1:2)
  tb <- xtable::xtable(bp)

  expect_no_error(print(tb, hline.after = c(-1, 0, 2)))
})
