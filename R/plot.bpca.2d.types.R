# plot.bpca.2d.types.R — internal functions for each plot type in plot.bpca.2d.
#
# Extracted from the switch() block of plot.bpca.2d() into named functions,
# making each visualisation type independent, readable and testable.
#
# All receive 'ctx': context list created by plot.bpca.2d() with data
# and visual parameters. None is exported.

# ---- bp: basic 2D biplot ---------------------------------------------------
.plot_type_bp <- function(ctx, ...)
{
  .draw_obj(ctx, ...)
  .draw_var(ctx, ...)
  .draw_var_seg(ctx, ...)

  # Interactive object identification with mouse click (optional).
  if(ctx$obj.identify)
    identify(x=ctx$coobj,
             labels=ctx$obj.labels,
             cex=ctx$obj.cex)
}

# ---- eo: evaluate one object -----------------------------------------------
.plot_type_eo <- function(ctx, ...)
{
  obj.id  <- ctx$obj.id
  obj.lab <- ctx$obj.labels

  # obj.id resolution: accepts a numeric index or object name.
  if(any(class(obj.id) == c('numeric', 'integer'))) {
    obj.lab <- ctx$obj.labels[obj.id[1]]
  } else {
    if(obj.id %in% ctx$obj.labels) {
      obj.lab <- ctx$obj.labels[match(obj.id,
                                      ctx$obj.labels)]
      obj.id  <- match(obj.id,
                       ctx$obj.labels)
    } else {
      stop("'obj.id' do not match with 'obj.labels'!")
    }
  }

  .draw_var(ctx, ...)

  # Projection axis and orthogonal axis through the selected object.
  .draw_axis_cross(vx=ctx$coobj[obj.id, ctx$d1],
                   vy=ctx$coobj[obj.id, ctx$d2],
                   color=ctx$base.color,
                   lty=ctx$base.lty, ...)

  # Selected object vector (arrow from origin to the object).
  arrows(x0=0,
         y0=0,
         x1=ctx$coobj[obj.id[1], ctx$d1] * ctx$obj.factor,
         y1=ctx$coobj[obj.id[1], ctx$d2] * ctx$obj.factor,
         col=ctx$a.color,
         lty=ctx$a.lty,
         lwd=ctx$a.lwd,
         length=ctx$a.length, ...)

  points(x=ctx$coobj[obj.id[1], ctx$d1] * ctx$obj.factor,
         y=ctx$coobj[obj.id[1], ctx$d2] * ctx$obj.factor,
         pch=ctx$obj.pch,
         col=ctx$obj.color,
         cex=ctx$obj.cex, ...)

  text(x=ctx$coobj[obj.id[1], ctx$d1] * ctx$obj.factor,
       y=ctx$coobj[obj.id[1], ctx$d2] * ctx$obj.factor,
       labels=obj.lab,
       pos=ctx$obj.pos,
       offset=ctx$obj.offset,
       col=ctx$obj.color,
       cex=ctx$obj.cex, ...)

  # Orthogonal projection of scaled variables onto the object axis.
  v_esc <- ctx$covar[, c(ctx$d1, ctx$d2)] * ctx$var.factor  # points to project
  o_dir <- ctx$coobj[obj.id[1], c(ctx$d1, ctx$d2)]          # projection direction

  proj <- .proj_on_direction(points=v_esc,
                             direction=o_dir)

  segments(x0=v_esc[, 1],
           y0=v_esc[, 2],
           x1=proj[, 1],
           y1=proj[, 2],
           lty=ctx$proj.lty,
           col=ctx$proj.color)
}

# ---- ev: evaluate one variable ---------------------------------------------
.plot_type_ev <- function(ctx, ...)
{
  var.id <- ctx$var.id

  .draw_obj(ctx, ...)

  .draw_axis_cross(vx=ctx$covar[var.id, ctx$d1],
                   vy=ctx$covar[var.id, ctx$d2],
                   color=ctx$base.color,
                   lty=ctx$base.lty, ...)

  arrows(x0=0,
         y0=0,
         x1=ctx$covar[var.id, ctx$d1] * ctx$var.factor,
         y1=ctx$covar[var.id, ctx$d2] * ctx$var.factor,
         col=ctx$a.color,
         lty=ctx$a.lty,
         lwd=ctx$a.lwd,
         length=ctx$a.length, ...)

  points(x=ctx$covar[var.id, ctx$d1] * ctx$var.factor,
         y=ctx$covar[var.id, ctx$d2] * ctx$var.factor,
         pch=ctx$var.pch,
         col=ctx$var.color,
         cex=ctx$var.cex, ...)

  text(x=ctx$covar[var.id, ctx$d1] * ctx$var.factor,
       y=ctx$covar[var.id, ctx$d2] * ctx$var.factor,
       labels=ifelse(mode(var.id) == 'numeric',
                     rownames(ctx$covar)[var.id],
                     var.id),
       offset=ctx$var.offset,
       col=ctx$var.color,
       cex=ctx$var.cex, ...)

  # Orthogonal projection of objects onto the selected variable axis.
  x.proj <- solve(cbind(c(-ctx$covar[var.id, ctx$d2],
                           ctx$covar[var.id, ctx$d1]),
                        c(ctx$covar[var.id, ctx$d1],
                          ctx$covar[var.id, ctx$d2])),
                  rbind(0,
                        as.numeric(ctx$coobj[, c(ctx$d1, ctx$d2)] %*%
                                   ctx$covar[var.id, c(ctx$d1, ctx$d2)])))

  segments(x0=ctx$coobj[, ctx$d1],
           y0=ctx$coobj[, ctx$d2],
           x1=x.proj[1,],
           y1=x.proj[2,],
           lty=ctx$proj.lty,
           col=ctx$proj.color, ...)
}

