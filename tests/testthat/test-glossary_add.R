test_that("x", {
  glossary_popup("hover")
  gloss <- tempfile(fileext = ".yml")
  on.exit(unlink(gloss))
  expect_message(glossary_path(gloss, TRUE))

  expect_error( glossary_add("a", "b", path = NULL) )
  expect_error( glossary_add("a", "b", path = "not_a_file.yml") )

  expect_warning(test <- glossary("new"))
  exp <- "<a class='glossary' title=''>new</a>"
  expect_equal(test, exp)

  glossary_add("new", "Not old")

  test <- glossary("new")
  exp <- "<a class='glossary' title='Not old'>new</a>"
  expect_equal(test, exp)

  # redefine existing definition
  expect_error( glossary_add("new", "Not ancient") )
  glossary_add("new", "Not ancient", replace = TRUE)

  test <- glossary("new")
  exp <- "<a class='glossary' title='Not ancient'>new</a>"
  expect_equal(test, exp)

  # markdown
  definition <- "This is a paragraph with a [link](https://url.com).

And another paragraph before a list:

* Item 1
* Item 2"
  glossary_add("html", definition)

  test <- glossary("html")
  exp <- "<a class='glossary' title='This is a paragraph with a link. | And another paragraph before a list: | Item 1; Item 2'>html</a>"
  expect_equal(test, exp)
})
