## set default options for glossary_options:
.onLoad <- function(libname, pkgname) {
  op <- options()
  op.glossary <- list(
    glossary.table = list(),
    glossary.path = "include/glossary.yml"
  )
  toset <- !(names(op.glossary) %in% names(op))
  if(any(toset)) options(op.glossary[toset])

  invisible()
}
