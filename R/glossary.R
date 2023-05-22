#' Display glossary entry
#'
#' @param term The glossary term to link to, can contain spaces
#' @param display The display (if different than the term)
#' @param def The short definition to display on hover and in the glossary table; if NULL, this will be looked up from the glossary.yml file
#' @param add_to_table whether to add to the table created by glossary_table()
#' @param show whether to show term with definition on hover (default), or just the term or just the definition
#' @param path the path to the glossary file
#'
#' @return string with the link and hover text
#' @export
#'
#' @examples
#' glossary("alpha")
#' glossary("alpha", "$\\alpha$")
#' glossary("alpha", def = "The first letter of the Greek alphabet")
#' glossary("alpha", show = "term")
#' glossary("alpha", show = "def")
glossary <- function(term,
                     display = term,
                     def = NULL,
                     add_to_table = TRUE,
                     show = c("term", "def"),
                     path = glossary_path()) {
  if (!is.character(term)) stop("The term must be a character string")
  force(display) # needs to be used before the term is changed

  if (is.null(def) & !is.null(path)) {
    # look up definition from glossary file if not given
    if (!file.exists(path)) {
      stop("The file ", path, " does not exist")
    }

    def <- tryCatch({
      gloss <- yaml::read_yaml(path)
      index <- grep(term, names(gloss), ignore.case = TRUE)
      if (length(index)) term <- names(gloss)[index]
      trimws(gloss[[index]])
    },
    error = function(e) {
      return("")
    })
  }

  ## definition checks
  if (length(def) == 0) def <- ""
  if (trimws(def) == "") {
    warning("The definition for \"", term,
            "\" was not found in ", path, call. = FALSE)
  }

  ## add to global glossary for this book
  if (add_to_table) {
    tbl <- glossary_options("table")
    tbl[term] <- def
    glossary_options(table = tbl)
  }

  if (all(show == "def")) {
    def # just show the definition
  } else if (all(show == "term")) {
    paste0("<a class='glossary'>", display, "</a>") # just show the term
  } else {
    # show the term with the tooltip
    cleandef <- markdown::markdownToHTML(
      text = def,
      options = c("smartypants",
                  "fragment_only")
    )
    cleandef <- gsub("<.*?>", "", cleandef)
    cleandef <- gsub("\n", " ", trimws(cleandef))

    paste0("<a class='glossary' title='", cleandef, "'>", display, "</a>")
  }
}


