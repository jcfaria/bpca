var.rdf <-
  function(x,
           var.rb,
           limit)
  {
    dif <- abs(var.rb - cor(x)) * 100
    g <- dif > limit
    l <- dif <= limit

    dif[g] <- '*'
    dif[l] <- ''
    diag(dif) <- '-'

    var.rd <- dif
    dimnames(var.rd) <- list(dimnames(x)[[2]],
                             dimnames(x)[[2]])

    return(as.data.frame(var.rd))
  }
