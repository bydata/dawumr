api_url <- "https://api.dawum.de/"
obj <- jsonlite::read_json(api_url)


table_names <- c("Parliaments", "Institutes", "Taskers", "Methods", "Parties")
db <- purrr::map(table_names, ~dplyr::bind_rows(obj[[.x]], .id = "Id") |>
                   dplyr::mutate(Id = as.numeric(Id)) |>
                   dplyr::arrange(Id))
db <- purrr::set_names(db, table_names)


last_update <- obj$Database$Last_Update
last_update <- as.character(readLines("https://api.dawum.de/last_update.txt",
                                      warn = FALSE))
db$last_update <- last_update

# View(obj$Surveys)
# View(obj$Surveys[[1]])
# names(obj$Surveys[[1]])
# str(obj$Surveys)

# foo <- list()
# foo$Date <- obj$Surveys[[1]]$Date
# foo$Surveyed_Persons <- obj$Surveys[[1]]$Surveyed_Persons
# as.data.frame(foo)

# variable_names <- c("Date", "Surveyed_Persons", "Parliament_ID", "Institute_ID", "Tasker_ID", "Method_ID" )
# foo <- purrr::map(variable_names, ~purrr::pluck(obj$Surveys[[1]], .x)) |>
#   purrr::set_names(variable_names) |> dplyr::bind_cols()
# foo$Survey_Period_Start <- obj$Surveys[[1]]$Survey_Period$Date_Start
# foo$Survey_Period_End <- obj$Surveys[[1]]$Survey_Period$Date_End

generate_result_metadata <- function(x) {
  variable_names <- c("Date", "Surveyed_Persons", "Parliament_ID", "Institute_ID", "Tasker_ID", "Method_ID" )
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


generate_result_dataframe <- function(x) {
  result <- data.frame(
    share = cbind(x$Results)
  )
  result$Party_ID <- rownames(result)
  rownames(result) <- NULL
  result <- result[c(2, 1)]

  return(result)
}


# foo2 <- data.frame(
#   Share = cbind(obj$Surveys[[1]]$Results)
# )
# foo2$Party_Id <- rownames(foo2)
# rownames(foo2) <- NULL
# foo2 <- foo2[c(2, 1)]
# foo2
#
# foo3 <- data.frame(
#   foo,
#   foo2
# )

generate_result <- function(x) {
  data.frame(
    generate_result_metadata(x),
    generate_result_dataframe(x)
  )
}


db$Results <- purrr::map_dfr(obj$Surveys, generate_result, .id = "ID")
# saveRDS(db, "dawum-db.rds")
