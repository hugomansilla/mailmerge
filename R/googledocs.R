#' Read a markdown file from google drive
#'
#' @param id Unique Google Drive identifier
#'
#' @return the imported document
#' @export
#' @importFrom googledrive drive_download
#'
mm_read_googledoc <- function(id){
  file <- download_googledoc(id)
  readLines(file) %>% 
      paste(collapse = "\n")
}

download_googledoc <- function(id, file){
  url <- glue::glue("https://drive.google.com/open?id={id}")
  template <- NA
  if (missing(file) || is.null(file)) {
    file <- tempfile(fileext = ".txt")
  }
  googledrive::drive_download(path = file, file = url, verbose = FALSE)
  invisible(file)
}



#' Parse the email template inside a markdown document on google drive.
#'
#' You can use this to construct the `message` argument of [mail_merge()].
#'
#' @inheritParams mm_read_googledoc
#' @inherit mm_read_message
#'
#' @export
#' 
#' @family parsing functions
#' 
#'
mm_read_message_googledoc <- function(id) {
  txt <- mm_read_googledoc(id = id)
  mm_read_message(txt = txt)
}



