# plot.bpca.2d.helpers.R — drawing helper functions for plot.bpca.2d.
#
# Extracted from inside plot.bpca.2d() (where they were closures recreated on
# every call) into package-level internal functions, reusable and testable.
#
# All receive 'ctx': a context list created in plot.bpca.2d() containing
# data and visual parameters, avoiding excessively long argument lists.
# None is exported.

# ---------------------------------------------------------------------------
# .draw_obj: plots object points and labels.
# ---------------------------------------------------------------------------
.draw_obj <- function(ctx, ...)
{
  if(ctx$obj.names) {
    points(x=ctx$coobj[, ctx$d1],
           y=ctx$coobj[, ctx$d2],
           pch=ctx$obj.pch,
           col=ctx$obj.color,
           cex=ctx$obj.cex, ...)

    text(x=ctx$coobj[, ctx$d1],
         y=ctx$coobj[, ctx$d2],
         labels=ctx$obj.labels,
         pos=ctx$obj.pos,
         offset=ctx$obj.offset,
         col=ctx$obj.color,
         cex=ctx$obj.cex, ...)
  } else {
    # No labels: plots points only.
    points(x=ctx$coobj[, ctx$d1],
           y=ctx$coobj[, ctx$d2],
           pch=ctx$obj.pch,
           col=ctx$obj.color,
           cex=ctx$obj.cex, ...)
  }
}

# ---------------------------------------------------------------------------
# .draw_var: plots points and labels for variables scaled by var.factor.
# ---------------------------------------------------------------------------
.draw_var <- function(ctx, ...)
{
  # Scaled variable coordinates.
  vx <- ctx$covar[, ctx$d1] * ctx$var.factor
  vy <- ctx$covar[, ctx$d2] * ctx$var.factor

  points(x=vx,
         y=vy,
         pch=ctx$var.pch,
         col=ctx$var.color,
         cex=ctx$var.cex, ...)

  # Label positioning: manual (var.pos provided) or automatic (radial).
  v_pos <- if(!is.null(ctx$var.pos))
    rep(ctx$var.pos, length.out=nrow(ctx$covar))
  else
    NULL

  for(i in seq_len(nrow(ctx$covar))) {
    if(is.null(v_pos)) {
      # Automatic placement: shifts in the radial direction of the vector.
      adj.x <- ifelse(vx[i] >= 0, 0, 1)
      off.x <- sign(vx[i]) * (ctx$var.offset * 0.2)
      off.y <- sign(vy[i]) * (ctx$var.offset * 0.2)

      text(x=vx[i] + off.x,
           y=vy[i] + off.y,
           labels=rownames(ctx$covar)[i],
           adj=c(adj.x, 0.5),
           col=ctx$var.color,
           cex=ctx$var.cex, ...)
    } else {
      # Manual placement via R base pos parameter.
      text(x=vx[i],
           y=vy[i],
           labels=rownames(ctx$covar)[i],
           pos=v_pos[i],
           offset=ctx$var.offset,
           col=ctx$var.color,
           cex=ctx$var.cex, ...)
    }
  }
}

# ---------------------------------------------------------------------------
# .draw_var_seg: plots segments (vectors) from the origin to each variable.
# ---------------------------------------------------------------------------
.draw_var_seg <- function(ctx, ...)
{
  segments(x0=0,
           y0=0,
           x1=ctx$covar[, ctx$d1] * ctx$var.factor,
           y1=ctx$covar[, ctx$d2] * ctx$var.factor,
           col=ctx$var.color,
           lty=ctx$var.lty, ...)
}

# ---------------------------------------------------------------------------
# .draw_circles: plots concentric circles centred at the origin.
# ---------------------------------------------------------------------------
.draw_circles <- function(ctx, ...)
{
  for(i in seq_len(ctx$c.number))
    symbols(x=0,
            y=0,
            circles=ctx$c.radio * i * ctx$var.factor,
            add=TRUE,
            inches=FALSE,
            fg=ctx$c.color,
            lwd=ctx$c.lwd, ...)
}

# ---------------------------------------------------------------------------
# .draw_axis_cross: plots two perpendicular axes through the origin
# in the direction (vx, vy) and in the orthogonal direction.
#
# Explicit arguments (no ctx) because direction vectors vary by
# plot type.
# ---------------------------------------------------------------------------
.draw_axis_cross <- function(vx,
                             vy,
                             color,
                             lty, ...)
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

# ---------------------------------------------------------------------------
# .proj_on_direction: orthogonal projection of points onto a direction.
#
# Returns the foot-of-perpendicular coordinates (one row per point).
# Explicit arguments (no ctx): pure mathematical operation, no visual state.
# ---------------------------------------------------------------------------
.proj_on_direction <- function(points,
                               direction)
{
  dot_pd <- as.numeric(points %*% as.numeric(direction))
  dot_dd <- as.numeric(direction %*% as.numeric(direction))
  scale  <- dot_pd / dot_dd
  cbind(scale * direction[1],
        scale * direction[2])
}

# ---------------------------------------------------------------------------
# .solve_orthogonal_intersection: finds the foot of the perpendicular from a point
# (px, py) onto the line through the origin with direction (ax, ay).
# ---------------------------------------------------------------------------
.solve_orthogonal_intersection <- function(px,
                                           py,
                                           ax,
                                           ay)
{
  solve(matrix(c(-ay, ax, ax, ay), nrow=2),
        matrix(c(0, ay * py + ax * px), ncol=1))
}

# ---------------------------------------------------------------------------
# .draw_circles_at: plots concentric circles centred at (cx, cy).
#
# The scale parameter adjusts the radius; default 1. Type ms passes var.factor
# so that circles match the variable scale.
# ---------------------------------------------------------------------------
.draw_circles_at <- function(cx,
                             cy,
                             ctx,
                             scale=1, ...)
{
  for(i in seq_len(ctx$c.number))
    symbols(x=cx,
            y=cy,
            circles=ctx$c.radio * i * scale,
            add=TRUE,
            inches=FALSE,
            fg=ctx$c.color,
            lwd=ctx$c.lwd, ...)
}
