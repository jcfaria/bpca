##
## Example of `var.rd=TRUE` as a biplot quality measure (2D)
## Mainly recommended for large datasets.
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp_hj <- bpca(gabriel1971,
              method='hj',
              var.rb=TRUE,
              var.rd=TRUE,
              limit=4)

bp_hj$var.rd

# RUR followed by CRISTIAN contains information in dimensions that
# weren't contemplated by the biplot reduction (PC3).
# Among all variables, RUR followed by CRISTIAN is poorly represented in 2D.
# biplot.

# Basic quality plot (default highlight threshold = 10)
plot(qbpca(gabriel1971,
           bp_hj),
     highlight.width=0.25,
     main='Observed vs projected correlations')

# Details
qbp_2d <- qbpca(gabriel1971,
                bp_hj)

# New plot.qbpca features:
# - limit: threshold for poor representation (in % difference)
# - highlight.col / highlight.lty / highlight.pad / highlight.width:
#   style and width of dashed highlight boxes
# - pair.labels + automatic rotated labels for variable pairs
plot(qbp_2d,
     limit=4,
     highlight.col='gray70',
     highlight.lty='dashed',
     highlight.pad=0.04,
     highlight.width=0.25,
     pair.labels=TRUE,
     label.side='bottom',
     label.angle=45,
     label.cex=0.5,
     label.offset=1/30,
     main='Automatic pair labels and poor-projection highlights')

# Alternative view: labels on top
plot(qbp_2d,
     limit=4,
     highlight.col='gray55',
     highlight.width=0.35,
     pair.labels=TRUE,
     label.side='top',
     label.angle=35,
     label.cex=0.45,
     label.offset=0.04)

# Graphical visualization of the importance of the variables not contemplated
# in the prior (2D) reduction: RUR and CRISTIAN are the most important variables in PC3.
plot(bpca(gabriel1971,
          method='hj',
          d=3:4),
     main='hj')

devAskNewPage(oask)

