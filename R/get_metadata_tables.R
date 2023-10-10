
#' Get Metadata Tables From API Response
#'
#' @param x A list object containing the fetched API response
#'
#' @return A list object
#' @importFrom dplyr bind_rows
#' @export
#'
#' @examples \dontrun{get_metadata_tables(x)}
get_metadata_tables <- function(x) {
  table_names <- c("Parliaments", "Institutes", "Taskers", "Methods", "Parties")
  fun <- function(table_name) {
    x[[table_name]] <- dplyr::bind_rows(x[[table_name]], .id = "ID")
    x[[table_name]]$ID <- as.integer(x[[table_name]]$ID)
    x[[table_name]] <-  x[[table_name]][order(x[[table_name]]$ID), ]
  }
  db <- lapply(table_names, fun)
  names(db) <- table_names
  return(db)
}
