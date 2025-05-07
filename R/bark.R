' Send Notification via Bark
#'
#' This function sends notifications to iOS devices using the Bark service.
#'
#' @param title Notification title
#' @param content Notification content
#' @param params Optional parameters list containing:
#'        \itemize{
#'          \item \code{badge}: Badge number (e.g. 1)
#'          \item \code{sound}: Sound (e.g. "alarm.caf")
#'          \item \code{isArchive}: Whether to archive ("1" or "0")
#'          \item \code{group}: Group name
#'          \item \code{icon}: Icon URL
#'          \item \code{url}: URL to open on click
#'        }
#' @param device_key Bark device key (full URL or key part). If NULL, uses default set by \code{set_bark_key()}
#' @return Invisibly returns TRUE if successful, FALSE otherwise
#' @export
#' @examples
#' \dontrun{
#' set_bark_key("your_device_key")
#' bark_notify("Test", "This is a test notification")
#' }
bark_notify <- function(title, content, params = list(), device_key = NULL) {
  if (is.null(device_key)) {
    device_key <- getOption("RemindR.bark_key")
    if (is.null(device_key)) {
      stop("No Bark device key provided and no default key set. Use set_bark_key() to set a default key.")
    }
  }
  
  if (!requireNamespace("httr", quietly = TRUE)) {
    stop("Please install the 'httr' package to use this function")
  }
  
  # Construct base URL
  base_url <- if (grepl("^http", device_key)) device_key else 
    paste0("https://api.day.app/", device_key)
  
  # URL encode title and content
  encoded_title <- utils::URLencode(title)
  encoded_content <- utils::URLencode(content)
  
  # Build request URL
  url <- paste0(base_url, "/", encoded_title, "/", encoded_content)
  
  # Add optional parameters
  if (length(params) > 0) {
    query_string <- paste(
      names(params), 
      unlist(params), 
      sep = "=", 
      collapse = "&"
    )
    url <- paste0(url, "?", query_string)
  }
  
  # Send GET request
  tryCatch({
    response <- httr::GET(url)
    
    if (response$status_code == 200) {
      message("Bark notification sent successfully")
      invisible(TRUE)
    } else {
      message(paste("Bark notification failed with status code:", response$status_code))
      invisible(FALSE)
    }
  }, error = function(e) {
    message(paste("Error sending Bark notification:", e$message))
    invisible(FALSE)
  })
}

#' Set Default Bark Device Key
#'
#' Sets the default Bark device key to be used by \code{bark_notify()}
#'
#' @param device_key Your Bark device key (full URL or key part)
#' @export
#' @examples
#' \dontrun{
#' set_bark_key("your_device_key")
#' }
set_bark_key <- function(device_key) {
  options(RemindR.bark_key = device_key)
  invisible(TRUE)
}

#' Get Current Bark Device Key
#'
#' Returns the currently set default Bark device key
#'
#' @return The currently set Bark device key
#' @export
#' @examples
#' \dontrun{
#' get_bark_key()
#' }
get_bark_key <- function() {
  getOption("RemindR.bark_key")
}