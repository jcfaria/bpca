\name{ontario}
\alias{ontario}

\title{
  Ontario winter wheat (1993)
}

\description{
  The sample data are yields from the 1993 Ontario winter wheat (Triticum aestivum L.) performance
  trials, in which 18 cultivars were tested at nine locations (Yan and Kang 2003)
}

\usage{
  data(ontario)
}

\format{
  A data frame with 18 observations on the following 10 variables.
}

\source{
  Yan W, Kang MS (2003). GGE Biplot Analysis: A Graphical Tool for Breeders, Geneticists,
  and Agronomists. CRC Press, Boca Raton, FL, USA.
}

\examples{
data(ontario)

# 2d
plot(bpca(ontario,
          d=1:2))

# 3d
plot(bpca(ontario,
          d=1:3),
     rgl.use=TRUE)
}

\keyword{datasets}
