var.rdf <-
  function(x, var.rb, limit)
  {
    var.rob <- cor(x)
    n       <- ncol(x)
    var.rd  <- diag(n)
    diag(var.rd) <- '-'

    for (i in 1:(n-1)) {
      for (j in (i+1):n) {

        dif <- abs(var.rob[i,j] -
                   var.rb[i,j]) * 100

        if (dif > limit)
          res <- '*'
        else
          res <- ''

        var.rd[j,i] <- res          # fill lower.tri
        var.rd[i,j] <- var.rd[j,i]  # fill upper.tri
      }
    }

    dimnames(var.rd) <- list(dimnames(x)[[2]],
                             dimnames(x)[[2]])

    return(as.data.frame(var.rd))
  }
