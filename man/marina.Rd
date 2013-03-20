\name{marina}
\alias{marina}

\title{Films produced in Brazil from 2007 to 2011}

\description{
  A data.frame containing the films produced in Brazil from 2007 to 2011.
}

\usage{
  marina
}

\format{
  The format is:
  'data.frame':	25 obs. of  6 variables:
  $ year: int  2011 2011 2011 2011 2011 2010 2010 2010 2010 2010 ...
  $ regE: Factor w/ 5 levels "CO","N","NE",..: 1 5 4 3 2 1 5 4 3 2 ...
  $ F   : int  84 55 63 44 25 40 54 37 49 27 ...
  $ D   : int  26 13 19 16 7 9 14 11 19 6 ...
  $ MD  : int  22 9 13 14 5 6 11 10 13 3 ...
  $ WD  : int  4 4 6 2 2 3 3 1 6 3 ...

  year: Year in which the film was produced
  regE: Region of the exhibition of the film
  F   : Total number of films
  D   : Number of documentaries
  MD  : Documentary directed by men
  WD  : Documentary directed by woman

}

\examples{
  data(marina)
  marina
}

\keyword{datasets}
\keyword{movie}