# ---- co: compare two objects ------------------------------------------------
.plot_type_co <- function(ctx, ...)
{
  obj.id <- ctx$obj.id

  # Converts object names to numeric indices if needed.
  if(any(class(obj.id) == c('character', 'factor')))
    if(obj.id[1] %in% ctx$obj.labels &
       obj.id[2] %in% ctx$obj.labels) {
      obj.id[1] <- match(obj.id[1],
                         ctx$obj.labels)
      obj.id[2] <- match(obj.id[2],
                         ctx$obj.labels)
    } else {
      stop("At last one 'obj.id' do not match with 'obj.labels'!")
    }

  .draw_obj(ctx, ...)
  .draw_var(ctx, ...)

  # Circle around each compared object.
  symbols(x=ctx$coobj[obj.id[1], ctx$d1],
          y=ctx$coobj[obj.id[1], ctx$d2],
          circles=ctx$c.radio,
          add=TRUE,
          inches=FALSE,
          fg=ctx$c.color,
          lwd=ctx$c.lwd, ...)

  symbols(x=ctx$coobj[obj.id[2], ctx$d1],
          y=ctx$coobj[obj.id[2], ctx$d2],
          circles=ctx$c.radio,
          add=TRUE,
          inches=FALSE,
          fg=ctx$c.color,
          lwd=ctx$c.lwd, ...)

  # Segment connecting the two objects.
  segments(x0=ctx$coobj[obj.id[1], ctx$d1],
           y0=ctx$coobj[obj.id[1], ctx$d2],
           x1=ctx$coobj[obj.id[2], ctx$d1],
           y1=ctx$coobj[obj.id[2], ctx$d2],
           col=ctx$proj.color,
           lty=ctx$proj.lty, ...)

  # Perpendicular bisector of the segment (equidistant axis between the two objects).
  abline(a=0,
         b=-(ctx$coobj[obj.id[1], ctx$d1] -
             ctx$coobj[obj.id[2], ctx$d1]) /
         (ctx$coobj[obj.id[1], ctx$d2] -
          ctx$coobj[obj.id[2], ctx$d2]),
         col=ctx$base.color,
         lty=ctx$base.lty, ...)
}

# ---- cv: compare variables -------------------------------------------------
.plot_type_cv <- function(ctx, ...)
{
  .draw_obj(ctx, ...)
  .draw_var(ctx, ...)
  .draw_var_seg(ctx, ...)
  .draw_circles(ctx, ...)
}

# ---- ww: which won where/what ----------------------------------------------
.plot_type_ww <- function(ctx, ...)
{
  .draw_obj(ctx, ...)
  .draw_var(ctx, ...)

  indice <- c(chull(ctx$coobj[, ctx$d1],
                    ctx$coobj[, ctx$d2]))

  polygon(x=ctx$coobj[indice, ctx$d1],
          y=ctx$coobj[indice, ctx$d2],
          border=ctx$proj.color,
          lty=ctx$proj.lty, ...)

  n_hull <- length(indice)

  # Replaced the fragile while loop (which relied on an NA sentinel) with for
  # with circular indexing. Iterates over all convex-hull edges,
  # including the closing edge (last vertex -> first vertex).
  for(i in seq_len(n_hull)) {
    j <- if(i < n_hull) i + 1L else 1L   # circular index: wraps from last back to first

    m     <- (ctx$coobj[indice[i], ctx$d2] - ctx$coobj[indice[j], ctx$d2]) /
             (ctx$coobj[indice[i], ctx$d1] - ctx$coobj[indice[j], ctx$d1])
    mperp <- -1 / m
    c2    <- ctx$coobj[indice[j], ctx$d2] - m * ctx$coobj[indice[j], ctx$d1]
    xint  <- -c2 / (m - mperp)
    xint  <- ifelse(xint < 0,
                    min(ctx$covar[, ctx$d1], ctx$coobj[, ctx$d1]),
                    max(ctx$covar[, ctx$d1], ctx$coobj[, ctx$d1]))
    yint  <- mperp * xint

    segments(x0=0,
             y0=0,
             x1=xint,
             y1=yint,
             col=ctx$base.color,
             lty=ctx$base.lty, ...)
  }
}

