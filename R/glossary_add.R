#' Add a definition
#'
#' Write a term and definition to an existing glossary file.
#'
#' @param term The term to define
#' @param def The definition to add
#' @param path the path to the glossary file; set default with \code{\link{glossary_path}}
#' @param replace Whether to replace an existing definition
#'
#' @return NULL; Called for side effects
#' @export
#'
#' @examples
#' # make a new glossary file
#' path <- tempfile("glossary", fileext = ".yml")
#' glossary_path(path, create = TRUE)
#'
#' # add an entry for "joins"
#' glossary_add("joins", "Ways to combine data from two tables")
#'
#' # now you can access the definition
#' glossary("joins")
glossary_add <- function(term,
                         def,
                         path = glossary_path(),
                         replace = FALSE) {
  if (is.null(path)) {
    stop("The path must be an existing YAML file")
  } else if (!file.exists(path)) {
    stop("The file ", path, " does not exist")
  }
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
  gloss[[term]] <- def
  write_yaml(gloss, path)

  invisible(NULL)
}


write_yaml <- function(x, file) {
  indent <- gsub("\n", "\n  ", x)
  x2 <- paste0(names(x), ": |\n  ", indent)
  yaml <- paste(x2, collapse = "\n")
  write(yaml, file)
}
