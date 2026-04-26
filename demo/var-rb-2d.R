##
## Example of 'var.rb=TRUE' parameter as a measure of the quality of the biplot - 2d
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

## Differences between methods of factorization
# SQRT
bp_sqrt <- bpca(gabriel1971,
                meth='sqrt',
                var.rb=TRUE)

qbp_sqrt <- qbpca(gabriel1971,
                  bp_sqrt)

plot(qbp_sqrt,
     main='sqrt - 2d \n (poor)')

# JK
bp_jk <- bpca(gabriel1971,
              meth='jk',
              var.rb=TRUE)

qbp_jk <- qbpca(gabriel1971,
                bp_jk)

plot(qbp_jk,
     main='jk - 2d \n (very poor)')

# HJ
bp_hj <- bpca(gabriel1971,
              meth='hj',
              var.rb=TRUE)

qbp_hj <- qbpca(gabriel1971,
                bp_hj)

plot(qbp_hj,
     main='hj - 2d \n (good)')

# GH
bp_gh <- bpca(gabriel1971,
              meth='gh',
              var.rb=TRUE)

qbp_gh <- qbpca(gabriel1971,
                bp_gh)

plot(qbp_gh,
     main='gh - 2d \n (good)')

devAskNewPage(oask)

