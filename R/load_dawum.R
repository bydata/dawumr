#' Load DAWUM Database
#'
#' @description This function retrieves data from DAWUM API, extracts relevant data
#'     from the API response and returns a list object with the database.
#' @param newest_only Logical. Retrieve only the newest data per institute and
#'     parliament/election.
#' @param denormalize Logical. Should the names of parties, institutes etc. be
#'    added to the results data frame? Default: TRUE
#' @param verbose Logical. Should messages be printed? Default: TRUE
#'
#' @return A list object which contains all metadata and survey results
#' @export
#'
#' @examples \dontrun{load_dawum_db()}
load_dawum_db <- function(newest_only = FALSE, denormalize = FALSE, verbose = TRUE) {

  # Retrieve data from API
  if (verbose) message("Retrieving data from DAWUM API.")
  if (newest_only) {
    obj <- retrieve_newest_data()
  } else {
    obj <- retrieve_data()
  }

  # Extract last update date
  db <- get_metadata_tables(obj)
  last_update <- obj$Database$Last_Update
  db$last_update <- last_update

  # Extract results
  if (verbose) message("Extracting survey results.")
  results_list <- lapply(
    names(obj$Surveys),
    function(survey_name) {
      survey <- obj$Surveys[[survey_name]]
      result <- extract_result(survey)
      result$ID <- survey_name
      return(result)
    })
  db$Results <- do.call(rbind, results_list)

  # Denormalize tables - this will add names for parties, parliaments etc. to the
  # data frame // default: FALSE
  if (denormalize) {
    db <- denormalize(db)
  }

  if (verbose) message(sprintf("Last update: %s", db$last_update))
  if (verbose) message("DONE.")
  return(db)
}


#' Load Result Data from DAWUM
#'
#' @description This function retrieves data from DAWUM API, extracts relevant data
#'     from the API response and returns a dataframe in which each record represents
#'     the poll result for a party.
#' @param newest_only Logical. Retrieve only the newest data per institute and
#'     parliament/election.
#' @param cast Logical. Cast columns to integers and dates where applicable. 
#'     Default: TRUE
#' @param verbose Logical. Print message while retrieving data. Default: TRUE
#'
#' @return A data frame with the survey results
#' @export
#'
#' @examples \dontrun{load_dawum_results()}
load_dawum_results <- function(newest_only = FALSE,
                               cast = TRUE,
                               verbose = TRUE) {
  
  obj <- load_dawum_db(newest_only = newest_only, denormalize = TRUE, verbose = verbose)
  
  if (cast) {
    obj$Result$Date <- as.Date(obj$Result$Date)
    obj$Result$Survey_Period_Start <- as.Date(obj$Result$Survey_Period_Start)
    obj$Result$Survey_Period_End <- as.Date(obj$Result$Survey_Period_End)
    obj$Result$Surveyed_Persons <-  as.integer(obj$Result$Surveyed_Persons)
    obj$Result$ID <-  as.integer(obj$Result$ID)
  }
  return(obj$Result)
}
