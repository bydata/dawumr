#' Get DAWUM Data
#'
#' @description This function retrieves data from DAWUM API, extracts relevant data
#'     from the API response and returns a list object with all metadata and
#'     survey results.
#' @param verbose Logical. Should messages be printed? Default: TRUE
#'
#' @return A list object which contains all metadata and survey results
#' @importFrom purrr map_dfr
#' @export
#'
#' @examples \dontrun{get_dawum_data()}
get_dawum_data <- function(verbose = TRUE) {

  # Retrieve data from API
  if (verbose) message("Retrieving data from DAWUM API.")
  obj <- retrieve_data()

  # Extract last update date
  db <- get_metadata_tables(obj)
  last_update <- obj$Database$Last_Update
  db$last_update <- last_update

  # Extract results
  if (verbose) message("Extracting survey results.")
  db$Results <- purrr::map_dfr(obj$Surveys, generate_result, .id = "ID")

  if (verbose) message("DONE.")
  return(db)
}
