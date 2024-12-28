#' Denormalize the database
#'
#' @param x A list object with the DAWUM database
#' @param drop_id_vars Shall the ID variables (e.g. Party ID, Parliament ID) be
#'     dropped after adding the corresponding names? Default: TRUE
#'     
#' @noRd
#' @return A list object with the DAWUM database, the Result object is denormalized
denormalize <- function(x, drop_id_vars = TRUE) {
  results <- x$Results
  stopifnot(is.data.frame(results))
  stopifnot("Parliament_ID" %in% colnames(results))
  stopifnot("Institute_ID" %in% colnames(results))
  stopifnot("Tasker_ID" %in% colnames(results))
  stopifnot("Method_ID" %in% colnames(results))
  stopifnot("Party_ID" %in% colnames(results))

  # Parliaments
  results <- merge(results, x$Parliaments, by.x = "Parliament_ID", by.y = "ID")
  colnames(results)[colnames(results) == "Name"] <- "Parliament_Name"
  colnames(results)[colnames(results) == "Shortcut"] <- "Parliament_Shortcut"

  # Institutes
  results <- merge(results, x$Institutes, by.x = "Institute_ID", by.y = "ID")
  colnames(results)[colnames(results) == "Name"] <- "Institute_Name"

  # Taskers
  results <- merge(results, x$Taskers, by.x = "Tasker_ID", by.y = "ID")
  colnames(results)[colnames(results) == "Name"] <- "Tasker_Name"

  # Methods
  results <- merge(results, x$Methods, by.x = "Method_ID", by.y = "ID")
  colnames(results)[colnames(results) == "Name"] <- "Method_Name"

  # Parties
  results <- merge(results, x$Parties, by.x = "Party_ID", by.y = "ID")
  colnames(results)[colnames(results) == "Name"] <- "Party_Name"
  colnames(results)[colnames(results) == "Shortcut"] <- "Party_Shortcut"

  # reorder columns
  col_order <- c("ID", "Date", "Parliament_Shortcut", "Parliament_Name",
                 "Election", "Institute_Name",
                 "Party_Shortcut", "Party_Name", "Share", "Tasker_Name",
                 "Surveyed_Persons", "Survey_Period_Start", "Survey_Period_End",
                 "Parliament_ID", "Institute_ID", "Tasker_ID", "Method_ID",
                 "Party_ID")
  results <- results[col_order]

  if (drop_id_vars) {
    cols_drop <- c("Parliament_ID", "Institute_ID", "Tasker_ID", "Method_ID", "Party_ID")
    results <- results[, !(names(results) %in% cols_drop)]
  }
  x$Results <- results
  return(x)
}
