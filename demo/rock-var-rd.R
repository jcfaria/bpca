##
## Diagnostic workflow for var.rd using the rock dataset
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp <- bpca(rock,
           var.rb=TRUE,
           var.rd=TRUE)
summary(bp)

# The total variance explained is satisfactory (>= .80)!

plot(bp)

# A more accurate diagnostic
bp$var.rd

# It is possible to observe that the variable 'perm'
# does not have good representation in 2D (bpca.2d).

# Observed correlations:
cor(rock)

# Projected correlations:
bp$var.rb

# Additional diagnostic
plot(qbpca(rock,
           bp),
     highlight.width=0.2)

# This variable remains as important in a dimension not contemplated
# by the biplot reduction (PC3):

bp$eigenvectors

bp1 <- bpca(rock,
            d=3:4)

summary(bp1)

plot(bp1)

# Since this variable has poor representation in 2D, the recommendation is:
# 1- Avoid discussing it;
# 2- Consider incorporating that information with a 3D biplot (bpca.3d).

bp3 <- bpca(rock,
            d=1:3,
            var.rb=TRUE,
            var.rd=TRUE)

summary(bp3)

plot(bp3)           # Static

plot(bp3,
     rgl.use=TRUE)  # Dynamic

bp3$var.rd          # Nice!

# Additional diagnostic
plot(qbpca(rock,
           bp3),
     highlight.width=0.2)

devAskNewPage(oask)

