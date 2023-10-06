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
                      "Tasker_ID", "Method_ID" )
  metadata <- purrr::map(variable_names, ~purrr::pluck(x, .x)) |>
    purrr::set_names(variable_names) |> dplyr::bind_cols()
  metadata$Survey_Period_Start <- x$Survey_Period$Date_Start
  metadata$Survey_Period_End <- x$Survey_Period$Date_End
  # Convert ID variables to integer
  metadata <- metadata |>
    dplyr::mutate(dplyr::across(dplyr::ends_with("ID"),
                                as.integer))

  return(metadata)
}


#' Generate survey result data from Survey list object
#'
#' @description Generate survey result data from Survey list object.
#'     Each record represents the survey result for a party.
#' @param x A Survey list object from dawum API data
#'
#' @return A data frame with the results from a survey
#' @importFrom purrr reduce
#' @export
#'
#' @examples \dontrun{generate_result_dataframe(x)}
generate_result_dataframe <- function(x) {
  result <- data.frame(
    # TODO: Which of these steps are required?
    Share = cbind(x$Results) |> purrr::reduce(c) |> unlist() |> as.numeric()
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
