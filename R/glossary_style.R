#' Create CSS styles for glossary entries
#'
#' Set the color and style of the linked in-text terms and pop-up definitions. Colors should be a valid CSS color string, such as "purple" or "#FF0000".
#'
#' @param color Text color of the linked term
#' @param text_decoration Style of the linked term; a valid CSS text-decoration string, such as "none", underline" or "red wavy underline"
#' @param def_bg Background color of the definition pop-up
#' @param def_color Text color of the definition pop-up
#' @param inline If TRUE, includes <style> tags and uses cat() to output the style, if FALSE, omits tags and returns text
#'
#' @return A CSS style string
#' @export
#'
#' @examples
#' glossary_style("#003366", "underline")
glossary_style <- function(color = "purple",
                           text_decoration = "underline",
                           def_bg = "#333",
                           def_color = "white",
                           inline = TRUE) {
  style <- paste0(
"a.glossary {
  color: ", color, ";
  text-decoration: ", text_decoration, ";
  cursor: help;
  position: relative;
}

/* only needed for popup = \"click\" */
/* popup-definition */
a.glossary .def {
  display: none;
  position: absolute;
  z-index: 1;
  width: 200px;
  bottom: 100%;
  left: 50%;
  margin-left: -100px;
  background-color: ", def_bg, ";
  color: ", def_color, ";
  padding: 5px;
  border-radius: 6px;
}
/* show on click */
a.glossary:active .def {
  display: inline-block;
}
/* triangle arrow */
a.glossary:active .def::after {
  content: ' ';
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: ", def_bg, " transparent transparent transparent;
}
")

  if (isTRUE(inline)) {
    style <- paste0("<style>\n", style, "</style>\n")
    cat(style)
    invisible(style)
  } else {
    # return style as text
    style
  }
}
