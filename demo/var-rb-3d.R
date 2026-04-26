##
## Example of 'var.rb=TRUE' parameter as a measure of the quality of the biplot - 3d
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

## Differences between methods of factorization
# SQRT
bp_sqrt <- bpca(gabriel1971,
                meth='sqrt',
                d=1:3,
                var.rb=TRUE)

qbp_sqrt <- qbpca(gabriel1971,
                  bp_sqrt)

plot(qbp_sqrt,
     main='sqrt - 3d \n (poor)')

# JK
bp_jk <- bpca(gabriel1971,
              meth='jk',
              d=1:3,
              var.rb=TRUE)

qbp_jk <- qbpca(gabriel1971,
                bp_jk)

plot(qbp_jk,
     main='jk - 3d \n (very poor)')

# HJ
bp_hj <- bpca(gabriel1971,
              meth='hj',
              d=1:3,
              var.rb=TRUE)

qbp_hj <- qbpca(gabriel1971,
                bp_hj)

plot(qbp_hj,
     main='hj - 3d \n (whow!)')

# GH
bp_gh <- bpca(gabriel1971,
              meth='gh',
              d=1:3,
              var.rb=TRUE)

qbp_gh <- qbpca(gabriel1971,
                bp_gh)

plot(qbp_gh,
     main='gh - 3d \n (whow!)')

devAskNewPage(oask)

