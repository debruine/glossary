#' Display glossary entry
#'
#' @param term The glossary term to link to, can contain spaces
#' @param display The display (if different than the term)
#' @param def The short definition to display on hover and in the glossary table; if NULL, this will be looked up from the glossary.yml file
#' @param add_to_table whether to add to the table created by glossary_table()
#' @param show_def whether to show the definition or just the term
#' @param path the path to the glossary file
#'
#' @return string with the link and hover text
#' @export
#'
#' @examples
#' glossary("alpha")
#' glossary("alpha", "$\\alpha$")
#' glossary("alpha", def = "The first letter of the Greek alphabet")
#' glossary("alpha", show_def = TRUE)
glossary <- function(term,
                     display = term,
                     def = NULL,
                     add_to_table = TRUE,
                     show_def = FALSE,
                     path = glossary_options("path")) {
  display # needs to be used before the term is changed

  if (is.null(def)) {
    # look up definition from glossary file if not given
    def <- tryCatch({
      gloss <- yaml::read_yaml(path)
      index <- grep(term, gloss, ignore.case = TRUE)
      if (length(index)) term <- names(gloss)[index]
      gloss[[index]]
    },
    error = function(e) {
      return("")
    })
  }

  ## add to global glossary for this book
  if (add_to_table) {
    tbl <- glossary_options("table")
    tbl[term] <- def
    glossary_options(table = tbl)
  }

  if (show_def) {
    def # just show the definition
  } else {
    # just add the tooltip and don't link to the definition webpage
    paste0("<a class='glossary' title='", def, "'>", display, "</a>")
  }
}


