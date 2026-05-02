<!-- José Cláudio Faria -->
# bpca

<!-- Badges -->
[![CRAN status](https://www.r-pkg.org/badges/version/bpca)](https://cran.r-project.org/package=bpca)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/bpca)](https://cran.r-project.org/package=bpca)
[![CRAN checks](https://badges.cranchecks.info/worst/bpca.svg)](https://cran.r-project.org/web/checks/check_results_bpca.html)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![License: GPL-2](https://img.shields.io/badge/License-GPL--2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

`bpca` is an R package for biplot analysis based on principal components.
This repository is named `bpca2`, but the installed package is always loaded with `library(bpca)`.

## Key Features

- **PCA-based Biplot analysis** in reduced-dimensional spaces (2D and 3D).
- **Multiple factorization methods** (`hj`, `sqrt`, `jk`, `gh`) for different interpretations.
- **Quality diagnostics** for dimensionality reduction and representation fidelity.
- **Reporting support** with `xtable(bpca(...))` and `print(..., type = "html")`.

## Installation

Install from CRAN:

```r
install.packages("bpca")
```

Install the development version from GitHub:

```r
# install.packages("remotes")
remotes::install_github("jcfaria/bpca2")
```

## Quick Start

```r
library(bpca)

# Example with the classic iris dataset
bp <- bpca(iris[-5], d = 1:2)
plot(
  bp,
  var.col = "blue",
  var.factor = 2,
  main = "Biplot - Iris Dataset"
)
```

For more complete examples, see:

- `demo("bpca", package = "bpca")`
- `vignette("bpca-overview", package = "bpca")`

## Project Layout

- `/R`: Core computational and plotting functions.
- `/data`: Example datasets shipped with the package.
- `/demo`: Runnable demos illustrating usage.
- `/man`: Documentation (`.Rd` files).
- `/inst`: Extra package materials (e.g. citations).
- `/vignettes`: Vignettes and tutorials.

## Contributing

Contributions are welcome. Open an **Issue** or submit a **Pull Request** with:

- Bug fixes and performance improvements.
- Documentation and usability improvements.
- New ideas for diagnostics and visualization workflows.

## Roadmap (Experimental)

- Expand test coverage for edge cases and plotting behavior.
- Add practical vignettes with real-world datasets.
- Improve CI signals and package quality checks.

---
Developed by:
Faria, J. C.; Allaman, I. B.; and Demétrio, C. G. B.  
Universidade Estadual de Santa Cruz - UESC  
Departamento de Ciências Exatas - DCEX  
Ilhéus - Bahia - Brasil
