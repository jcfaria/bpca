##
## Main bpca demo script
## Covers 2D/3D workflows, diagnostics, and plotting modes.
##

oask <- devAskNewPage(dev.interactive(orNone=TRUE))

inspect_bpca <- function(bp) {
  class(bp)
  names(bp)
  summary(bp)
  bp$number
  round(bp$importance, 3)
  bp$coord$objects[seq_len(min(3, nrow(bp$coord$objects))), , drop=FALSE]
  bp$coord$variables[seq_len(min(3, nrow(bp$coord$variables))), , drop=FALSE]
}

## ------------------------------------------------------------------
## 1) Basic 2D workflow
## ------------------------------------------------------------------
bp2 <- bpca(gabriel1971)
plot(bp2, main="gabriel1971 - 2D")
inspect_bpca(bp2)

## Customize aesthetics in 2D
plot(bpca(gabriel1971, method='sqrt'),
     main='gabriel1971 - sqrt',
     sub='Customized aesthetics',
     var.cex=.6,
     var.color=rainbow(ncol(gabriel1971)),
     var.pch='v',
     obj.pch='o',
     obj.cex=.5,
     obj.col=rainbow(nrow(gabriel1971)),
     obj.pos=1,
     obj.offset=.5)

## ------------------------------------------------------------------
## 2) Basic 3D workflow (static)
## ------------------------------------------------------------------
bp3 <- bpca(gabriel1971, d=1:3)
plot(bp3, main="gabriel1971 - 3D static")
inspect_bpca(bp3)

## Customize aesthetics in 3D static
plot(bpca(gabriel1971, d=1:3, method='jk'),
     main='gabriel1971 - jk',
     sub='Customized aesthetics',
     var.pch='+',
     var.cex=.6,
     var.color=rainbow(ncol(gabriel1971)),
     obj.pch='*',
     obj.cex=.8,
     obj.col=rainbow(nrow(gabriel1971)),
     ref.lty='solid',
     ref.col='red',
     angle=70)

## Alternative 3D projection range
bp3_alt <- bpca(gabriel1971, d=2:4)
plot(bp3_alt, main="gabriel1971 - 3D (PC2 to PC4)")
inspect_bpca(bp3_alt)

## ------------------------------------------------------------------
## 3) Interactive identification
## ------------------------------------------------------------------
if (dev.interactive()) {
  plot(bp2, obj.names=FALSE, obj.identify=TRUE,
       main="2D object identification")
  plot(bp2,
       obj.names=FALSE,
       obj.labels=c('toi', 'kit', 'bat', 'ele', 'wat', 'rad', 'tv', 'ref'),
       obj.identify=TRUE,
       main="2D object identification (custom labels)")

  plot(bp3, obj.names=FALSE, obj.identify=TRUE,
       main="3D object identification")
  plot(bp3,
       obj.names=FALSE,
       obj.labels=c('toi', 'kit', 'bat', 'ele', 'wat', 'rad', 'tv', 'ref'),
       obj.identify=TRUE,
       main="3D object identification (custom labels)")
}

## ------------------------------------------------------------------
## 4) Data tools helper
## ------------------------------------------------------------------
dt <- dt.tools(iris, center=2)
class(dt)
names(dt)
str(dt)
dt$length
dt$angle
dt$r

iris.tools <- round(dt$r, 5)
iris.obsv <- round(cor(iris[-5]), 5)
all(iris.tools == iris.obsv)

## ------------------------------------------------------------------
## 5) Grouping example (iris)
## ------------------------------------------------------------------
plot(bpca(iris[-5]),
     var.cex=.7,
     obj.names=FALSE,
     obj.cex=1.5,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.pch=c('+', '*', '-')[as.numeric(iris$Species)],
     main="iris - 2D grouping")

plot(bpca(iris[-5], d=1:3),
     var.color=c('blue', 'red'),
     var.cex=1,
     obj.names=FALSE,
     obj.cex=1,
     obj.col=c('red', 'green3', 'blue')[as.numeric(iris$Species)],
     obj.pch=c('+', '*', '-')[as.numeric(iris$Species)],
     main="iris - 3D grouping")

## ------------------------------------------------------------------
## 6) Quality diagnostics with var.rb and qbpca
## ------------------------------------------------------------------
for (m in c('sqrt', 'jk', 'gh', 'hj')) {
  bp_m <- bpca(gabriel1971, method=m, var.rb=TRUE)
  q_m <- qbpca(gabriel1971, bp_m)
  plot(q_m,
       highlight.width=0.25,
       main=paste0(m, " - 2D"))
}

for (m in c('sqrt', 'jk', 'gh', 'hj')) {
  bp_m3 <- bpca(gabriel1971, method=m, d=1:3, var.rb=TRUE)
  q_m3 <- qbpca(gabriel1971, bp_m3)
  plot(q_m3,
       highlight.width=0.25,
       main=paste0(m, " - 3D"))
}

## var.rd highlights poor projected correlations
bp_rd <- bpca(gabriel1971, method='hj', var.rb=TRUE, var.rd=TRUE, limit=3)
bp_rd$var.rd
plot(bpca(gabriel1971, method='hj', d=3:4), main='HJ (PC3-PC4)')

## ------------------------------------------------------------------
## 7) Plot modes with ontario data
## ------------------------------------------------------------------
data(ontario)
obj.lab <- paste('g', 1:18, sep='')

plot(bpca(ontario), main='Ontario - basic')
plot(bpca(ontario), obj.labels=obj.lab, main='Ontario - custom labels')

plot(bpca(ontario), type='eo', obj.cex=1, main="type='eo' (default object)")
plot(bpca(ontario), type='eo', obj.id=7, obj.cex=1, main="type='eo' (object 7)")
plot(bpca(ontario), type='eo', obj.labels=obj.lab, obj.id='g7', obj.cex=1,
     main="type='eo' (object g7)")

plot(bpca(ontario), type='ev', var.cex=1, main="type='ev' (default variable)")
plot(bpca(ontario), type='ev', var.id='E7', obj.labels=obj.lab, var.cex=1,
     main="type='ev' (variable E7)")

cl <- 1:3
plot(bpca(iris[-5]), type='ev', var.id=1, obj.names=FALSE,
     obj.col=cl[as.numeric(iris$Species)], main="type='ev' with groups")
legend('topleft', legend=levels(iris$Species), text.col=cl, pch=19, col=cl,
       cex=.9, box.lty=0)

plot(bpca(ontario), type='co', main="type='co' (default objects)")
plot(bpca(ontario), type='co', obj.labels=obj.lab, main="type='co' with labels")
plot(bpca(ontario), type='co', obj.labels=obj.lab, obj.id=13:14,
     main="type='co' (objects 13 and 14)")
plot(bpca(ontario), type='co', obj.labels=obj.lab, obj.id=c('g7', 'g13'),
     main="type='co' (objects g7 and g13)")

plot(bpca(ontario), type='cv', main="type='cv'")
plot(bpca(ontario), type='ww', main="type='ww'")
plot(bpca(ontario), type='dv', main="type='dv'")
plot(bpca(ontario), type='ms', main="type='ms'")
plot(bpca(ontario), type='ro', main="type='ro'")
plot(bpca(ontario), type='rv', main="type='rv'")

## Out-of-range examples for defensive behavior
plot(bpca(iris[-5]), type='eo', obj.id=42, obj.cex=1)
plot(bpca(iris[-5]), type='ev', var.id='Sepal.Width')
plot(bpca(iris[-5]), type='ev', var.id='Sepal.Width', var.factor=.3)

devAskNewPage(oask)
