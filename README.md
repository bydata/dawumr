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

```{r}
# Pull all available data, return only the data frame with the poll results
dawum_df <- pull_dawum_dataframe()
```

Set the argument `newest_only` to TRUE to pull only the latest results by election and institute.

```{r}
# Pull only the most recent polls for each election and institute
dawum_db <- pull_dawum_dataframe(newest_only = TRUE)
```

You can also get the database as a list object with separate tables for institutes, parliaments etc. so that you can join tables for your specific purposes.

```{r}
# Pull all available data
dawum_db <- pull_dawum()

# Pull only the most recent polls for each parliament and institute
dawum_df <- pull_dawum(newest_only = TRUE)
```

## Institutes and Parliaments

The DAWUM database covers polls for the national election in Germany, elections in the 16 German federal states, and the European Parliament conducted by a variety of institutes.

This package pulls all available data, but makes no judgement of the quality of the polls or the institutes. It is up to the user to decide which institutes to include in their analyses.

The table provides an overview of elections and institutes covered (as of 2024-12-28):

|Institute Name             | Bundestag| EU| BW| BY| BE| BB| HB| HH| HE| MV| NI| NRW| RP| SL| SN| ST| SH| TH|
|:--------------------------|---------:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|---:|--:|--:|--:|--:|--:|--:|
|Allensbach                 |        99|  0|  0|  0|  0|  0|  0|  0|  0|  0|  5|   0|  0|  0|  0|  0|  0|  0|
|Civey                      |       112|  4|  1| 33| 18|  6|  0|  4|  7|  1|  4|   6|  1|  0| 12|  1|  1|  5|
|Forsa                      |       410|  2|  2| 14| 37|  7|  0|  4|  2| 10| 10|  18|  1|  1|  3|  0|  0|  4|
|Forschungsgruppe Wahlen    |       154| 12|  3|  6|  4|  4|  5|  2| 10|  2|  4|   5|  3|  4|  5|  2|  4|  5|
|GMS                        |        69|  0|  0| 44|  0|  0|  0|  0|  0|  0|  0|   0|  0|  0|  0|  1|  0|  0|
|Infratest dimap            |       183|  7| 23| 19| 21| 21|  8|  8| 15| 12| 13|  25| 30|  9|  9|  6| 12| 17|
|INSA                       |       604| 16| 21| 22| 25| 15|  5|  2| 13| 13| 14|  14|  9|  7| 18| 13| 11| 47|
|Institut Wahlkreisprognose |        52|  7| 11| 20| 17| 14| 12|  4| 22|  7| 16|  14|  8|  9| 13|  5| 12| 10|
|Verian (Emnid)             |       364|  0|  0|  0|  0|  0|  0|  0|  0|  0|  0|   0|  0|  0|  0|  0|  0|  0|
|YouGov                     |       103|  1|  0|  0|  0|  0|  0|  0|  0|  0|  0|   5|  0|  0|  0|  0|  0|  0|
|Other*                     |        65|  3|  0|  0|  0|  3|  1| 11|  0|  0|  1|   2|  1|  0|  7|  1|  0|  0|

\* Other: Institutes are named in the dataset and are grouped for this overview only.

## Contributions

Many thanks to [\@timonscheuer](https://github.com/timonscheuer) for the inspiration and support with early bugfixing.

## License

Source: Data from dawum.de. License: <https://dawum.de/API/#Lizenz>, ODC Open Database License (ODC-ODbL)
