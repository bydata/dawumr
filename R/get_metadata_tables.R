
#' Get Metadata Tables From API Response
#'
#' @param x A list object containing the fetched API response
#'
#' @return A list object
#' @importFrom purrr map
#' @importFrom dplyr mutate
#' @importFrom dplyr arrange
#' @importFrom dplyr bind_rows
#' @export
#'
#' @examples \dontrun{get_metadata_tables(x)}
get_metadata_tables <- function(x) {
  table_names <- c("Parliaments", "Institutes", "Taskers", "Methods", "Parties")
  db <- purrr::map(table_names, ~dplyr::bind_rows(x[[.x]], .id = "ID") |>
                     dplyr::mutate(ID = as.integer(ID)) |>
                     dplyr::arrange(ID))
  db <- purrr::set_names(db, table_names)
  return(db)
}
