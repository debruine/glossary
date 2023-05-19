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
  pandocto <- knitr::opts_knit$get("rmarkdown.pandoc.to")
  is_latex <- !is.null(pandocto) && pandocto == "latex"

  the_list <- data.frame(
    term = term,
    definition = unlist(glossary)
  )

  if (is.null(term)) {
    data.frame()
  } else if (as_kable) {
    k <- kableExtra::kable(the_list[order(term),],
                           escape = is_latex,
                           row.names = FALSE)
    kableExtra::kable_styling(k)
  } else {
    the_list[order(term),]
  }
}
