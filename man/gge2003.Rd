\name{gge2003}
\alias{gge2003}

\title{
  A didatic matrix of genotypes (rows) and environments (colums)
}

\description{
  A didatic matrix of genotypes (rows) and environments (colums) proposed by
  Weikai Yan and Manjit S. Kang in GGE biplot analysis: a graphical tool for
  breeders, geneticists, and agronomists.
}

\usage{
  data(gge2003)
}

\format{
  The format is:
  \verb{
    num [1:4, 1:3] 20 6 -10 8 -9 12 -6 -12 6 -15 ...
    - attr(*, "dimnames")=List of 2
    ..$ : chr [1:4] "G1" "G2" "G3" "G4"
    ..$ : chr [1:3] "E1" "E2" "E3"
  }
}

\references{
  Yan, B. W. and Kang, M. S. (2003)
  \emph{GGE biplot analysis : a graphical tool for breeders,
    geneticists, and agronomists}. CRC Press, New York, 288p.
}

\examples{
##
## Example from YAN, W & KANG, M.S. GGE biplot analysis : a graphical tool
## for breeders, geneticists, and agronomists
##

data(gge2003)
bp <- bpca(t(gge2003), var.rb=TRUE)

as.dist(bp$var.rb)

dev.new(w=8, h=4)
op = par(no.readonly=TRUE)
par(mfrow=c(1,2))

plot(bpca(gge2003, var.pos=2),
     main='Columns as variables \n (var.pos=2)',
     var.col=1,
     obj.col=c(2:4, 2), obj.cex=.8)

plot(bpca(gge2003, var.pos=1),
     main='Rows as variables \n (var.pos=1)',
     var.col=1,
     obj.col=2:4, obj.cex=.8)

par(op)
}

\keyword{datasets}
