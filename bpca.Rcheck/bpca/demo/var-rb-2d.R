##
## 2D quality comparison using var.rb + qbpca
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

## Differences between methods of factorization
# SQRT
bp_sqrt <- bpca(gabriel1971,
                method='sqrt',
                var.rb=TRUE)

qbp_sqrt <- qbpca(gabriel1971,
                  bp_sqrt)

plot(qbp_sqrt,
     main='sqrt - 2D \n (poor)')

# JK
bp_jk <- bpca(gabriel1971,
              method='jk',
              var.rb=TRUE)

qbp_jk <- qbpca(gabriel1971,
                bp_jk)

plot(qbp_jk,
     main='jk - 2D \n (very poor)')

# HJ
bp_hj <- bpca(gabriel1971,
              method='hj',
              var.rb=TRUE)

qbp_hj <- qbpca(gabriel1971,
                bp_hj)

plot(qbp_hj,
     main='hj - 2D \n (good)')

# GH
bp_gh <- bpca(gabriel1971,
              method='gh',
              var.rb=TRUE)

qbp_gh <- qbpca(gabriel1971,
                bp_gh)

plot(qbp_gh,
     main='gh - 2D \n (good)')

devAskNewPage(oask)

