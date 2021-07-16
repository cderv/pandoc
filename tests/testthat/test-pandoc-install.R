.get_assets_info <- function(os, arch) {
  versions <- suppressMessages(pandoc_available_versions())
  map(versions, ~ {
    tryCatch(pandoc_release_asset(.x, os = os, arch = arch),
             error = function(e) list(version = .x, url = NULL, error = e$message))
  })
}

expect_pandoc_installed <- function(version) {
  install_dir <- pandoc_home_dir(version)
  if (!is.null(install_dir)) fs::dir_delete(install_dir)
  install_dir <- suppressMessages(pandoc_install(version))
  bin <- paste0("pandoc", if (pandoc_os() == "windows") ".exe")
  expect_true(fs::file_exists(fs::path(install_dir, bin)))
}

test_that("Release information are cached", {
  # clean cache
  rlang::env_bind(pandocenv, pandoc_releases = rlang::zap())
  # with message Fetching
  expect_snapshot(x <- pandoc_releases())
  # without message Fetching
  expect_snapshot(x <- pandoc_releases())
})

test_that("Can retrieve assets' informations", {
  skip_on_cran()
  expect_identical(
    pandoc_release_asset("2.11.4", "windows", "x86_64"),
    list(version = "2.11.4", url = "https://github.com/jgm/pandoc/releases/download/2.11.4/pandoc-2.11.4-windows-x86_64.zip")
  )

  expect_error(pandoc_release_asset("1.2", "windows", "x86_64"), "can't be found", fixed = TRUE)
  expect_error(pandoc_release_asset("1.19.2", "linux", "amd64"), "above 2.0.3", fixed = TRUE)
})

test_that("Assets are correctly found on windows", {
  skip_on_cran()
  skip_if_offline()
  assets <- .get_assets_info("windows", "x86_64")
  pandoc_2.2.3 <- keep(assets, ~ .x$version == "2.2.3")[[1]]
  expect_match(pandoc_2.2.3$error, "regression")
  walk(discard(assets, ~ .x$version == "2.2.3"), ~ {
    asset_url <- .x[["url"]]
    expect_match(asset_url, "https://github.com/jgm/pandoc/releases/download", fixed = TRUE)
  })
})

test_that("Assets are correctly found on linux amd64", {
  skip_on_cran()
  skip_if_offline()
  assets <- .get_assets_info("linux", "amd64")
  pandoc_2.2.3 <- keep(assets, ~ .x$version == "2.2.3")[[1]]
  expect_match(pandoc_2.2.3$error, "regression")
  walk(discard(assets, ~ .x$version == "2.2.3"), ~ {
    asset_url <- .x[["url"]]
    expect_match(asset_url, "https://github.com/jgm/pandoc/releases/download", fixed = TRUE)
  })
})

test_that("Assets are correctly found on linux arm64", {
  skip_on_cran()
  skip_if_offline()
  assets <- .get_assets_info("linux", "arm64")
  errors <- keep(assets, ~ numeric_version(.x$version) <= "2.12")
  walk(errors, ~ {
    expect_match(.x$error, "available for 2.12 and above only", fixed = TRUE)
  })
  walk(discard(assets, ~ numeric_version(.x$version) <= "2.12"), ~ {
    asset_url <- .x[["url"]]
    expect_match(asset_url, "https://github.com/jgm/pandoc/releases/download", fixed = TRUE)
  })
})

test_that("Assets are correctly found on linux arm64", {
  skip_on_cran()
  skip_if_offline()
  assets <- .get_assets_info("macOS", NULL)
  pandoc_2.2.3 <- keep(assets, ~ .x$version == "2.2.3")[[1]]
  expect_match(pandoc_2.2.3$error, "regression")
  walk(discard(assets, ~ .x$version == "2.2.3"), ~ {
    asset_url <- .x[["url"]]
    expect_match(asset_url, "https://github.com/jgm/pandoc/releases/download", fixed = TRUE)
  })
})

test_that("Pandoc nightly can be installed", {
  skip_on_cran()
  skip_if_offline()
  expect_pandoc_installed("nightly")
  time <- fs::file_info(pandoc_home_dir("nightly"))$modification_time
  expect_message(expect_message(pandoc_install("nightly")), "already installed", fixed = TRUE)
})

test_that("Pandoc specific release can be installed", {
  skip_on_cran()
  skip_if_offline()
  expect_pandoc_installed("2.11.4")
  expect_message(expect_null(pandoc_install("2.11.4")), "already installed", fixed = TRUE)
  expect_identical(
    suppressMessages(pandoc_install("2.11.4", force = TRUE)),
    pandoc_home_dir("2.11.4")
  )
  expect_error(pandoc_install("2.2.3"))
})

test_that("Pandoc latest release can be installed", {
  skip_on_cran()
  skip_if_offline()
  expect_pandoc_installed("latest")
})

test_that("Pandoc release can be uninstall", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  expect_true(pandoc_uninstall("2.11.4"))
  expect_false(fs::dir_exists(pandoc_home("2.11.4")))
})
