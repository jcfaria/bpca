# bpca2 News

## Development Version

### Modernization and AI Integration
- Migrated the legacy `NEWS` file to `NEWS.md` for improved rendering on GitHub and `pkgdown`.
- Restructured the repository as a playground for AI-driven testing and refactoring.
- Updated project infrastructure to align with modern R development workflows (CI/CD ready).

### Initial Modernized Release
- Forked and updated from the original `bpca` package.
- Cleaned core functions to improve readability for AI-assisted analysis.
- Added documentation stubs for planned and evolving features.

## 1.4-0 (2026-04-26) - Faria, J. C.

### General Improvements
- Standardized function documentation with Roxygen2.
- Enhanced 2D and 3D biplot diagnostics for improved visual clarity.

## 1.3-10 (2026-04-25) - Faria, J. C.
- Added support for vectorized `var.pos` in 2D and 3D plots, enabling precise manual label placement to reduce overlap.
- Fixed misaligned variable-to-object projections in `plot.bpca.2d` (`type = "eo"`) by rewriting projection logic to properly account for scaling.

## 1.3-9 (2026-04-21) - Faria, J. C.
- Optimized `plot.bpca.3d` rendering performance when using `rgl`.
- Fixed an issue in `plot.bpca.3d` that prevented variable vectors from using distinct colors.
- Improved framing behavior in `plot.bpca.2d` and `plot.bpca.3d`, reducing the need for manual adjustments with `var.factor`, `xlim`, `ylim`, and `zlim`.
- Improved package and function documentation.

## 1.3-8 (2025-10-15) - Faria, J. C.
- Improved package and function documentation.

## 1.3-7 (2023-11-23) - Faria, J. C.
- Improved package and function documentation.

## 1.3-6 (2023-11-20) - Faria, J. C.
- Removed documentation notes as required by CRAN.

## 1.3-5 (2023-11-18) - Faria, J. C.
- Adjusted file encoding as required by CRAN.
- Performed substantial updates and improvements across package and function documentation.

## 1.3-4 (2021-03-23) - Faria, J. C.
- Completely redid the vignette to make it simpler, more direct, and more instructive.

## 1.3-3 (2021-03-19) - Allaman, I. B.
- Corrected a class-related bug in `xtable.bpca`.
- Fixed a bug in `print.xtable.bpca`; updated related commands and `aux_com1` handling so `sanitize.rownames.function` works properly.

## 1.3-2 (2020-04-01) - Allaman, I. B.
- Created `xtable.bpca` and `print.xtable.bpca`.
- Deprecated and removed `latex.bpca`, `print.latex.bpca`, and `summary.latex.bpca`; corresponding `.Rd` files were removed.
- Updated `NAMESPACE` and `DESCRIPTION` accordingly.

## 1.3-1 (2018-06-16) - Allaman, I. B.
- Updated `latex.bpca`: changed `footenotes` default from `""` to `NULL`.

## 1.3-0 (2018-06-07) - Allaman, I. B.
- Added `stats`, `graphics`, and `grDevices` imports in `NAMESPACE` to align with CRAN requirements.

## 1.2-2 (2013-11-23) - Faria, J. C.
- Added LaTeX table export for reduction summaries (`latex.bpca`).
- Improved parts of the source code.
- Added dataset `marina.rda`.
- Improved documentation.
- Removed unnecessary `require` calls for packages already attached via `Depends` (`rgl` and `scatterplot3d`).
- Released to CRAN.

## 1.2-1 (2012-12-12) - Faria, J. C.
- Added Ivan Bezerra Allaman as co-author in the project workflow.
- Added new plot options.
- Added new center options.
- Added new scale options.
- Added new summary options.
- Restricted release to testers.

## 1.2-0 (2012-10-06) - Faria, J. C.
- Improved parts of the source code.
- Removed `var.position` from the package; when needed, users can swap variable/object positions with `bpca(t(dad))`.
- Restricted release to testers.

## 1.0-10 (2012-02-20) - Faria, J. C.
- Applied cosmetic updates to `plot.bpca.3d`.

## 1.0-9 (2011-08-22) - Faria, J. C.
- Applied cosmetic updates to `summary`.

## 1.0-8 (2011-04-21) - Faria, J. C.
- Applied cosmetic updates to documentation.

## 1.0-7 (2011-04-20) - Faria, J. C.
- Improved `summary` method.
- Removed the comparison demo.

## 1.0-6 (2011-04-19) - Faria, J. C.
- Improved aliases for `summary` and `plot` methods in documentation.

## 1.0-5 (2011-04-09) - Faria, J. C.
- Fixed platform NOTE status in `plot.bpca.3d` (`matrix(0, nc = 3)` partial argument match of `nc` to `ncol`).

## 1.0-4 (2011-03-22) - Faria, J. C.
- Updated `plot.bpca.2d` and `plot.bpca.3d` to show, by default, the retained variation for each principal component on axis labels.
- Improved `summary` method.

## 1.0-3 (2009-06-10) - Faria, J. C.
- Updated `plot.bpca.2d` and `plot.bpca.3d` to accept `xlim`, `ylim`, `zlim`, `xlab`, `ylab`, and `zlab`.
- Reworked demos.
- Included PDF documentation in the package.

## 1.0-2 (2008-07-15) - Faria, J. C.
- Released to CRAN.
- Applied English corrections (by Clarice).
- Removed demo scripts using `obj.identify = TRUE`.

## 1.0-1 (2008-07-01) - Faria, J. C.
- First restricted release (testers only).
