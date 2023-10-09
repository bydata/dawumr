# R API for DAWUM ("Darstellung und Auswertung von Wahlumfragen")

**dawumr** provides convenience functions to pull and transform the election poll data from [dawum.de](https://dawum.de/) using R.

DAWUM ("Darstellung und Auswertung von Wahlumfragen") collects election poll results from at the national level ("Bundestag") and federal state level ("Landtag"/"Abgeordnetenhaus") in Germany conducted by various institutes. The database goes back to 2017.

## Installation

```{# install.packages("devtools")}
devtools::install_github("https://github.com/bydata/dawumr/")
```

## Basic functionality

```{# Pull all available data (returns the full database with separate tables for results, institutes etc.)}
dawum_db <- pull_dawum()

# Pull all available data, return only the dataframe with the poll results
dawum_df <- pull_dawum_dataframe()

# Pull only the most recent polls for each parliament and institute
dawum_db <- pull_dawum(newest_only = TRUE)
dawum_df <- pull_dawum_dataframe(newest_only = TRUE)

```

## License

Source: Data from dawum.de License: <https://dawum.de/API/#Lizenz>, ODC Open Database License (ODC-ODbL)
