test_that("x", {
  gloss <- tempfile(fileext = ".yml")
  on.exit(unlink(gloss))
  expect_message(glossary_path(gloss))

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
})
