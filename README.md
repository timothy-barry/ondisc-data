
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ondiscdata

This package contains data for use in examples and vignettes of the
`ondisc` package. All datasets are single-cell datasets, stored in HDF5
(.h5), matrix market (.mtx), ondisc (.odm), or R object (.rds) format.

## Installation

Install the package from Github via the following command:

``` r
# install.packages("devtools")
devtools::install_github("katsevich-lab/ondiscdata")
```

## Data overview

The tree structure of the data directory is as follows:

    ├── h5_list
    │   ├── batch-1_1.h5
    │   ├── batch-1_2.h5
    │   ├── batch_2-1.h5
    │   └── source
    ├── mtx
    │   ├── barcodes.tsv
    │   ├── features.tsv
    │   ├── matrix.mtx
    │   └── source
    ├── mtx_list
    │   ├── mtx_dir1
    │   │   ├── barcodes.tsv
    │   │   ├── features.tsv
    │   │   └── matrix.mtx
    │   ├── mtx_dir2
    │   │   ├── barcodes.tsv
    │   │   ├── features.tsv
    │   │   └── matrix.mtx
    │   ├── mtx_dir3
    │   │   ├── barcodes.tsv
    │   │   ├── features.tsv
    │   │   └── matrix.mtx
    │   └── source
    ├── odm
    │   ├── gRNA
    │   │   ├── matrix.odm
    │   │   └── metadata.rds
    │   ├── gene
    │   │   ├── matrix.odm
    │   │   └── metadata.rds
    │   └── source
    └── r_matrix
        ├── gRNA
        │   ├── barcodes.rds
        │   ├── features.rds
        │   └── matrix.rds
        ├── gene
        │   ├── barcodes.rds
        │   ├── features.rds
        │   └── matrix.rds
        └── source

-   **h5_list**: Data on 58382 genes and 32727 cells spread across three
    HDF5 (.h5) files. Each file contains a different subset of cells
    (11523, 10379, and 10825 cells per file).

-   **mtx**: Data on 36601 genes and 587 cells in matrix market (.mtx)
    format.

-   **mtx_list**: Data on 10000 genes and 7500 cells spread across three
    .mtx files (2000, 3000, and 2500 cells per file). These data are
    synthetic.

-   **odm**: An `ondisc` matrix of gene expression data collected on
    58382 genes and 2000 cells, and an `ondisc` matrix of gRNA
    indicators collected on 516 gRNAs and the same 2000 cells.

-   **r_matrix**: The same data as above, but stored in R matrix format.

## Accessing the data

To get the file path of a given file, use the system.file command. For
example, to get the full file path of `mtx/matrix.mtx`, use

    system.file("extdata", "mtx/matrix.mtx", package = "ondiscdata")

To access `h5_list/batch-1_1.h5`, use

    system.file("extdata", "h5_list/batch-1_1.h5", package = "ondiscdata")

## Data sources

1.  Xie, Shiqi, et al. “Global analysis of enhancer targets reveals
    convergent enhancer-driven regulatory modules.” Cell reports 29.9
    (2019): 2570-2578. [Raw data
    link](https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE129837).

2.  500 Human PBMCs, 3’ LT v3.1, Chromium X. Single Cell Gene Expression
    Dataset by Cell Ranger 6.1.0. [Raw data
    link](https://www.10xgenomics.com/resources/datasets/500-human-pbm-cs-3-lt-v-3-1-chromium-x-3-1-standard-6-1-0).

------------------------------------------------------------------------

[Tim Barry](https://github.com/timothy-barry)
