test_that("exists", {
  expect_type(add_to_quarto, "closure")

  expect_error(add_to_quarto("notreal"), "The directory notreal does not exist")

  # set up demo book project directory
  quarto_dir <- file.path(tempdir(), "quarto_demo")
  if (dir.exists(quarto_dir)) unlink(quarto_dir, TRUE)
  dir.create(quarto_dir, FALSE)
  quarto_yml <- file.path(quarto_dir, "_quarto.yml")
  write("format:\n  html:\n    css: style.css\n", quarto_yml)

  # set up project first time - all defaults
  msg <- expect_message(add_to_quarto(quarto_dir))
  files <- list.files(quarto_dir)
  exp_files <- c("_quarto.yml", "_setup.R", "glossary.css", "glossary.yml")
  expect_equal(files, exp_files)

  rprof_txt <- readLines(file.path(quarto_dir, ".Rprofile"))
  test <- grep("source(\"_setup.R\")", rprof_txt, fixed = TRUE)
  expect_equal(test, 2)

  setup_txt <- readLines(file.path(quarto_dir, "_setup.R"))
  test <- grep("library(glossary)", setup_txt, fixed = TRUE)
  expect_equal(test, 2)

  # check on already set up project
  msg <- expect_message(add_to_quarto(quarto_dir))
  files <- list.files(quarto_dir)
  expect_equal(files, exp_files)

  # doesn't duplicate
  rprof_txt <- readLines(file.path(quarto_dir, ".Rprofile"))
  test <- grep("source(\"_setup.R\")", rprof_txt, fixed = TRUE)
  expect_equal(test, 2)

  setup_txt <- readLines(file.path(quarto_dir, "_setup.R"))
  test <- grep("library(glossary)", setup_txt, fixed = TRUE)
  expect_equal(test, 2)
})
