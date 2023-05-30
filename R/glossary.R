#' Display glossary entry
#'
#' @description
#' Display a glossary term with an optional popup of the definition, and add the term to the table created by \code{\link{glossary_table}}. This function is mainly meant to be used via inline R in R Markdown or quarto documents, e.g.:
#'
#' `` `r glossary("Alpha")` `` does not always have to equal .05.
#'
#' @details
#'
#' If the path is set to "psyteachr", the glossary term will link to the [PsyTeachR glossary](https://psyteachr.github.io/glossary/). Set `show = "def"` to just show the definition.
#'
#' @param term The glossary term to link to, can contain spaces
#' @param display The text to display (if different than the term)
#' @param def The short definition to display on hover and in the glossary table; if NULL, this will be looked up from the file in the `path` argument
#' @param add_to_table whether to add to the table created by \code{\link{glossary_table}}
#' @param show whether to show the term or just the definition
#' @param popup whether to show the popup on "click" or "hover" (or "none"); set default with \code{\link{glossary_popup}}
#' @param path the path to the glossary file, or NULL for local definitions; set default with \code{\link{glossary_path}}
#'
#' @return character string
#' @export
#'
#' @examples
#' # set glossary path to example file
#' path <- system.file("glossary.yml", package = "glossary")
#' glossary_path(path)
#'
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
                     popup = glossary_popup(),
                     path = glossary_path()) {
  if (!is.character(term)) stop("The term must be a character string")
  force(display) # needs to be used before the term is changed
  show <- match.arg(show)
  popup <- match.arg(popup, c("click", "hover", "none"))
  href <- ""

  # look up definition from file
  if (is.null(def) & !is.null(path)) {
    if (path == "psyteachr") {
      lcterm <- gsub(" ", "-", tolower(term), fixed = TRUE)
      first_letter <- substr(lcterm, 1, 1)
      url <- paste0("https://psyteachr.github.io/glossary/", first_letter)
      href <- paste0(" href='", url, "#", lcterm, "' target='_blank'")

      hash <- paste0("#", lcterm, ".level2")
      def <- tryCatch({
        the_html <- xml2::read_html(url)
        the_node <- rvest::html_node(the_html, hash)
        if (is.na(the_node)) stop("No PsyTeachR glossary entry for ", lcterm)
        the_dfn <- rvest::html_node(the_node, "dfn")
        the_text <- rvest::html_text(the_dfn)
        the_def <- gsub("\'", "&#39;", the_text)
        if (is.na(the_def)) stop("No PsyTeachR glossary shortdef for ", lcterm)
        the_def
      },
      error = function(e) {
        warning(e, call. = FALSE)
        return("")
      })
    } else {
      if (!file.exists(path)) {
        # look up definition from glossary file if not given
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

  # set text
  if (show == "def") {
    text <- def # just show the definition
  } else if (show == "term" & popup == "none") {
    text <- paste0("<a class='glossary'>", display, "</a>") # just show the term
  } else {
    # show the term with the tooltip
    cleandef <- markdown::markdownToHTML(
      text = def,
      options = c("smartypants",
                  "fragment_only")
    )
    cleandef <- gsub("</li>\\s*<li>", "; ", cleandef)
    cleandef <- gsub("<.*?>", "", cleandef)
    cleandef <- gsub("(\n\r?)+", " | ", trimws(cleandef))

    if (popup == "hover") {
      text <- paste0("<a", href, " class='glossary' title='", cleandef, "'>",
                     display, "</a>")
    } else if (popup == "click") {
      text <- paste0("<a", href, " class='glossary'>", display,
                     "<span class='def'>", cleandef,"</span></a>")
    }
  }

  return(text)
}


