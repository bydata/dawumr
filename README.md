# R API for DAWUM ("Darstellung und Auswertung von Wahlumfragen")

<!-- badges: start -->

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

<!-- badges: end -->

**dawumr** provides convenience functions to pull and transform the election poll data from [dawum.de](https://dawum.de/) using R.

DAWUM ("Darstellung und Auswertung von Wahlumfragen") collects election poll results at the national level ("Bundestag") and federal state level ("Landtag"/"Abgeordnetenhaus") in Germany as well as polls for the European Parliament conducted by various institutes. The database goes back to 2017.

## Installation

The package can be installed from Github as a source package.

```{r}
# install.packages("devtools")
devtools::install_github("https://github.com/bydata/dawumr/")
```

## Basic functionality

The typical use case is probably to pull all survey results as a data frame.

Pull only the latest results by election and institute:

``` r
# Pull only the most recent polls for each election and institute
dawum_df_latest <- load_dawum_results(newest_only = TRUE)
```

Pull data as a list object with the database with separate tables for institutes, parliaments, etc.:

``` r
# Pull all available data
dawum_db <- load_dawum_db()

# Pull only the most recent polls for each parliament and institute
dawum_db_latest <- load_dawum_db(newest_only = TRUE)
```

## Data Dictionary

For a brief description of the database, visit <https://dawum.de/API/#Aufbau> (in German).

## Institutes and Parliaments

The DAWUM database contains polls on the German federal election, the elections in the 16 German states and the European Parliament, conducted by a variety of institutes.

This package includes all available data, but makes no judgement regarding the quality of the polls conducted. It is up to the user to decide which institutes to include in their analyses.

The table gives an overview of the elections and institutes covered (as of 2024-12-28):

| Institute                  | Total | Bundestag |  EU |  BW |  BY |  BE |  BB |  HB |  HH |  HE |  MV |  NI | NRW |  RP |  SL |  SN |  ST |  SH |  TH |
|:-----|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Allensbach                 |   104 |        99 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   5 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |
| Civey                      |   216 |       112 |   4 |   1 |  33 |  18 |   6 |   0 |   4 |   7 |   1 |   4 |   6 |   1 |   0 |  12 |   1 |   1 |   5 |
| Forsa                      |   525 |       410 |   2 |   2 |  14 |  37 |   7 |   0 |   4 |   2 |  10 |  10 |  18 |   1 |   1 |   3 |   0 |   0 |   4 |
| Forschungsgruppe Wahlen    |   234 |       154 |  12 |   3 |   6 |   4 |   4 |   5 |   2 |  10 |   2 |   4 |   5 |   3 |   4 |   5 |   2 |   4 |   5 |
| GMS                        |   114 |        69 |   0 |   0 |  44 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   1 |   0 |   0 |
| Infratest dimap            |   438 |       183 |   7 |  23 |  19 |  21 |  21 |   8 |   8 |  15 |  12 |  13 |  25 |  30 |   9 |   9 |   6 |  12 |  17 |
| INSA                       |   869 |       604 |  16 |  21 |  22 |  25 |  15 |   5 |   2 |  13 |  13 |  14 |  14 |   9 |   7 |  18 |  13 |  11 |  47 |
| Institut Wahlkreisprognose |   253 |        52 |   7 |  11 |  20 |  17 |  14 |  12 |   4 |  22 |   7 |  16 |  14 |   8 |   9 |  13 |   5 |  12 |  10 |
| Verian (Emnid)             |   364 |       364 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |
| YouGov                     |   109 |       103 |   1 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   5 |   0 |   0 |   0 |   0 |   0 |   0 |
| Other\*                    |    95 |        65 |   3 |   0 |   0 |   0 |   3 |   1 |  11 |   0 |   0 |   1 |   2 |   1 |   0 |   7 |   1 |   0 |   0 |

\* Other: Institutes are named in the dataset and are grouped for this overview only.

## Versions

See [NEWS](NEWS.md)

## Contributions

Many thanks to [\@timonscheuer](https://github.com/timonscheuer) for the inspiration and support with early bugfixing.

## License

Source: Data from dawum.de. License: <https://dawum.de/API/#Lizenz>, ODC Open Database License (ODC-ODbL)
