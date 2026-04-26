##
## Example of 'var.rd=TRUE' parameter as a measure of the quality of the biplot - 2d
## Mainly recommended to large datasets.
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

bp_hj <- bpca(gabriel1971,
              meth='hj',
              var.rb=TRUE,
              var.rd=TRUE,
              limit=4)

bp_hj$var.rd

# RUR followed by CRISTIAN contains information in dimensions that
# weren't contemplated by the biplot reduction (PC3).
# Between all, RUR followed by CRISTIAN, variables are bad represented by a 2d
# biplot.

plot(qbpca(gabriel1971,
           bp_hj))

# Detais
qbp_2d <- qbpca(gabriel1971,
                bp_hj)

plot(qbp_2d,
     xaxt="n",
     xlab='')

# Prepare the data and names.
comb <- combn(colnames(gabriel1971),
              2)

axis_x_labels <- apply(comb,
                       2, function(x) paste(x,
                                            collapse=' vs. ' ))

# Add only the bullet points (the dashes) without the text.
axis(side=1,
     at=1:ncol(comb),
     labels=FALSE)

# Add the text rotated 45 degrees.
text(x=1:ncol(comb),
     y=par("usr")[3] - 0.05,       # Position just below the X-axis.
     labels=axis_x_labels,
     srt=45,                       # 45-degree angle
     adj=1,                        # Right alignment (by the edge of the text)
     xpd=TRUE,                     # Allows you to write outside the chart area.
     cex=0.4)                      # Font size

# Graphical visualization of the importance of the variables not contemplated
# in the prior (2d) reduction: RUR and CRISTIAN are the most important variables in PC3.
plot(bpca(gabriel1971,
          meth='hj',
          d=3:4),
     main='hj')

devAskNewPage(oask)

