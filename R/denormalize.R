#' Title
#'
#' @param x A list object with the DAWUM database
#' @param drop_id_vars Shall the ID variables (e.g. Party ID, Parliament ID) be
#'     dropped after adding the corresponding names? Default: TRUE
#'
#' @return A list object with the DAWUM database, the Result object is denormalized
#' @import dplyr
#' @importFrom rlang .data
denormalize <- function(x, drop_id_vars = TRUE) {
  stopifnot(is.data.frame(x$Results))
  stopifnot("Parliament_ID" %in% colnames(x$Results))
  stopifnot("Institute_ID" %in% colnames(x$Results))
  stopifnot("Tasker_ID" %in% colnames(x$Results))
  stopifnot("Method_ID" %in% colnames(x$Results))
  stopifnot("Party_ID" %in% colnames(x$Results))
  x$Results <- x$Results |>
    dplyr::inner_join(x$Parliaments, by = c("Parliament_ID" = "ID")) |>
    dplyr::rename(
      Parliament_Name = .data$Name,
      Parliament_Shortcut = .data$Shortcut
    ) |>
    dplyr::inner_join(x$Institutes, by = c("Institute_ID" = "ID")) |>
    dplyr::rename(
      Institute_Name = .data$Name
    ) |>
    dplyr::inner_join(x$Taskers, by = c("Tasker_ID" = "ID")) |>
    dplyr::rename(
      Tasker_Name = .data$Name
    ) |>
    dplyr::inner_join(x$Methods, by = c("Method_ID" = "ID")) |>
    dplyr::rename(
      Method_Name = .data$Name
    ) |>
    dplyr::inner_join(x$Parties, by = c("Method_ID" = "ID")) |>
    dplyr::rename(
      Party_Name = .data$Name,
      Party_Shortcut = .data$Shortcut,
    )

  # reorder columns
  col_order <- c("ID", "Date", "Parliament_Shortcut", "Parliament_Name",
                 "Election", "Institute_Name",
                 "Party_Shortcut", "Party_Name", "Share", "Tasker_Name",
                 "Surveyed_Persons", "Survey_Period_Start", "Survey_Period_End",
                 "Parliament_ID", "Institute_ID", "Tasker_ID", "Method_ID",
                 "Party_ID")
  x$Results <- x$Results[col_order]

  if (drop_id_vars) {
    x$Results <- subset(x$Results, select = -c(Parliament_ID, Institute_ID, Tasker_ID, Method_ID,
                       Party_ID))
  }
  return(x)
}
