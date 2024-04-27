#' Extract metadata from Survey list object
#'
#' @param x A Survey list object from dawum API data
#'
#' @return A data frame with survey metadata (1 row, 8 columns)
#'
#' @examples \dontrun{extract_result_metadata(x)}
extract_result_metadata <- function(x) {
  variable_names <- c("Date", "Surveyed_Persons", "Parliament_ID", "Institute_ID",
                      "Tasker_ID", "Method_ID")

  metadata <- lapply(variable_names, function(var_name) x[[var_name]])
  names(metadata) <- variable_names
  metadata <- as.data.frame(metadata)

  metadata$Survey_Period_Start <- x$Survey_Period$Date_Start
  metadata$Survey_Period_End <- x$Survey_Period$Date_End

  id_columns <- grep("_ID$", names(metadata))
  metadata[, id_columns] <- lapply(metadata[, id_columns], as.integer)

  return(metadata)
}


#' Extract survey result data from Survey list object
#'
#' @description Extract survey result data from Survey list object.
#'     Each record represents the survey result for a party.
#' @param x A Survey list object from dawum API data
#'
#' @return A data frame with the results from a survey
#'
#' @examples \dontrun{extract_result_dataframe(x)}
extract_result_dataframe <- function(x) {
  result <- data.frame(
    Party_ID = names(x$Results),
    Share = as.numeric(unlist(x$Results))
  )
  return(result)
}


#' Wrapper function to extract result data and survey metadata
#'
#' @param x A Survey list object from dawum API data
#'
#' @return A dataframe with survey results and metadata
extract_result <- function(x) {
  data.frame(
    extract_result_metadata(x),
    extract_result_dataframe(x)
  )
}
