#' Load all definitions
#'
#' Load all the definitions in a glossary file, usually for subsequent display using \code{\link{glossary_table}}
#'
#' @param path The path to the glossary file; set default with \code{\link{glossary_path}}
#'
#' @return NULL; Called for side effects
#' @export
#'
#' @examples
#' demo_glossary <- system.file("glossary.yml", package = "glossary")
#' glossary_load_all(demo_glossary)
#'
#' glossary_table(FALSE) # get table as a data frame
glossary_load_all <- function(path = glossary_path()) {
  if (tolower(path) == "psyteachr") {
    stop("Cannot load all from the psyteachr glossary, please specify a path to a YAML glossary file")
  } else if (!file.exists(path)) {
    # look up definition from glossary file if not given
    stop("The file ", path, " does not exist")
  }

  gloss <- yaml::read_yaml(path)
  glossary_add_to_table(gloss)

  invisible(NULL)
}
