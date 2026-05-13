# José Cláudio Faria
#
# plot.bpca.2d: 2D biplot with ten visualisation types.
#
# Refactoring: drawing helpers were moved to plot.bpca.2d.helpers.R
# and each plot type was extracted to plot.bpca.2d.types.R, reducing
# this function to validation, state preparation and dispatch.
plot.bpca.2d <- function(x,
                         type=c('bp', 'eo', 'ev', 'co', 'cv', 'ww', 'dv', 'ms', 'ro', 'rv'),
                         c.color='darkgray',
                         c.lwd=1,
                         c.number=5,
                         c.radio=1,
                         obj.id=1:2,
                         var.id=1,
                         base.color='red3',
                         base.lty='dotted',
                         proj.color='gray',
                         proj.lty='dotted',
                         a.color='blue',
                         a.lty='solid',
                         a.lwd=2,
                         a.length=.1,
                         ref.lines=TRUE,
                         ref.color='navy',
                         ref.lty='dotted',
                         var.factor=NULL,
                         var.color='red3',
                         var.lty='solid',
                         var.pch=20,
                         var.cex=.6,
                         var.pos=NULL,
                         var.offset=.2,
                         obj.factor=1,
                         obj.color='black',
                         obj.pch=20,
                         obj.pos=4,
                         obj.cex=.6,
                         obj.offset=.2,
                         obj.names=TRUE,
                         obj.labels,
                         obj.identify=FALSE,
                         xlim, ylim, xlab, ylab, ...)
{
  if(!inherits(x, 'bpca.2d'))
    stop("Use this function only with 'bpca.2d' class!")

  if(length(x$number) < 2)
    stop("'x$number' must contain at least two dimensions.")

  coobj <- x$coord$objects
  covar <- x$coord$variables
  d1    <- x$number[1]
  d2    <- x$number[2]

  if(nrow(coobj) == 0 || nrow(covar) == 0)
    stop("Both objects and variables coordinates must have at least one row.")

  # Automatic scaling factor delegated to the shared helper (.compute_var_factor),
  # eliminating duplication with plot.bpca.3d().
  if(is.null(var.factor))
    var.factor <- .compute_var_factor(coobj,
                                      covar)

  scores <- rbind(coobj,
                  covar * var.factor)

  if(missing(obj.labels))
    obj.labels <- rownames(coobj)

  # Automatic axis limits when xlim/ylim are not provided.
  if(missing(xlim) || missing(ylim)) {
    rx <- range(scores[, d1], na.rm=TRUE)
    ry <- range(scores[, d2], na.rm=TRUE)

    # Proportional buffer to accommodate labels.
    buffer_x <- diff(rx) * (max(var.cex, obj.cex) * 0.20)
    buffer_y <- diff(ry) * (max(var.cex, obj.cex) * 0.20)

    if(missing(xlim))
      xlim <- c(rx[1] - buffer_x, rx[2] + buffer_x)

    if(missing(ylim))
      ylim <- c(ry[1] - buffer_y, ry[2] + buffer_y)
  }

  # Axis labels with % variance, delegated to the shared helper
  # (.pc_axis_labels), eliminating duplication with plot.bpca.3d().
  if(missing(xlab) || missing(ylab))
    labs <- .pc_axis_labels(x$eigenvalues,
                            d1:d2)

  if(missing(xlab))
    xlab <- labs[1]
  if(missing(ylab))
    ylab <- labs[2]

  plot(scores,
       xlim=xlim,
       ylim=ylim,
       xlab=xlab,
       ylab=ylab,
       type='n', ...)

  if(ref.lines)
    abline(h=0,
           v=0,
           col=ref.color,
           lty=ref.lty, ...)

  # Context list: bundles data and visual parameters into a single object
  # passed to type functions (.plot_type_*) and drawing helpers (.draw_*).
  # Eliminates explicit passing of dozens of arguments in every call.
  ctx <- list(coobj=coobj,
              covar=covar,
              d1=d1,
              d2=d2,
              var.factor=var.factor,
              obj.id=obj.id,
              obj.labels=obj.labels,
              obj.names=obj.names,
              obj.pch=obj.pch,
              obj.color=obj.color,
              obj.cex=obj.cex,
              obj.pos=obj.pos,
              obj.offset=obj.offset,
              obj.factor=obj.factor,
              obj.identify=obj.identify,
              var.id=var.id,
              var.pch=var.pch,
              var.color=var.color,
              var.cex=var.cex,
              var.pos=var.pos,
              var.offset=var.offset,
              var.lty=var.lty,
              c.number=c.number,
              c.radio=c.radio,
              c.color=c.color,
              c.lwd=c.lwd,
              base.color=base.color,
              base.lty=base.lty,
              proj.color=proj.color,
              proj.lty=proj.lty,
              a.color=a.color,
              a.lty=a.lty,
              a.lwd=a.lwd,
              a.length=a.length)

  # Dispatches to the corresponding type function (defined in plot.bpca.2d.types.R).
  switch(match.arg(type),
         bp=.plot_type_bp(ctx, ...),
         eo=.plot_type_eo(ctx, ...),
         ev=.plot_type_ev(ctx, ...),
         co=.plot_type_co(ctx, ...),
         cv=.plot_type_cv(ctx, ...),
         ww=.plot_type_ww(ctx, ...),
         dv=.plot_type_dv(ctx, ...),
         ms=.plot_type_ms(ctx, ...),
         ro=.plot_type_ro(ctx, ...),
         rv=.plot_type_rv(ctx, ...))
}
