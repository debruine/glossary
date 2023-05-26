test_that("reset", {
  # reset the table
  glossary_reset()
  table <- glossary_options("table")
  expect_equal(list(), table)

  # add a definition to the table
  glossary("x", def = "y", path = NULL)
  table <- glossary_options("table")
  expect_equal(list(x = "y"), table)

  # reset and check it empties
  glossary_reset()
  table <- glossary_options("table")
  expect_equal(list(), table)
})


test_that("path", {
  # psyteachr
  glossary_path("psyteachr")
  path <- glossary_path()
  expect_equal(path, "psyteachr")
  expect_false(file.exists("psyteachr"))

  # NULL path
  glossary_path(NULL)
  path <- glossary_path()
  expect_null(path)

  # make new file
  unlink("new.yml")
  on.exit(unlink("new.yml"))
  expect_error(
    glossary_path("new.yml"),
    "The file new.yml does not exist",
    fixed = TRUE)
  expect_message(
    glossary_path("new.yml", TRUE),
    "new.yml did not exist; it has been created",
    fixed = TRUE)
  path <- glossary_path()
  expect_equal("new.yml", path)
  expect_true(file.exists("new.yml"))

  # make new file in new directory
  unlink("newdir", TRUE, TRUE)
  on.exit(unlink("newdir", TRUE, TRUE))
  newpath <- "newdir/new.yml"
  msg <- paste0("The file ", newpath, " does not exist")
  expect_error(glossary_path(newpath), msg, fixed = TRUE)

  msg <- paste0(newpath, " did not exist; it has been created")
  expect_message(glossary_path(newpath, TRUE), msg, fixed = TRUE)
  path <- glossary_path()
  expect_equal(newpath, path)
  expect_true(file.exists(newpath))
})

test_that("popup", {
  glossary_path(NULL)

  glossary_popup("hover")
  expect_equal(glossary_popup(), "hover")
  test <- glossary("x", def = "y")
  exp <- "<a class='glossary' title='y'>x</a>"
  expect_equal(test, exp)

  glossary_popup("click")
  expect_equal(glossary_popup(), "click")
  test <- glossary("x", def = "y")
  exp <- "<a class='glossary'>x<span class='def'>y</span></a>"
  expect_equal(test, exp)

  glossary_popup("none")
  expect_equal(glossary_popup(), "none")
  test <- glossary("x", def = "y")
  exp <- "<a class='glossary'>x</a>"
  expect_equal(test, exp)

  expect_error( glossary_popup("other") )
  expect_equal(glossary_popup(), "none")
})

test_that("options", {
  # set options
  glossary_reset()
  glossary_path("psyteachr")
  glossary_popup("none")

  # get all options as a list
  opts <- glossary_options()
  expect_true( is.list(opts) )
  expect_equal(opts$popup, "none")
  expect_equal(opts$table, list())
  expect_equal(opts$path, "psyteachr")

  # get individual options
  expect_equal(glossary_options("popup"), "none")
  expect_equal(glossary_options("table"), list())
  expect_equal(glossary_options("path"), "psyteachr")

  # set arbitrary options
  glossary_options(new = "hi")
  expect_equal(glossary_options("new"), "hi")
  expect_equal(options("glossary.new"),
               list("glossary.new" = "hi"))
})
