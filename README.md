# bpca2 <img src="man/figures/logo.png" align="right" height="139" />

<!-- Badges -->
[![R-CMD-check](https://github.com)](https://github.com)
[![Lifecycle: experimental](https://shields.io)](https://r-lib.org)
[![License: GPL-3](https://shields.io)](https://gnu.org)

**bpca2** is an experimental R package designed as a playground for AI-driven testing, refactoring, and Biplot analysis enhancements. It builds upon the foundations of the original `bpca` package.

## í ½íº€ Overview

The package provides robust tools for Biplot analysis based on Principal Component Analysis (PCA), enabling the visualization of multivariate data matrices in reduced-dimensional spaces (2D and 3D).

### Why bpca2?
- **AI-Ready:** Structured to facilitate automated testing and integration with AI-assisted coding models.
- **Modern Infrastructure:** Updated to leverage current R development workflows.
- **Enhanced Diagnostics:** Improved tools for biplot accuracy and visual diagnostics.

## í ½í»  Installation

Since this is a development and testing version, you can install it directly from GitHub:

```r
# Install the remotes package if you haven't already
# install.packages("remotes")

# Install bpca2 from GitHub
remotes::install_github("jcfaria/bpca2")
```

## í ½í³Š Quick Start

Generating a basic Biplot with `bpca2` is straightforward:

```r
library(bpca2)

# Using the classic iris dataset
bp <- bpca(iris[-5], d=1:2)
plot(bp,
     var.col='blue',
     var.factor=2,
     main='Biplot - Iris Dataset')
```

## í ½í³‚ Project Structure

* `/R`: Core functions for computation and plotting.
* `/tests`: Unit tests (crucial for AI validation and CI/CD).
* `/man`: Technical documentation for package functions.
* `/vignettes`: (Planned) Detailed tutorials and use cases.

## í ¾í´ Contributing

This repository is a testing environment. Feel free to open **Issues** or submit **Pull Requests** with suggestions for modernization, performance tweaks, or new AI-driven PCA algorithms.

---
Developed by **JosÃ© ClÃ¡udio Faria**
