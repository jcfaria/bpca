\name{gabriel1971}
\alias{gabriel1971}

\title{Percentages of households having various facilities and appliances in East
  Jerusalem Arab areas, by quarters of the town}

\description{
  Percentages of households having various facilities and appliances in East
  Jerusalem Arab areas, by quarters of the town. The average percentages in
  each quarter indicate the standard of living of that area and the average
  percentage of each facility or appliance its over-all prevalence.
}

\usage{
  gabriel1971
}

\format{
  The format is:
  num [1:8, 1:9] 98.2 78.8 14.4 86.2 32.9 73 4.6 29.2 97.2 81 ...
  - attr(*, "dimnames")=List of 2
  ..$ : chr [1:8] "toilet" "kitchen" "bath" "eletricity" ...
  ..$ : chr [1:9] "CRISTIAN" "ARMENIAN" "JEWISH" "MOSLEM" ...
}

\references{
  Gabriel, K. R.  (1971)
  The biplot graphical display of matrices with application to principal
  component analysis.
  \emph{Biometrika} \bold{58}, 453-467.
}

\examples{
  ##
  ## A simple example
  ##
  data(gabriel1971)
  bp <- bpca(gabriel1971)

  x11(w=6, h=6)
  plot(bp, var.factor=2)

  # Exploring the object 'bp' created by the function 'bpca'
  class(bp)
  names(bp)
  str(bp)

  summary(bp)
  bp$call
  bp$eigenval
  bp$eigenvec
  bp$numb
  bp$import
  bp$coord
  bp$coord$obj
  bp$coord$var
  bp$var.rb
  bp$var.rd
}

\keyword{datasets}
