# bpca <img src="man/figures/logo.png" align="right" height="139" />

<!-- Badges -->
[![R-CMD-check](https://github.com)](https://github.com)
[![Lifecycle: experimental](https://shields.io)](https://r-lib.org)
[![License: GPL-2](https://shields.io)](https://gnu.org)

The R package is **`bpca`**. This GitHub repository is named **`bpca2`** (workspace / checkout folder); after installation you always load **`library(bpca)`**.

**bpca** provides biplot analysis based on principal components, with this repo used as a modern playground for testing, refactoring, and AI-assisted development workflows.

## Highlights

- **PCA-based Biplot analysis** in reduced-dimensional spaces (2D and 3D).
- **AI-ready structure** for test automation and assisted code workflows.
- **Modern R package practices** focused on maintainability and iteration speed.
- **Continuous improvement mindset** for diagnostics and visualization quality.

## Installation

Install from this GitHub repository (the installed package name is still **`bpca`**):

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

## Project Layout

- `/R`: Core computational and plotting functions.
- `/tests`: Unit tests for reliability and CI validation.
- `/man`: Function documentation generated from source.
- `/vignettes`: Planned tutorials and usage guides.

## Contributing

Contributions are welcome. Open an **Issue** or submit a **Pull Request** with:

- Bug fixes and performance improvements.
- Documentation and developer-experience enhancements.
- New ideas for Biplot diagnostics and AI-driven PCA workflows.

## Roadmap (Experimental)

- Expand test coverage for edge cases and plotting behavior.
- Add practical vignettes with real-world datasets.
- Improve CI signals and package quality checks.

---
Developed by **Jose Claudio Faria**
