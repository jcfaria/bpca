xtable.bpca <- function(x,
                        caption=NULL,
                        label=NULL,
                        align=NULL,
                        digits=NULL,
                        display=NULL,
                        auto=FALSE, ...)
{
  eigvec <- x$eigenvectors[, c(x$number)]
  eigval <- x$eigenvalues[c(x$number)]
  vret <- x$eigenvalues[x$number[1]:x$number[length(x$number)]]^2/sum(x$eigenvalues^2)
  vacum <- cumsum(vret)     

  x <- rbind(eigvec,
             eigval,
             vret,
             vacum)

  row.names(x) <- c(paste("Eigenvectors",
                          row.names(eigvec),
                          sep='\\_'), 
                    "Eigenvalues",
                    "Variance retained", 
                    "Variance accumulated")

  res <- xtable::xtable(x, 
                        caption=caption, 
                        label=label, 
                        align=align, 
                        digits=digits, 
                        display=display, 
                        auto=auto, ...)

  class(res) <- c("xtable.bpca",
                  "xtable",
                  "data.frame") 
  return(res)
}
