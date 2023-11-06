test_that("errors", {
  expect_type(glossary, "closure")

  # set up path to example glossary file
  path <- system.file("glossary.yml", package = "glossary")
  glossary_path(path)

  expect_error(glossary(path = NULL),
               "argument \"term\" is missing, with no default",
               fixed = TRUE)

  expect_error(glossary(1, path = NULL),
               "The term must be a character string",
               fixed = TRUE)

  expect_warning(glossary("hi"),
                 "The definition for \"hi\" was not found in")

  expect_error( glossary("alpha", path = "noexist.yml"),
                "The file noexist.yml does not exist",
                fixed = TRUE)
})

test_that("no path, click", {
  glossary_reset()
  glossary_path(NULL)
  glossary_popup("click")

  expect_warning( test <- glossary("hi") )
  exp <- "<a class='glossary'>hi<span class='def'></span></a>"
  expect_equal(test, exp)

  # added to table
  test <- glossary_options("table")
  exp <- list(hi = "")
  expect_equal(test, exp)

  # set def inline
  test <- glossary("hi", def = "greeting")
  exp <- "<a class='glossary'>hi<span class='def'>greeting</span></a>"
  expect_equal(test, exp)

  # definition updated
  test <- glossary_options("table")
  exp <- list(hi = "greeting")
  expect_equal(test, exp)

  test <- glossary("hi", def = "greeting", show = "def")
  exp <- "greeting"
  expect_equal(test, exp)

  # different display
  test <- glossary("lo", def = "direction", display = "LO")
  exp <- "<a class='glossary'>LO<span class='def'>direction</span></a>"
  expect_equal(test, exp)

  # don't add to table
  glossary("no", def = "Not yes", add_to_table = FALSE)
  test <- glossary_options("table")
  exp <- list(hi = "greeting", lo = "direction")
  expect_equal(test, exp)
})


test_that("path, click", {
  glossary_reset()
  glossary_popup("click")

  # set up path to example glossary file
  path <- system.file("glossary.yml", package = "glossary")
  glossary_options(path = path)

  # basic
  test <- glossary("alpha")
  exp <- "<a class='glossary'>alpha<span class='def'>The threshold chosen in Neyman-Pearson hypothesis testing to distinguish test results that lead to the decision to reject the null hypothesis, or not, based on the desired upper bound of the Type 1 error rate. An alpha level of 5% is most commonly used, but other alpha levels can be used as long as they are determined and preregistered by the researcher before the data is analyzed.</span></a>"
  expect_equal(test, exp)

  # secondary definition
  test <- glossary("alpha (graphics)")
  exp <- "<a class='glossary'>alpha (graphics)<span class='def'>A value between 0 and 1 used to control the levels of transparency in a plot</span></a>"
  expect_equal(test, exp)

  # non-matching case
  test <- glossary("Alpha")
  exp <- "<a class='glossary'>Alpha<span class='def'>The threshold chosen in Neyman-Pearson hypothesis testing to distinguish test results that lead to the decision to reject the null hypothesis, or not, based on the desired upper bound of the Type 1 error rate. An alpha level of 5% is most commonly used, but other alpha levels can be used as long as they are determined and preregistered by the researcher before the data is analyzed.</span></a>"
  expect_equal(test, exp)

})


test_that("no path, hover", {
  glossary_reset()
  glossary_path(NULL)
  glossary_popup("hover")

  expect_warning( test <- glossary("hi") )
  exp <- "<a class='glossary' title=''>hi</a>"
  expect_equal(test, exp)

  # added to table
  test <- glossary_options("table")
  exp <- list(hi = "")
  expect_equal(test, exp)

  # set def inline
  test <- glossary("hi", def = "greeting")
  exp <- "<a class='glossary' title='greeting'>hi</a>"
  expect_equal(test, exp)

  # definition updated
  test <- glossary_options("table")
  exp <- list(hi = "greeting")
  expect_equal(test, exp)

  test <- glossary("hi", def = "greeting", show = "def")
  exp <- "greeting"
  expect_equal(test, exp)

  # different display
  test <- glossary("lo", def = "direction", display = "LO")
  exp <- "<a class='glossary' title='direction'>LO</a>"
  expect_equal(test, exp)

  # don't add to table
  glossary("no", def = "Not yes", add_to_table = FALSE)
  test <- glossary_options("table")
  exp <- list(hi = "greeting", lo = "direction")
  expect_equal(test, exp)
})


test_that("path, hover", {
  glossary_reset()
  glossary_popup("hover")

  # set up path to example glossary file
  path <- system.file("glossary.yml", package = "glossary")
  glossary_options(path = path)

  # basic
  test <- glossary("alpha")
  exp <- "<a class='glossary' title='The threshold chosen in Neyman-Pearson hypothesis testing to distinguish test results that lead to the decision to reject the null hypothesis, or not, based on the desired upper bound of the Type 1 error rate. An alpha level of 5% is most commonly used, but other alpha levels can be used as long as they are determined and preregistered by the researcher before the data is analyzed.'>alpha</a>"
  expect_equal(test, exp)

  # non-matching case
  test <- glossary("Alpha")
  exp <- "<a class='glossary' title='The threshold chosen in Neyman-Pearson hypothesis testing to distinguish test results that lead to the decision to reject the null hypothesis, or not, based on the desired upper bound of the Type 1 error rate. An alpha level of 5% is most commonly used, but other alpha levels can be used as long as they are determined and preregistered by the researcher before the data is analyzed.'>Alpha</a>"
  expect_equal(test, exp)

})

test_that("tricky entries", {
  glossary_popup("hover")

  # set up path to example glossary file
  path <- system.file("glossary.yml", package = "glossary")
  glossary_options(path = path)

  # missing entry
  expect_warning(test <- glossary("no"))
  exp <- "<a class='glossary' title=''>no</a>"
  expect_equal(test, exp)

  # entry with single quotes
  test <- glossary("effect size")
  test <- gsub("‘", "&#39;", test) # differs between runs ?
  test <- gsub("’", "&#39;", test)
  exp <- "<a class='glossary' title='&#39;quantitative reflection of the magnitude of some phenomenon that is used for the purpose of addressing a question of interest&#39; (Kelley &amp; Preacher, 2012)'>effect size</a>"
  expect_equal(test, exp)
})

test_that("psyteachr", {
  glossary_reset()
  glossary_popup("click")
  glossary_path("psyteachr")

  skip_if_offline(host = "psyteachr.github.io")
  test <- glossary("alpha")
  exp <- "<a href='https://psyteachr.github.io/glossary/a#alpha' target='_blank' class='glossary'>alpha<span class='def'>(stats) The cutoff value for making a decision to reject the null hypothesis; (graphics) A value between 0 and 1 used to control the levels of transparency in a plot</span></a>"
  expect_equal(test, exp)
})
