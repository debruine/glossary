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
#' @examples
#' \dontrun{
#' # make a new glossary file
#' glossary_path("glossary.yml")
#'
#' glossary_add("joins", "Ways to combine data from two tables")
#'
#' }
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
  write_yaml(gloss, path)

  invisible(NULL)
}


write_yaml <- function(x, file) {
  indent <- gsub("\n", "\n  ", x)
  x2 <- paste0(names(x), ": |-\n  ", indent)
  yaml <- paste(x2, collapse = "\n")
  write(yaml, file)
}
