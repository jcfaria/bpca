# José Cláudio Faria
plot.bpca.3d <- function(x,
                         rgl.use=FALSE,
                         ref.lines=TRUE,
                         ref.color='navy',
                         ref.lty=ifelse(rgl.use, NA, 'dotted'),
                         clear3d=ifelse(rgl.use, TRUE, NULL),
                         simple.axes=ifelse(rgl.use, TRUE, NULL),
                         aspect=ifelse(rgl.use, c(1, 1, 1), NULL),
                         var.factor=NULL,
                         var.color='red3',
                         var.lty=ifelse(rgl.use, NA, 'solid'),
                         var.pch=ifelse(rgl.use, NULL, 20),
                         var.cex=ifelse(rgl.use, .8, .6),
                         var.pos=ifelse(rgl.use, 0, NA),
                         var.offset=ifelse(rgl.use, 0.2, 0.2),
                         obj.color='black',
                         obj.pch=ifelse(rgl.use, NULL, 20),
                         obj.pos=ifelse(rgl.use, 0, 4),
                         obj.cex=ifelse(rgl.use, .8, .6),
                         obj.offset=ifelse(rgl.use, NULL, .2),
                         obj.names=TRUE,
                         obj.labels,
                         obj.identify=FALSE,
                         box=FALSE,
                         angle=ifelse(rgl.use, NULL, 40),
                         xlim, ylim, zlim, xlab, ylab, zlab, ...)
{
  if (!inherits(x, 'bpca.3d'))
    stop("Use this function only with 'bpca.3d' class!")

  d1 <- x$number[1]
  d3 <- x$number[3]
  coobj <- x$coord$objects[,d1:d3]
  covar <- x$coord$variables[,d1:d3]

  if (is.null(var.factor))
    var.factor <- max(abs(coobj)) / max(abs(covar))

  scores <- rbind(coobj,
                  covar * var.factor)

  var.color <- rep_len(var.color,
                       nrow(covar))

  if (missing(obj.labels)) obj.labels <- rownames(coobj)

  if (missing(xlab) || missing(ylab) || missing(zlab)) {
    eigv <- x$eigenvalues
    prop <- 100 * eigv^2 / sum(eigv^2)
    labs <- paste0('PC',
                   d1:d3,
                   ' (',
                   round(prop[d1:d3], 2),
                   '%)')
  }

  # --- Ajuste para Limites Independentes ---
  if (missing(xlim) || missing(ylim) || missing(zlim)) {
    # Calculamos o range individual para cada PC selecionado
    rx <- range(scores[,1],
                na.rm=TRUE)
    ry <- range(scores[,2],
                na.rm=TRUE)
    rz <- range(scores[,3],
                na.rm=TRUE)

    # Aplicamos o buffer de 10% sobre a amplitude de cada eixo
    # Isso garante que a folga seja proporcional ao tamanho do eixo
    mult <- ifelse(rgl.use, 0.10, 0.05)

    buf_x <- diff(rx) * mult
    buf_y <- diff(ry) * mult
    buf_z <- diff(rz) * mult

    # Definimos os limites (incluindo o zero para as ref.lines)
    # Se quisermos as linhas de referência, o limite deve conter o zero
    if (missing(xlim))
      xlim <- c(min(rx[1] - buf_x, 0),
                max(rx[2] + buf_x, 0))

    if (missing(ylim))
      ylim <- c(min(ry[1] - buf_y, 0),
                max(ry[2] + buf_y, 0))

    if (missing(zlim))
      zlim <- c(min(rz[1] - buf_z, 0),
                max(rz[2] + buf_z, 0))
  }


  if (missing(xlab))
    xlab <- labs[1]
  if (missing(ylab))
    ylab <- labs[2]
  if (missing(zlab))
    zlab <- labs[3]

  # --- Modo scatterplot3d ---
  if(!rgl.use) {
    op <- par(no.readonly=TRUE)

    graph <- scatterplot3d::scatterplot3d(x=as.numeric(scores[,1]),
                                          y=as.numeric(scores[,2]),
                                          z=as.numeric(scores[,3]),
                                          xlim=xlim, ylim=ylim, zlim=zlim,
                                          type='n', xlab=xlab, ylab=ylab, zlab=zlab,
                                          grid=FALSE, box=box, angle=angle,
                                          y.margin.add=0.1, # Minimiza a folga do eixo Y
                                          x.ticklabs=NULL, # Força o cálculo justo
                                          ...)

    if(ref.lines) {
      graph$points3d(xlim,
                     c(0, 0),
                     c(0, 0),
                     type='l',
                     lty=ref.lty,
                     col=ref.color)

      graph$points3d(c(0, 0),
                     ylim,
                     c(0, 0),
                     type='l',
                     lty=ref.lty,
                     col=ref.color)

      graph$points3d(c(0, 0),
                     c(0, 0),
                     zlim,
                     type='l',
                     lty=ref.lty,
                     col=ref.color)
    }

    if(obj.names) {
      graph$points3d(coobj,
                     pch=obj.pch,
                     col=obj.color,
                     cex=obj.cex)

      text(graph$xyz.convert(coobj),
           labels=obj.labels,
           pos=obj.pos,
           offset=obj.offset,
           col=obj.color,
           cex=obj.cex)
    } else {
      graph$points3d(coobj,
                     pch=obj.pch,
                     col=obj.color,
                     cex=obj.cex)
    }

    # Preparação do var.pos (fora do loop para eficiência)
    v_pos <- if(!all(is.na(var.pos))) rep(var.pos, length.out=nrow(covar)) else NULL

    for(i in 1:nrow(covar)) {
      v_curr <- covar[i,] * var.factor
      graph$points3d(rbind(c(0, 0, 0),
                     v_curr),
                     col=var.color[i],
                     type='l',
                     lty=var.lty)

      graph$points3d(matrix(v_curr, ncol=3),
                     pch=var.pch,
                     col=var.color[i],
                     cex=var.cex)

      p_v <- graph$xyz.convert(matrix(v_curr,
                                      ncol=3))

      # Define a posição: se v_pos existe, usa ele; caso contrário, usa o ajuste radial
      curr_pos <- if(!is.null(v_pos)) v_pos[i] else ifelse(v_curr[1] >= 0, 4, 2)

      # Ajuste radial (offset x) só é aplicado na lógica automática (quando v_pos é NULL)
      off_x <- if(is.null(v_pos)) sign(v_curr[1]) * (var.offset * 0.05) else 0

      text(p_v$x + off_x,
           p_v$y,
           labels=rownames(covar)[i],
           pos=curr_pos,
           offset=var.offset,
           col=var.color[i],
           cex=var.cex)
    }

    if(obj.identify)
      identify(x=graph$xyz.convert(coobj),
               labels=obj.labels,
               cex=obj.cex)

    par(op)
  }

  # --- Modo RGL ---
  if(rgl.use) {
    size <- max(abs(coobj)) / 20 * obj.cex
    if (clear3d) rgl::clear3d()

    rgl::plot3d(scores,
                xlim=xlim,
                ylim=ylim,
                zlim=zlim,
                xlab='',
                ylab='',
                zlab='',
                type='n',
                axes=FALSE,
                box=box,
                aspect=aspect, ...)

    if (obj.names) {
      rgl::spheres3d(coobj,
                     col=obj.color,
                     radius=size / 2,
                     alpha=.5)

      rgl::text3d(coobj,
                  texts=obj.labels,
                  col=obj.color,
                  adj=obj.pos,
                  cex=obj.cex)
    } else {
      rgl::spheres3d(coobj,
                     col=obj.color,
                     radius=size,
                     alpha=.5)
    }

    # No rgl, multiplicamos o var.offset por um fator (ex: 3.5 ou 4)
    # para que o deslocamento seja visível e equivalente ao gráfico estático.
    ganho <- 4
    off_val <- 0.5 + (var.offset * ganho)
    neg_val <- 0.5 - (var.offset * ganho)

    adj_map <- list('1'=c(0.5, off_val),  # 1: baixo
                    '2'=c(off_val, 0.5),  # 2: esquerda
                    '3'=c(0.5, neg_val),  # 3: cima
                    '4'=c(neg_val, 0.5))  # 4: direita

    v_pos <- if(!all(var.pos == 0)) rep(as.character(var.pos), length.out=nrow(covar)) else NULL

    for(i in 1:nrow(covar)) {
      v_curr <- covar[i,] * var.factor

      rgl::spheres3d(v_curr,
                     col=var.color[i],
                     radius=size / 3,
                     alpha=.5)

      rgl::segments3d(rbind(c(0,0,0),
                      v_curr),
                      col=var.color[i])

      if (is.null(v_pos)) {
        # Lógica automática original (mantida)
        v_off <- if(is.null(var.offset)) (obj.cex * 0.05) else var.offset * 0.1
        rgl::text3d(v_curr + sign(v_curr) * v_off,
                    texts=rownames(covar)[i],
                    col=var.color[i],
                    cex=var.cex)
      } else {
        # Lógica manual: agora com o ganho aplicado ao adj_map
        rgl::text3d(v_curr,
                    texts=rownames(covar)[i],
                    adj=adj_map[[v_pos[i]]],
                    col=var.color[i],
                    cex=var.cex)
      }
    }

    if(simple.axes) {
      rgl::axes3d(c('x', 'y', 'z'))

      rgl::title3d(xlab=xlab,
                   ylab=ylab,
                   zlab=zlab)
    } else {
      rgl::decorate3d(xlab=xlab,
                      ylab=ylab,
                      zlab=zlab,
                      box=box)
    }
    if(ref.lines)
      rgl::abclines3d(0, 0, 0,
                      a=diag(3),
                      lty=ref.lty,
                      col=ref.color)
  }
}