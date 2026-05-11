# José Cláudio Faria
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
  draw.obj <-
    function()
    {
      # Draw object points and labels.
      if(obj.names) {
        points(x=coobj[,d1],
               y=coobj[,d2],
               pch=obj.pch,
               col=obj.color,
               cex=obj.cex, ...)

        text(x=coobj[,d1],
             y=coobj[,d2],
             labels=obj.labels,
             pos=obj.pos,
             offset=obj.offset,
             col=obj.color,
             cex=obj.cex, ...)
      } else {
        points(x=coobj[,d1],
               y=coobj[,d2],
               pch=obj.pch,
               col=obj.color,
               cex=obj.cex, ...)
      }
    }  

  draw.var <-
    function()
  {
    # Scaled variable coordinates.
    vx <- covar[,d1] * var.factor
    vy <- covar[,d2] * var.factor

    # Draw variable endpoints.
    points(x=vx,
           y=vy,
           pch=var.pch,
           col=var.color,
           cex=var.cex, ...)

    # Recycle manual positions when provided.
    v_pos <- if(!is.null(var.pos)) rep(var.pos, length.out=nrow(covar)) else NULL

    # Draw variable labels.
    for (i in seq_len(nrow(covar))) {
      if (is.null(v_pos)) {
        # Automatic radial placement.
        adj.x <- ifelse(vx[i] >= 0, 0, 1)
        off.x <- sign(vx[i]) * (var.offset * 0.2)
        off.y <- sign(vy[i]) * (var.offset * 0.2)

        text(x=vx[i] + off.x,
             y=vy[i] + off.y,
             labels=rownames(covar)[i],
             adj=c(adj.x, 0.5),
             col=var.color,
             cex=var.cex, ...)
      } else {
        # Manual placement (R `pos` handles offset).
        text(x=vx[i],
             y=vy[i],
             labels=rownames(covar)[i],
             pos=v_pos[i],
             offset=var.offset, # O R base usa esse offset com 'pos'
             col=var.color,
             cex=var.cex, ...)
      }
    }
  }

  draw.var.seg <-
    function()
    {   
      # Draw variable vectors.
      segments(x0=0,
               y0=0,
               x1=covar[,d1] * var.factor,
               y1=covar[,d2] * var.factor,
               col=var.color,
               lty=var.lty, ...)
    }

  draw.circles <-
    function()
    {  
      # Draw concentric circles centered at origin.
      for (i in seq_len(c.number))
        symbols(x=0,
                y=0,
                circles=c.radio * i * var.factor,
                add=TRUE,
                inches=FALSE,
                fg=c.color,
                lwd=c.lwd, ...)
    }

  draw.axis.cross <-
    function(vx, vy, color, lty)
    {
      abline(a=0,
             b=vy / vx,
             col=color,
             lty=lty, ...)

      abline(a=0,
             b=-vx / vy,
             col=color,
             lty=lty, ...)
    }

  proj.on.direction <-
    function(points, direction)
    {
      dot_pd <- as.numeric(points %*% as.numeric(direction))
      dot_dd <- as.numeric(direction %*% as.numeric(direction))
      scale <- dot_pd / dot_dd
      cbind(scale * direction[1], scale * direction[2])
    }

  solve.orthogonal.intersection <-
    function(px, py, ax, ay)
    {
      solve(matrix(c(-ay, ax, ax, ay), nrow=2),
            matrix(c(0, ay * py + ax * px), ncol=1))
    }

  draw.circles.at <-
    function(cx, cy, scale=1)
    {
      for (i in seq_len(c.number))
        symbols(x=cx,
                y=cy,
                circles=c.radio * i * scale,
                add=TRUE,
                inches=FALSE,
                fg=c.color,
                lwd=c.lwd, ...)
    }

  if (!inherits(x, 'bpca.2d'))
    stop("Use this function only with 'bpca.2d' class!")

  if (length(x$number) < 2)
    stop("'x$number' must contain at least two dimensions.")

  coobj <- x$coord$objects
  covar <- x$coord$variables
  d1 <- x$number[1]
  d2 <- x$number[2]

  if (nrow(coobj) == 0 || nrow(covar) == 0)
    stop("Both objects and variables coordinates must have at least one row.")

  if (is.null(var.factor)) {
    max_covar <- max(abs(covar), na.rm=TRUE)
    if (!is.finite(max_covar) || max_covar == 0)
      stop("Cannot compute 'var.factor' automatically: variable coordinates are all zero or non-finite.")
    var.factor <- max(abs(coobj), na.rm=TRUE) / max_covar
  }

  scores <- rbind(coobj,
                  covar * var.factor)

  if (missing(obj.labels))
    obj.labels <- rownames(coobj)

  # Automatic limits when xlim/ylim are missing.
  if (missing(xlim) || missing(ylim)) {
    # Current ranges.
    rx <- range(scores[, d1], na.rm=TRUE)
    ry <- range(scores[, d2], na.rm=TRUE)

    # Proportional buffer for better label fit.
    buffer_x <- diff(rx) * (max(var.cex, obj.cex) * 0.20)
    buffer_y <- diff(ry) * (max(var.cex, obj.cex) * 0.20)

    if (missing(xlim))
      xlim <- c(rx[1] - buffer_x, rx[2] + buffer_x)

    if (missing(ylim))
      ylim <- c(ry[1] - buffer_y, ry[2] + buffer_y)
  }

  if (missing(xlab) || missing(ylab)) {
    eigv <- x$eigenvalues
    prop <- 100 * eigv^2 / sum(eigv^2)
    labs <- paste('PC',
                  d1:d2,
                  ' (',
                  round(prop[d1:d2], 2),
                  '%)', 
                  sep='')
  }

  if (missing(xlab))
    xlab <- labs[1]
  if (missing(ylab))
    ylab <- labs[2]

  plot(scores,
       xlim=xlim,
       ylim=ylim,
       xlab=xlab,
       ylab=ylab,
       type='n', ...)

  if (ref.lines)
    abline(h=0,
           v=0,
           col=ref.color,
           lty=ref.lty, ...)

  switch(match.arg(type), 
         bp={ # basic 2d biplot
           draw.obj()
           draw.var()
           draw.var.seg()

           # Identify objects with mouse click.
           if(obj.identify)
             identify(x=coobj,
                      labels=obj.labels,
                      cex=obj.cex)
         }, 
         eo={ # evaluate one object
           if (any(class(obj.id) == c('numeric', 'integer')))
             obj.lab <- obj.labels[obj.id[1]]
           else {
             if (obj.id %in% obj.labels){
               obj.lab <- obj.labels[match(obj.id,
                                           obj.labels)]
               obj.id <- match(obj.id,
                               obj.labels)
             }
             else
               stop("'obj.id' do not match with 'obj.labels'!")
           }

           draw.var()

           # Projection axis and orthogonal axis.
           draw.axis.cross(vx=coobj[obj.id, d1],
                           vy=coobj[obj.id, d2],
                           color=base.color,
                           lty=base.lty)

           # Draw selected object vector.
           arrows(x0=0,
                  y0=0,
                  x1=coobj[obj.id[1],d1] * obj.factor,
                  y1=coobj[obj.id[1],d2] * obj.factor,
                  col=a.color,
                  lty=a.lty,
                  lwd=a.lwd,
                  length=a.length, ...)

           points(x=coobj[obj.id[1],d1] * obj.factor,
                  y=coobj[obj.id[1],d2] * obj.factor,
                  pch=obj.pch,
                  col=obj.color,
                  cex=obj.cex, ...)

           text(x=coobj[obj.id[1],d1] * obj.factor,
                y=coobj[obj.id[1],d2] * obj.factor,
                labels=obj.lab,
                pos=obj.pos,
                offset=obj.offset,
                col=obj.color,
                cex=obj.cex, ...)

           # Orthogonal projection of scaled variables.
           # 1) Scaled variable endpoints.
           v_esc <- covar[, c(d1, d2)] * var.factor

           # 2) Object coordinates (axis direction).
           o_dir <- coobj[obj.id[1], c(d1, d2)]

           # 3) Orthogonal projection: P = (V . O / O . O) * O.
           proj <- proj.on.direction(points=v_esc,
                                     direction=o_dir)

           # 4) Draw projection segments.
           segments(x0=v_esc[,1],
                    y0=v_esc[,2],
                    x1=proj[,1],
                    y1=proj[,2],
                    lty=proj.lty,
                    col=proj.color)
         }, 
         ev={ # evaluate one variable
           draw.obj()

           draw.axis.cross(vx=covar[var.id, d1],
                           vy=covar[var.id, d2],
                           color=base.color,
                           lty=base.lty)

           arrows(x0=0,
                  y0=0,
                  x1=covar[var.id,d1] * var.factor,
                  y1=covar[var.id,d2] * var.factor,
                  col=a.color,
                  lty=a.lty,
                  lwd=a.lwd,
                  length=a.length, ...)

           points(x=covar[var.id,d1] * var.factor, 
                  y=covar[var.id,d2] * var.factor, 
                  pch=var.pch,
                  col=var.color,
                  cex=var.cex, ...)

           text(x=covar[var.id,d1] * var.factor,
                y=covar[var.id,d2] * var.factor,
                labels=ifelse(mode(var.id) == 'numeric', rownames(covar)[var.id], var.id), 
                offset=var.offset,
                col=var.color,
                cex=var.cex, ...)

           x <- solve(cbind(c(-covar[var.id,d2],
                              covar[var.id,d1]),
                            c(covar[var.id,d1],
                              covar[var.id,d2])),
                      rbind(0,
                            as.numeric(coobj[,c(d1, d2)] %*%
                                       covar[var.id,c(d1, d2)])))

           segments(x0=coobj[,d1],
                    y0=coobj[,d2],
                    x1=x[1,],
                    y1=x[2,],
                    lty=proj.lty,
                    col=proj.color, ...)
         }, 
         co={ # compare two objects
           if (any(class(obj.id) == c('character', 'factor'))) 
             if (obj.id[1] %in% obj.labels &
                 obj.id[2] %in% obj.labels) {
               obj.id[1] <- match(obj.id[1], obj.labels)
               obj.id[2] <- match(obj.id[2], obj.labels)
             } else 
               stop("At last one 'obj.id' do not match with 'obj.labels'!")

         draw.obj()
         draw.var()

         symbols(x=coobj[obj.id[1],d1],
                 y=coobj[obj.id[1],d2],
                 circles=c.radio,
                 add=TRUE,
                 inches=FALSE,
                 fg=c.color, 
                 lwd=c.lwd, ...)

         symbols(x=coobj[obj.id[2],d1],
                 y=coobj[obj.id[2],d2],
                 circles=c.radio,
                 add=TRUE,
                 inches=FALSE,
                 fg=c.color, 
                 lwd=c.lwd, ...)

         segments(x0=coobj[obj.id[1],d1],
                  y0=coobj[obj.id[1],d2],
                  x1=coobj[obj.id[2],d1],
                  y1=coobj[obj.id[2],d2],
                  col=proj.color,
                  lty=proj.lty, ...)

         abline(a=0,
                b=-(coobj[obj.id[1],d1] - 
                    coobj[obj.id[2],d1]) / 
                (coobj[obj.id[1],d2] - 
                 coobj[obj.id[2],d2]),
                col=base.color,
                lty=base.lty, ...)
         }, 
         cv={ # compare two variables
           draw.obj()
           draw.var()
           draw.var.seg()
           draw.circles()
         }, 
         ww={ # which won where/what
           draw.obj()
           draw.var()

           indice <- c(chull(coobj[,d1],
                             coobj[,d2]))

           polygon(x=coobj[indice,d1],
                   y=coobj[indice,d2],
                   border=proj.color,
                   lty=proj.lty, ...)

           i <- 1
           while (is.na(indice[i + 1]) == FALSE) {
             m <- (coobj[indice[i],d2] -
                   coobj[indice[i + 1],d2]) / 
             (coobj[indice[i],d1] - 
              coobj[indice[i + 1],d1])

             mperp <- -1 / m

             c2 <- coobj[indice[i + 1],d2] -
               m * coobj[indice[i + 1],d1]

             xint <- -c2/(m - mperp)

             xint <- ifelse(xint < 0,
                            min(covar[,d1], 
                                coobj[,d1]),
                            max(covar[,d1], 
                                coobj[,d1]))

             yint <- mperp * xint

             segments(x0=0,
                      y0=0,
                      x1=xint,
                      y1=yint,
                      col=base.color,
                      lty=base.lty, ...)

             i <- i + 1
           }

           m <- (coobj[indice[i],d2] -
                 coobj[indice[1],d2]) /
           (coobj[indice[i],d1] -
            coobj[indice[1],d1])

           mperp <- -1 / m

           c2 <- coobj[indice[i],d2] - 
             m * coobj[indice[i],d1]

           xint <- -c2 / (m - mperp)

           xint <- ifelse(xint < 0,
                          min(covar[,d1], 
                              coobj[,d1]),
                          max(covar[,d1], 
                              coobj[,d1]))

           yint <- mperp * xint

           segments(x0=0,
                    y0=0,
                    x1=xint,
                    y1=yint,
                    col=base.color,
                    lty=base.lty, ...)
         }, 
         dv={ # discriminativeness vs. representativeness
           draw.obj()
           draw.var()
           draw.circles()
           draw.var.seg()

           arrows(x0=0,
                  y0=0,
                  x1=mean(covar[, d1] * var.factor),
                  y1=mean(covar[, d2] * var.factor), # 
                  col=a.color,
                  lty=a.lty,
                  lwd=a.lwd,
                  length=a.length, ...)

           points(mean(covar[, d1] * var.factor),
                  mean(covar[, d2] * var.factor),
                  pch=1,
                  cex=3,
                  col='blue', ...)

           abline(a=0,
                  b=mean(covar[,d2]) / mean(covar[,d1]),
                  col=var.color,
                  lty=base.lty, ...)                                                 
         }, 
         ms={ # means vs stability
           m1 <- mean(covar[,d1] * var.factor)
           m2 <- mean(covar[,d2] * var.factor)        

           draw.axis.cross(vx=m1,
                           vy=m2,
                           color=base.color,
                           lty=base.lty)

           arrows(x0=0,
                  y0=0,
                  x1=m1,
                  y1=m2,
                  col=a.color,
                  lty=a.lty,
                  lwd=a.lwd,
                  length=a.length, ...)

           draw.obj()
           draw.var()

           draw.circles.at(cx=m1,
                           cy=m2,
                           scale=var.factor)

           for (i in seq_len(nrow(coobj))) {
             x <- solve.orthogonal.intersection(px=coobj[i, d1],
                                                py=coobj[i, d2],
                                                ax=m1,
                                                ay=m2)

             segments(x0=coobj[i,d1],
                      y0=coobj[i,d2],
                      x1=x[1],
                      y1=x[2],
                      col=proj.color,
                      lty=proj.lty, ...)
           }
         }, 
         ro={ # rank objects with reference to ideal variable
           m1 <- mean(covar[,d1])
           m2 <- mean(covar[,d2])

           draw.axis.cross(vx=m1,
                           vy=m2,
                           color=base.color,
                           lty=base.lty)

           draw.obj()
           draw.var()

           cox <- 0
           coy <- 0

           for (i in seq_len(nrow(coobj))) {
             x <- solve.orthogonal.intersection(px=coobj[i, d1],
                                                py=coobj[i, d2],
                                                ax=m1,
                                                ay=m2)
             if (sign(x[1]) == sign(m1))
               if(abs(x[1]) > abs(cox)) {
                 cox <- x[1]
                 coy <- x[2]
               }
           }

           arrows(x0=0,
                  y0=0,
                  x1=cox,
                  y1=coy,
                  col=a.color,
                  lty=a.lty,
                  lwd=a.lwd,
                  length=a.length, ...)

           draw.circles.at(cx=cox,
                           cy=coy)
         }, 
         rv={ # rank variables with reference to ideal object
           draw.obj()
           draw.var()

           m1 <- mean(covar[,d1])
           m2 <- mean(covar[,d2])

           draw.axis.cross(vx=m1,
                           vy=m2,
                           color=var.color,
                           lty='solid')

           symbols(x=m1,
                   y=m2,
                   circles=0.1,
                   add=TRUE,
                   inches=FALSE,
                   fg=c.color, 
                   lwd=c.lwd, ...)

           mod <- max((covar[,d1]^2 + covar[,d2]^2)^0.5)
           cox <- sign(m1) * (mod^2 / (1 + m2^2 / m1^2))^0.5
           coy <- (m2 / m1) * cox

           arrows(x0=0,
                  y0=0,
                  x1=cox,
                  y1=coy,
                  col=a.color,
                  lty=a.lty,
                  lwd=a.lwd,
                  length=a.length, ...)

           draw.circles.at(cx=cox,
                           cy=coy)
         })
}  
