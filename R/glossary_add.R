#' Add a definition to the glossary file
#'
#' @param term The term to define
#' @param definition The definition to add
#' @param path The path of the glossary file
#' @param replace Whether to replace an existing definition
#'
#' @return NULL
#' @export
#'
glossary_add <- function(term,
                         definition,
                         path = glossary_path(),
                         replace = FALSE) {
  gloss <- yaml::read_yaml(path)
  index <- grep(term, names(gloss), ignore.case = TRUE)

  # term exists and not set to replace
  if (length(index) & !replace) {
    term <- names(gloss)[index]
    stop("The term \"", term,
         "\" already exists and is defined as \"",
         gloss[index],
         "\"\nSet replace = TRUE to replace")
  }

  # add term
  gloss[[term]] <- definition
  yaml::write_yaml(gloss, path)

  invisible(NULL)
}
