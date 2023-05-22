#' Create CSS styles for glossary entries
#'
#' @param color A valid CSS colour string, such as "purple" or "#FF0000"
#' @param text_decoration A valid CSS text-decoration string, such as "underline" or "red wavy underline"
#'
#' @return A CSS style string
#' @export
#'
#' @examples
#' glossary_style("#003366", "underline")
glossary_style <- function(color = "purple", text_decoration = "none") {
  style <- paste0(
    "<style>\n",
    "a.glossary {\n",
    "  color: ", color, ";\n",
    "  text-decoration: ", text_decoration, ";\n",
    "  cursor: help;\n",
    "}\n",
    "</style>\n\n"
  )

  cat(style)
}
