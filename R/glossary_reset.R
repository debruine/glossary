#' Reset glossary table
#'
#' Resets the list .myglossary in the parent environment that collects glossary entries for the table
#'
#' @return NULL
#' @export
#'
#' @examples
#' glossary_reset()
#'
glossary_reset <- function() {
  glossary_options(table = list())
}

