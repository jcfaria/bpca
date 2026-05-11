##
## dt.tools demo:
## vector lengths, pairwise angles, and projected correlations
## for numeric variables in a data.frame or matrix (n x p)
##

dt <- dt.tools(iris, 2) # Non-numeric columns are ignored internally.

# Explore the object created by dt.tools()
class(dt)
names(dt)
str(dt)

dt$length
dt$angle
dt$r
dt

# Check consistency with base cor()
(iris.tools <- round(dt.tools(iris,
                              center=2)$r,
                     5))

(iris.obsv  <- round(cor(iris[-5]),
                     5))

all(iris.tools == iris.obsv)
