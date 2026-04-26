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
      # objects
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
    # Coordenadas escalonadas
    vx <- covar[,d1] * var.factor
    vy <- covar[,d2] * var.factor

    # Desenha os pontos (pontas dos vetores)
    points(x=vx,
           y=vy,
           pch=var.pch,
           col=var.color,
           cex=var.cex, ...)

    # Prepara o var.pos (reciclagem)
    # Se for NULL, usaremos a sua lógica radial original como fallback
    v_pos <- if(!is.null(var.pos)) rep(var.pos, length.out=nrow(covar)) else NULL

    # Desenha os textos
    for (i in 1:nrow(covar)) {
      if (is.null(v_pos)) {
        # 1. SUA LÓGICA ATUAL (Radial automática)
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
        # 2. NOVA LÓGICA (Usuário decidiu a posição 1, 2, 3 ou 4)
        # O parâmetro 'pos' do R ignora o 'adj' e calcula o offset automaticamente
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
      # var segments
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
      # concentric circles (0,0)
      for (i in 1:c.number)
        symbols(x=0,
                y=0,
                circles=c.radio * i * var.factor,
                add=TRUE,
                inches=FALSE,
                fg=c.color,
                lwd=c.lwd, ...)
    }

  if (!inherits(x, 'bpca.2d'))
    stop("Use this function only with 'bpca.2d' class!")

  coobj <- x$coord$objects
  covar <- x$coord$variables
  d1 <- x$number[1]
  d2 <- x$number[2]

  if (is.null(var.factor))
    var.factor <- max(abs(coobj)) / max(abs(covar))

  scores <- rbind(coobj,
                  covar * var.factor)

  if (missing(obj.labels))
    obj.labels <- rownames(coobj)

  # Calculo automatico de xlim e ylim se nao fornecidos
  if (missing(xlim) || missing(ylim)) {
    # Extrai ranges atuais
    rx <- range(scores[, d1], na.rm=TRUE)
    ry <- range(scores[, d2], na.rm=TRUE)

    # Buffer proporcional ao cex e ao tamanho do grafico (ajustavel)
    # 15% de folga costuma acomodar bem os textos laterais
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
         bp={ # basic biplot 2d
           draw.obj()
           draw.var()
           draw.var.seg()

           # identification of objects with mouse
           if(obj.identify)
             identify(x=coobj,
                      labels=obj.labels,
                      cex=obj.cex)
         }, 
         eo={ # evaluate an object
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

           # Eixos de projeção (objeto e sua perpendicular)
           abline(a=0,
                  b=coobj[obj.id,d2] / coobj[obj.id,d1],
                  col=base.color,
                  lty=base.lty, ...)

           abline(a=0,
                  b=-coobj[obj.id,d1] / coobj[obj.id,d2],
                  col=base.color,
                  lty=base.lty, ...)

           # Desenha o vetor do objeto selecionado
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

           # --- CORREÇÃO DA PROJEÇÃO ---
           # 1. Coordenadas das variáveis escalonadas (pontas das setas)
           v_esc <- covar[, c(d1, d2)] * var.factor

           # 2. Coordenadas do objeto (direção do eixo)
           o_dir <- coobj[obj.id[1], c(d1, d2)]

           # 3. Cálculo da projeção ortogonal: P = (V . O / O . O) * O
           # (Usamos a fórmula escalar para projetar cada variável no eixo do objeto)
           dot_vo <- as.numeric(v_esc %*% as.numeric(o_dir))
           dot_oo <- as.numeric(o_dir %*% as.numeric(o_dir))
           proj_scalar <- dot_vo / dot_oo

           x1_proj <- proj_scalar * o_dir[1]
           y1_proj <- proj_scalar * o_dir[2]

           # 4. Desenha as linhas de projeção
           segments(x0=v_esc[,1],
                    y0=v_esc[,2],
                    x1=x1_proj,
                    y1=y1_proj,
                    lty=proj.lty,
                    col=proj.color)
         }, 
         ev={ # evaluate a variable
           draw.obj()

           abline(a=0,
                  b=covar[var.id,d2] / covar[var.id,d1],
                  col=base.color,
                  lty=base.lty, ...)

           abline(a=0,
                  b=-covar[var.id,d1] / covar[var.id,d2],
                  col=base.color,
                  lty=base.lty, ...)

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
         ww={ ## which won where/what (from 1.0-1)
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
         dv={ # discrimitiveness vs. representativeness
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
         ms={ # means vs. stability
           m1 <- mean(covar[,d1] * var.factor)
           m2 <- mean(covar[,d2] * var.factor)        

           abline(a=0,
                  b=m2 / m1,
                  col=base.color,
                  lty=base.lty, ...)

           abline(a=0,
                  b=-m1/m2,
                  col=base.color,
                  lty=base.lty, ...)

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

           for (i in 1:c.number)
             symbols(x=m1,
                     y=m2,
                     circles=c.radio * i * var.factor,
                     add=TRUE,
                     inches=FALSE,
                     fg=c.color,
                     lwd=c.lwd, ...)

           for (i in 1:nrow(coobj))
           {
             x <- solve(matrix(c(-m2, 
                                 m1, 
                                 m1, 
                                 m2),
                               nrow=2),
                        matrix(c(0, 
                                 m2 * coobj[i,d2] +
                                   m1 * coobj[i,d1]),
                               ncol=1))

             segments(x0=coobj[i,d1],
                      y0=coobj[i,d2],
                      x1=x[1],
                      y1=x[2],
                      col=proj.color,
                      lty=proj.lty, ...)
           }                        
         }, 
         ro={ # rank objects with ref. to the ideal variable
           m1 <- mean(covar[,d1])
           m2 <- mean(covar[,d2])

           abline(a=0,
                  b=m2 / m1,
                  col=base.color,
                  lty=base.lty, ...)

           abline(a=0,
                  b=-m1 / m2,
                  col=base.color,
                  lty=base.lty, ...)

           draw.obj()
           draw.var()

           cox <- 0
           coy <- 0

           for (i in 1:nrow(coobj))
           {
             x <- solve(matrix(c(-m2, 
                                 m1, 
                                 m1, 
                                 m2),
                               nrow=2),
                        matrix(c(0, 
                                 m2 * coobj[i,d2] + m1 * coobj[i,d1]),
                               ncol=1))
             if (sign(x[1]) == sign(m1))
               if(abs(x[1]) > abs(cox))
               {
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

           for (i in 1:c.number)
             symbols(x=cox,
                     y=coy,
                     circles=c.radio * i,
                     add=TRUE,
                     inches=FALSE,
                     fg=c.color, 
                     lwd=c.lwd, ...)
         }, 
         rv={ # rank variables with ref. to the ideal object
           draw.obj()
           draw.var()

           m1 <- mean(covar[,d1])
           m2 <- mean(covar[,d2])

           abline(a=0,
                  b=m2 / m1,
                  col=var.color,
                  lty="solid", ...)

           abline(a=0,
                  b=-m1 / m2,
                  col=var.color,
                  lty="solid", ...)

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

           for (i in 1:c.number)
             symbols(x=cox,
                     y=coy,
                     circles=c.radio*i,
                     add=TRUE,
                     inches=FALSE,
                     fg=c.color, 
                     lwd=c.lwd, ...)
         })
}  
