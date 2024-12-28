#' @details
#' `r lifecycle::badge("experimental")`
#' 
#' The `dawumr` package provides convenience functions to pull and transform
#' election poll data from [dawum.de](https://dawum.de/) using R.
#'
#' Data from [dawum.de](https://dawum.de/). Open Database License (ODC-ODbL): <https://opendatacommons.org/licenses/odbl/1-0/>


#' @examples
#' \dontrun{
#' # Pull all available poll data as a data frame:
#' dawum_df <- load_dawum_results()
#'
#' # Pull only the latest results by election and institute:
#' dawum_df <- load_dawum_results(newest_only = TRUE)
#' }
"_PACKAGE"
