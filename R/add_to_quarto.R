#' Add glossary helper files to a quarto book
#'
#' Adds the necessary helper files to an existing quarto book project and
#' gives instructions to edit the _quarto.yml file accordingly.
#'
#' The _quarto.yml file is not edited for you because there is currently no way to do this that doesn't remove your formatting and comments from the file.
#'
#' Since quarto books render each chapter in a separate environment, it is helpful to have a pre-chapter script that does any common setup. The code below will be added to a new or existing pre-chapter script, and this script sourced in the .Rprofile for this project to allow for a persistent glossary. Set `script_path` to `FALSE` to handle this on your own.
#'
#' ```
#' library(glossary)
#' glossary_path("glossary.yml")
#' glossary_persistent(TRUE)
#' ```
#'
#' @param quarto_dir The base directory for your quarto project
#' @param css_path The relative path to the css file you want to append the glossary styles to (creates a new file if it doesn't exist), using the quarto_dir as a base directory
#' @param glossary_path The relative path to the glossary file, using the quarto_dir as a base directory; if this file does not exist, one will be created
#' @param script_path The relative path to a pre-chapter script, using the quarto_dir as a base directory; set to FALSE to omit this step
#' @return No return value, called for side effects.
#' @export
#'
add_to_quarto <- function(quarto_dir = ".",
                          css_path = "glossary.css",
                          glossary_path = "glossary.yml",
                          script_path = "_setup.R") {
  # check inputs
  if (!dir.exists(quarto_dir)) {
    stop("The directory ", quarto_dir, " does not exist")
  }

  cpath <- file.path(quarto_dir, css_path)
  gpath <- file.path(quarto_dir, glossary_path)
  qpath <- file.path(quarto_dir, "_quarto.yml")

  if (!file.exists(qpath)) {
    stop("The _quarto.yml file does not exist. Are you sure this directory contains a quarto book?")
  }

  # add or update helper files
  if (!file.exists(gpath)) {
    yml <- system.file("glossary.yml", package = "glossary")
    file.copy(yml, gpath)
  }

  # create or append css file
  write(glossary_style(inline = FALSE), cpath, append = TRUE)

  # add css file to _quarto
  quarto_yml <- yaml::read_yaml(qpath)
  css <- quarto_yml$format$html$css

  if (is.null(css)) {
    # add css entry
    message("Please edit your _quarto.yml file to add a link to the glossary css file like this:

format:
  html:
    css: ", css_path)
  } else if (!css_path %in% css) {
    # add css path to existing css
    css_files <- paste(c(css, css_path), collapse = ", ")
    message("Please edit your _quarto.yml file to add a link to the glossary css file like this:

format:
  html:
    css: [", css_files, "]")
  }

  # create or edit pre-render script
  if (!isFALSE(script_path)) {
    script_text <- paste0(
      "# glossary setup - persistent across chapters\n",
      "library(glossary)\n",
      "glossary_path(\"", glossary_path, "\")\n",
      "glossary_persistent(TRUE)\n"
    )
    spath <- file.path(quarto_dir, script_path)

    # check if it needs added
    add_script <- TRUE
    if (file.exists(spath)) {
      stxt <- paste(readLines(spath), collapse = "\n")
      found <- grep(script_text, stxt, fixed = TRUE)
      if (length(found) > 0) add_script <- FALSE
    }
    if (add_script) {
      write(script_text, spath, append = TRUE)
    }

    # source this in .Rprofile (if not already sourced)
    rpath <- file.path(quarto_dir, ".Rprofile")
    add_source <- TRUE

    if (file.exists(rpath)) {
      txt <- readLines(rpath)
      pattern <- paste0("source(\"", script_path, "\")")
      found <- grep(pattern, txt, fixed = TRUE)
      if (length(found) > 0) add_source <- FALSE
    }

    if (add_source) {
      rprofile_text <- paste0("\nsource(\"", script_path, "\") # pre-chapter setup\n")
      write(rprofile_text, rpath, append = TRUE)
    }
  }

  invisible(NULL)
}
