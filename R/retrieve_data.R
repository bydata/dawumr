
#' Retrieve data
#'
#' @description Pull data from the API endpoint provided by DAWUM (https://dawum.de/).
#'     Data from dawum.de (License: ODC-ODbL). For the API documentation, refer to
#'     https://dawum.de/API/
#' @param api_endpoint_url The API endpoint url. Default: https://api.dawum.de/
#'
#' @return A list object with the full data provided by the API
#' @importFrom jsonlite read_json
#' @export
#'
#' @examples \dontrun{retrieve_data()}
retrieve_data <- function(api_endpoint_url = "https://api.dawum.de/") {
  obj <- jsonlite::read_json(api_endpoint_url)
  obj
}
