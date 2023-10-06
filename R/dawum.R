#' Get DAWUM Data
#'
#' @description This function retrieves data from DAWUM API, extracts relevant data
#'     from the API response and returns a list object with all metadata and
#'     survey results.
#' @param denormalize Logical. Should the names of parties, institutes etc. be
#'    added to the results data frame? Default: TRUE
#' @param verbose Logical. Should messages be printed? Default: TRUE
#'
#' @return A list object which contains all metadata and survey results
#' @importFrom purrr map_dfr
#' @export
#'
#' @examples \dontrun{dawum()}
dawum <- function(denormalize = FALSE, verbose = TRUE) {

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

  # Denormalize tables - this will add names for parties, parliaments etc. to the
  # data frame // default: FALSE
  if (denormalize) {
    db <- denormalize(db)
  }

  if (verbose) message(sprintf("Last update: %s", db$last_update))
  if (verbose) message("DONE.")
  return(db)
}
