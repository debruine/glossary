#' Set/get global glossary options
#'
#' Global glossary options are used, for example, to set the default separator for cell names.
#'
#' @param ... One of three: (1) nothing, then returns all options as a list; (2) a name of an option element, then returns its value; (3) a name-value pair which sets the corresponding option to the new value (and returns nothing)
#'
#' @return a list of options, values of an option, or nothing
#' @export
#'
#' @examples
#'
#' glossary_options() # see all options
#'
#' glossary_options("path") # see value of glossary.path
#'
#' \dontrun{
#' # changes default path
#' glossary_options(path = "gloss.yml")
#'
#' # changes back to default
#' glossary_options(path = "include/glossary.yml")
#' }
glossary_options <- function (...) {
  # code from afex::afex_options
  dots <- list(...)
  if (length(dots) == 0) {
    # get all glossary options
    op <- options()
    glossary_op <- op[grepl("^glossary.", names(op))]
    names(glossary_op) <- sub("^glossary.", "", names(glossary_op))
    return(glossary_op)
  } else if (!is.null(names(dots))) {
    # dots have names, so set glossary options
    newop <- dots
    names(newop) <- paste0("glossary.", names(newop))
    options(newop)
  } else if (is.null(names(dots))) {
    # dots don't have names, so get glossary options
    opnames <- paste0("glossary.", unlist(dots))
    getop <- lapply(opnames, getOption)
    if (length(opnames) == 1) {
      getop <- getop[[1]]
    } else {
      names(getop) <- unlist(dots)
    }
    return(getop)
  } else {
    warning("Unsupported command to glossary_options(), nothing done.",
            call. = FALSE)
  }
}
