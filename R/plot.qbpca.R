# José Cláudio Faria
plot.qbpca <- function(x,
                       limit=10,
                       highlight.col='gray75',
                       highlight.lty='dashed',
                       highlight.pad=0.05,
                       highlight.width=0.25,
                       highlight.guides=TRUE,
                       pair.labels=TRUE,
                       label.max.nchar=NULL,
                       label.side='bottom',
                       label.angle=45,
                       label.cex=0.6,
                       label.offset=0.02,
                       xlab='',
                       ylab='r',
                       pch=c(1,8),
                       col=c(4,2), ...)
{
  if (!inherits(x, 'qbpca'))
    stop("Use this function only with 'qbpca' class!")

  if (!is.numeric(limit) || length(limit) != 1 || !is.finite(limit) || limit < 0)
    stop("'limit' must be a non-negative numeric value.")

  if (!is.character(highlight.col) || length(highlight.col) != 1)
    stop("'highlight.col' must be a single color value.")

  if (!is.character(highlight.lty) || length(highlight.lty) != 1)
    stop("'highlight.lty' must be a single line type value.")

  if (!is.numeric(highlight.pad) || length(highlight.pad) != 1 || !is.finite(highlight.pad) || highlight.pad < 0)
    stop("'highlight.pad' must be a non-negative numeric value.")

  if (!is.numeric(highlight.width) || length(highlight.width) != 1 ||
      !is.finite(highlight.width) || highlight.width <= 0 || highlight.width > 0.5)
    stop("'highlight.width' must be a numeric value in (0, 0.5].")

  if (!is.logical(highlight.guides) || length(highlight.guides) != 1)
    stop("'highlight.guides' must be TRUE or FALSE.")

  if (!is.logical(pair.labels) || length(pair.labels) != 1)
    stop("'pair.labels' must be TRUE or FALSE.")

  if (!is.null(label.max.nchar)) {
    if (!is.numeric(label.max.nchar) || length(label.max.nchar) != 1 ||
        !is.finite(label.max.nchar) || label.max.nchar < 4)
      stop("'label.max.nchar' must be NULL or a numeric value >= 4.")
  }

  if (!is.character(label.side) || length(label.side) != 1 ||
      !(label.side %in% c('bottom', 'top')))
    stop("'label.side' must be either 'bottom' or 'top'.")

  if (!is.numeric(label.angle) || length(label.angle) != 1 || !is.finite(label.angle))
    stop("'label.angle' must be a finite numeric value.")

  if (!is.numeric(label.cex) || length(label.cex) != 1 || !is.finite(label.cex) || label.cex <= 0)
    stop("'label.cex' must be a positive numeric value.")

  if (!is.numeric(label.offset) || length(label.offset) != 1 || !is.finite(label.offset) || label.offset < 0)
    stop("'label.offset' must be a non-negative numeric value.")

  n <- nrow(x)
  idx <- seq_len(n)
  dif <- 100 * abs(x$obs - x$var.rb)
  bad <- dif > limit
  use.labels <- isTRUE(pair.labels) && !is.null(rownames(x))
  label.txt <- if (use.labels) rownames(x) else NULL
  if (use.labels && !is.null(label.max.nchar)) {
    label.txt <- ifelse(
      nchar(label.txt) > label.max.nchar,
      paste0(substr(label.txt, 1, label.max.nchar - 3), "..."),
      label.txt
    )
  }
  if (use.labels) {
    old.mar <- par("mar")
    on.exit(par(mar=old.mar), add=TRUE)

    lbl.w <- max(strwidth(label.txt, units='inches', cex=label.cex), na.rm=TRUE)
    lbl.h <- max(strheight(label.txt, units='inches', cex=label.cex), na.rm=TRUE)
    theta <- abs(label.angle) * pi / 180
    lbl.v <- lbl.w * abs(sin(theta)) + lbl.h * abs(cos(theta))

    # label.offset is proportional to the y-span (-1, 1), converted to inches
    # using current plot height.
    off.v <- label.offset * par("pin")[2]
    req.lines <- (lbl.v + off.v) / par("csi") + 1

    mar <- old.mar
    if (label.side == 'top')
      mar[3] <- max(mar[3], req.lines)
    else
      mar[1] <- max(mar[1], req.lines)
    par(mar=mar)
  }
  dots <- list(...)
  if (is.null(dots$xlim))
    dots$xlim <- c(0.5, n + 0.5)
  if (use.labels && is.null(dots$xaxt))
    dots$xaxt <- 'n'
  dots$x <- idx
  dots$y <- x$obs
  dots$ylim <- c(-1,1)
  dots$type <- 'n'
  dots$xlab <- xlab
  dots$ylab <- ylab

  do.call(plot, dots)

  if (use.labels) {
    axis.side <- if (label.side == 'top') 3 else 1
    axis(side=axis.side, at=idx, labels=FALSE)
    usr <- par("usr")
    y.span <- diff(usr[3:4])
    y.lbl <- if (label.side == 'top') {
      usr[4] + label.offset * y.span
    } else {
      usr[3] - label.offset * y.span
    }
    adj.x <- if (label.side == 'top') 0 else 1
    text(x=idx,
         y=y.lbl,
         labels=label.txt,
         srt=label.angle,
         adj=adj.x,
         xpd=TRUE,
         cex=label.cex)
  }

  if (any(bad)) {
    usr <- par("usr")
    y.axis <- if (label.side == 'top') usr[4] else usr[3]
    y.low <- pmin(x$obs[bad], x$var.rb[bad]) - highlight.pad
    y.high <- pmax(x$obs[bad], x$var.rb[bad]) + highlight.pad
    rect(xleft=idx[bad] - highlight.width,
         ybottom=y.low,
         xright=idx[bad] + highlight.width,
         ytop=y.high,
         col=NA,
         border=highlight.col,
         lty=highlight.lty)

    if (isTRUE(highlight.guides)) {
      y.start <- if (label.side == 'top') y.high else y.low
      segments(x0=idx[bad],
               y0=y.start,
               x1=idx[bad],
               y1=y.axis,
               col=highlight.col,
               lty=highlight.lty)
    }
  }

  points(idx,
         x$obs,
         pch=pch[1],
         col=col[1])

  points(idx,
         x$var.rb,
         col=col[2],
         pch=pch[2])

  leg.labels <- c('r.obs', 'r.rb')
  leg.pch <- pch
  leg.col <- col
  leg.lty <- c('blank', 'blank')

  if (any(bad)) {
    leg.tag <- if (isTRUE(highlight.guides)) {
      paste0('|dr| > ', limit, ' (guides)')
    } else {
      paste0('|dr| > ', limit)
    }
    leg.labels <- c(leg.labels, leg.tag)
    leg.pch <- c(leg.pch, NA)
    leg.col <- c(leg.col, highlight.col)
    leg.lty <- c(leg.lty, highlight.lty)
  }

  legend('bottomleft',
         legend=leg.labels,
         pch=leg.pch,
         col=leg.col,
         lty=leg.lty,
         title='legend')
}
