#' Display glossary table
#'
#' @param as_kable if the output should be a kableExtra table or a data frame
#'
#' @return kable table or data frame
#' @export
glossary_table <- function(as_kable = TRUE) {
  glossary <- glossary_options("table")
  if (is.null(glossary)) glossary <- list()

  term <- names(glossary)
  linked_term <- term
  pandocto <- knitr::opts_knit$get("rmarkdown.pandoc.to")
  is_latex <- !is.null(pandocto) && pandocto == "latex"

  # add links if a psyteachr glossary
  if (!is.null(glossary_path()) &&
      glossary_path() == "psyteachr") {
    lcterm <- gsub(" ", "-", tolower(term), fixed = TRUE)
    first_letter <- substr(lcterm, 1, 1)
    linked_term <- paste0("<a href='https://psyteachr.github.io/glossary/",
                   first_letter, "#", lcterm, "' target='_blank'>",
                   lcterm, "</a>")
  }

  if (is.null(term)) {
    data.frame()
  } else if (as_kable) {
    the_list <- data.frame(
      term = linked_term,
      definition = unlist(glossary)
    )

    k <- kableExtra::kable(the_list[order(term),],
                           escape = is_latex,
                           row.names = FALSE)
    kableExtra::kable_styling(k)
  } else {
    the_list <- data.frame(
      term = term,
      definition = unlist(glossary)
    )

    the_list[order(term),] # alphabetise
  }
}
