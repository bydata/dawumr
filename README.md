# R API for DAWUM ("Darstellung und Auswertung von Wahlumfragen")

<!-- badges: start -->

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

<!-- badges: end -->

**dawumr** provides convenience functions to pull and transform the election poll data from [dawum.de](https://dawum.de/) using R.

DAWUM ("Darstellung und Auswertung von Wahlumfragen") collects election poll results from at the national level ("Bundestag") and federal state level ("Landtag"/"Abgeordnetenhaus") in Germany as well as polls for the European Parliament conducted by various institutes. The database goes back to 2017.

## Installation

```{r}
# install.packages("devtools")
devtools::install_github("https://github.com/bydata/dawumr/")
```

## Basic functionality

```{r}
# Pull all available data (returns the full database with separate tables for results, institutes etc.)
dawum_db <- pull_dawum()

# Pull all available data, return only the dataframe with the poll results
dawum_df <- pull_dawum_dataframe()

# Pull only the most recent polls for each parliament and institute
dawum_db <- pull_dawum(newest_only = TRUE)
dawum_df <- pull_dawum_dataframe(newest_only = TRUE)
```

## Institutes and Parliaments

The DAWUM database covers polls for the national election in Germany, elections in the 16 German federal states, and the European Parliament conducted by a variety of institutes.

This package pulls all available data, but makes no judgement of the quality of the polls or the institutes. It is up to the user to decide which institutes to include.

The table provides an overview of elections and institutes covered (as of 2023-10-07):

| Institute                  | Bundestag |  EU |  BW |  BY |  BE |  BB |  HB |  HH |  HE |  MV |  NI | NRW |  RP |  SL |  SN |  ST |  SH |  TH |
|:---------------|-------:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Allensbach                 |        84 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   3 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |
| Civey                      |       112 |   4 |   1 |  30 |  18 |   6 |   0 |   4 |   7 |   1 |   4 |   6 |   1 |   0 |   9 |   1 |   1 |   5 |
| Forsa                      |       347 |   1 |   2 |  13 |  37 |   6 |   0 |   3 |   1 |   8 |  10 |  15 |   1 |   1 |   0 |   0 |   0 |   1 |
| Forschungsgruppe Wahlen    |       131 |   7 |   3 |   6 |   4 |   2 |   5 |   2 |  10 |   2 |   4 |   5 |   3 |   4 |   2 |   2 |   4 |   2 |
| GMS                        |        61 |   0 |   0 |  40 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   1 |   0 |   0 |
| Infratest dimap            |       163 |   5 |  19 |  18 |  18 |  16 |   8 |   6 |  14 |  10 |  11 |  22 |  26 |   8 |   6 |   6 |  12 |  14 |
| INSA                       |       477 |   9 |  16 |  21 |  23 |   9 |   5 |   2 |  11 |  10 |  12 |  14 |   9 |   7 |  14 |   8 |  10 |  38 |
| Institut Wahlkreisprognose |        42 |   2 |  10 |  20 |  17 |   8 |  12 |   3 |  22 |   6 |  16 |  14 |   7 |   8 |   8 |   4 |  12 |   7 |
| Kantar (Emnid)             |       338 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |
| YouGov                     |        88 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   5 |   0 |   0 |   0 |   0 |   0 |   0 |
| Other\*                    |        49 |   1 |   0 |   0 |   0 |   3 |   1 |   9 |   0 |   0 |   1 |   2 |   1 |   0 |   7 |   1 |   0 |   0 |

\* Other: Institutes are named in the dataset and are grouped for this overview only.

## Motivation

Many thanks to Timon Scheuer for giving me the idea.

## License

Source: Data from dawum.de License: <https://dawum.de/API/#Lizenz>, ODC Open Database License (ODC-ODbL)
