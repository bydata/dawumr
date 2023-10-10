#' Generate metadata from Survey list object
#'
#' @param x A Survey list object from dawum API data
#'
#' @return A data frame with survey metadata (1 row, 8 columns)
#' @export
#'
#' @examples \dontrun{generate_result_metadata(x)}
generate_result_metadata <- function(x) {
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


#' Generate survey result data from Survey list object
#'
#' @description Generate survey result data from Survey list object.
#'     Each record represents the survey result for a party.
#' @param x A Survey list object from dawum API data
#'
#' @return A data frame with the results from a survey
#' @export
#'
#' @examples \dontrun{generate_result_dataframe(x)}
generate_result_dataframe <- function(x) {
  result <- data.frame(
    Share = cbind(x$Results) |> unlist() |> as.numeric()
  )
  result$Party_ID <- as.numeric(rownames(result))
  rownames(result) <- NULL
  result <- result[c(2, 1)]

  return(result)
}


generate_result <- function(x) {
  data.frame(
    generate_result_metadata(x),
    generate_result_dataframe(x)
  )
}
