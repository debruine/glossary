test_that("style", {
  path <- system.file("glossary.css", package = "glossary")
  css <- readLines(path)
  exp <- paste(css, collapse = "\n") |>
    paste0("<style>\n", x = _, "\n</style>\n")
  test <- expect_output( glossary_style() )
  expect_equal(test, exp)

  test <- expect_output(
    glossary_style(color = "red",
                   text_decoration = "none",
                   def_bg = "white",
                   def_color = "black")
  )
  exp <- "a.glossary {\n  color: red;\n  text-decoration: none;"
  expect_true(grepl(exp, test, fixed = TRUE))

  exp <- "background-color: white;\n  color: black;"
  expect_true(grepl(exp, test, fixed = TRUE))

  exp <- "border-color: white transparent transparent transparent;"
  expect_true(grepl(exp, test, fixed = TRUE))
})
