## set default options for glossary_options:
.onLoad <- function(libname, pkgname) {
  op <- options()
  op.glossary <- list(
    glossary.table = list(),
    glossary.path = NULL,
    glossary.popup = "click"
  )
  toset <- !(names(op.glossary) %in% names(op))
  if(any(toset)) options(op.glossary[toset])

  invisible()
}


is_latex <- function() {
  pandocto <- knitr::opts_knit$get("rmarkdown.pandoc.to")
  !is.null(pandocto) && pandocto == "latex"
}