# ---- dv: discriminativeness vs. representativeness -------------------------
.plot_type_dv <- function(ctx, ...)
{
  .draw_obj(ctx, ...)
  .draw_var(ctx, ...)
  .draw_circles(ctx, ...)
  .draw_var_seg(ctx, ...)

  # Arrow in the direction of the variable mean (ideal variable).
  arrows(x0=0,
         y0=0,
         x1=mean(ctx$covar[, ctx$d1] * ctx$var.factor),
         y1=mean(ctx$covar[, ctx$d2] * ctx$var.factor),
         col=ctx$a.color,
         lty=ctx$a.lty,
         lwd=ctx$a.lwd,
         length=ctx$a.length, ...)

  points(mean(ctx$covar[, ctx$d1] * ctx$var.factor),
         mean(ctx$covar[, ctx$d2] * ctx$var.factor),
         pch=1,
         cex=3,
         col='blue', ...)

  abline(a=0,
         b=mean(ctx$covar[, ctx$d2]) / mean(ctx$covar[, ctx$d1]),
         col=ctx$var.color,
         lty=ctx$base.lty, ...)
}

# ---- ms: means vs stability ------------------------------------------------
.plot_type_ms <- function(ctx, ...)
{
  # Mean of scaled variables (central reference point).
  m1 <- mean(ctx$covar[, ctx$d1] * ctx$var.factor)
  m2 <- mean(ctx$covar[, ctx$d2] * ctx$var.factor)

  .draw_axis_cross(vx=m1,
                   vy=m2,
                   color=ctx$base.color,
                   lty=ctx$base.lty, ...)

  arrows(x0=0,
         y0=0,
         x1=m1,
         y1=m2,
         col=ctx$a.color,
         lty=ctx$a.lty,
         lwd=ctx$a.lwd,
         length=ctx$a.length, ...)

  .draw_obj(ctx, ...)
  .draw_var(ctx, ...)

  # Circles centred at the mean, scaled by var.factor.
  .draw_circles_at(cx=m1,
                   cy=m2,
                   ctx=ctx,
                   scale=ctx$var.factor, ...)

  # Orthogonal projection of each object onto the mean variable axis.
  for(i in seq_len(nrow(ctx$coobj))) {
    x.int <- .solve_orthogonal_intersection(px=ctx$coobj[i, ctx$d1],
                                            py=ctx$coobj[i, ctx$d2],
                                            ax=m1,
                                            ay=m2)

    segments(x0=ctx$coobj[i, ctx$d1],
             y0=ctx$coobj[i, ctx$d2],
             x1=x.int[1],
             y1=x.int[2],
             col=ctx$proj.color,
             lty=ctx$proj.lty, ...)
  }
}

# ---- ro: rank objects with reference to ideal variable ---------------------
.plot_type_ro <- function(ctx, ...)
{
  # Unscaled variable mean (reference direction).
  m1 <- mean(ctx$covar[, ctx$d1])
  m2 <- mean(ctx$covar[, ctx$d2])

  .draw_axis_cross(vx=m1,
                   vy=m2,
                   color=ctx$base.color,
                   lty=ctx$base.lty, ...)

  .draw_obj(ctx, ...)
  .draw_var(ctx, ...)

  # Finds the projection foot furthest from the origin, in the correct quadrant.
  cox <- 0
  coy <- 0

  for(i in seq_len(nrow(ctx$coobj))) {
    x.int <- .solve_orthogonal_intersection(px=ctx$coobj[i, ctx$d1],
                                            py=ctx$coobj[i, ctx$d2],
                                            ax=m1,
                                            ay=m2)

    if(sign(x.int[1]) == sign(m1))
      if(abs(x.int[1]) > abs(cox)) {
        cox <- x.int[1]
        coy <- x.int[2]
      }
  }

  arrows(x0=0,
         y0=0,
         x1=cox,
         y1=coy,
         col=ctx$a.color,
         lty=ctx$a.lty,
         lwd=ctx$a.lwd,
         length=ctx$a.length, ...)

  .draw_circles_at(cx=cox,
                   cy=coy,
                   ctx=ctx, ...)
}

# ---- rv: rank variables with reference to ideal object ---------------------
.plot_type_rv <- function(ctx, ...)
{
  .draw_obj(ctx, ...)
  .draw_var(ctx, ...)

  m1 <- mean(ctx$covar[, ctx$d1])
  m2 <- mean(ctx$covar[, ctx$d2])

  .draw_axis_cross(vx=m1,
                   vy=m2,
                   color=ctx$var.color,
                   lty='solid', ...)

  symbols(x=m1,
          y=m2,
          circles=0.1,
          add=TRUE,
          inches=FALSE,
          fg=ctx$c.color,
          lwd=ctx$c.lwd, ...)

  # Ideal variable: point in the direction of the mean with the largest observed modulus.
  mod <- max((ctx$covar[, ctx$d1]^2 + ctx$covar[, ctx$d2]^2)^0.5)
  cox <- sign(m1) * (mod^2 / (1 + m2^2 / m1^2))^0.5
  coy <- (m2 / m1) * cox

  arrows(x0=0,
         y0=0,
         x1=cox,
         y1=coy,
         col=ctx$a.color,
         lty=ctx$a.lty,
         lwd=ctx$a.lwd,
         length=ctx$a.length, ...)

  .draw_circles_at(cx=cox,
                   cy=coy,
                   ctx=ctx, ...)
}
