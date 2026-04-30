##
## Example of `var.rb=TRUE` as a biplot quality measure (3D)
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

## Differences between methods of factorization
# SQRT
bp_sqrt <- bpca(gabriel1971,
                method='sqrt',
                d=1:3,
                var.rb=TRUE)

qbp_sqrt <- qbpca(gabriel1971,
                  bp_sqrt)

plot(qbp_sqrt,
     main='sqrt - 3D \n (poor)')

# JK
bp_jk <- bpca(gabriel1971,
              method='jk',
              d=1:3,
              var.rb=TRUE)

qbp_jk <- qbpca(gabriel1971,
                bp_jk)

plot(qbp_jk,
     main='jk - 3D \n (very poor)')

# HJ
bp_hj <- bpca(gabriel1971,
              method='hj',
              d=1:3,
              var.rb=TRUE)

qbp_hj <- qbpca(gabriel1971,
                bp_hj)

plot(qbp_hj,
     main='hj - 3D \n (wow!)')

# GH
bp_gh <- bpca(gabriel1971,
              method='gh',
              d=1:3,
              var.rb=TRUE)

qbp_gh <- qbpca(gabriel1971,
                bp_gh)

plot(qbp_gh,
     main='gh - 3D \n (wow!)')

devAskNewPage(oask)

