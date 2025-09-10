test_that("resolve_version()", {
  rlang::local_bindings(active_version = "nightly", .env = the)
  expect_equal(resolve_version("default"), "nightly")
  expect_equal(resolve_version("3.6.3"), "3.6.3")
  expect_equal(resolve_version("latest"), pandoc_installed_latest())
})

test_that("pandoc_feature_requirement() not met", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("3.6.3"))
  expect_true(pandoc_feature_requirement("2.8", version = "3.6.3"))
  expect_error(
    pandoc_feature_requirement("3.7.0", version = "3.6.3"),
    "`3.7.0` and above",
    fixed = TRUE
  )
})

test_that("on_*() helpers works as expected", {
  withr::with_envvar(list(TESTTHAT = "true"), expect_true(on_testthat()))
  withr::with_envvar(list(TESTTHAT = NA), expect_false(on_testthat()))
  withr::with_envvar(list(CI = TRUE), expect_true(on_ci()))
  withr::with_envvar(list(CI = FALSE), expect_false(on_ci()))
  withr::with_envvar(
    list("_R_CHECK_PACKAGE_NAME_" = "pandoc"),
    expect_true(on_rcmd_check())
  )
  withr::with_envvar(
    list("_R_CHECK_PACKAGE_NAME_" = ""),
    expect_false(on_rcmd_check())
  )
})

test_that("devmode() can change R option correctly", {
  withr::local_options(list(pandoc.devmode = NULL))
  expect_false(is_devmode())
  opts <- devmode()
  expect_true(is_devmode())
  withr::defer(devmode(opts$pandoc.devmode))
  devmode(FALSE)
  expect_false(is_devmode())
  devmode(TRUE)
  expect_true(is_devmode())
})
