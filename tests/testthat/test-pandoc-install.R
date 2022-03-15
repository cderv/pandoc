# This file currently only works on CI where the environment is cleaned at each run.
# This is because the order of installation matters (e.g latest version results)
# Locally, it can conflict with the user's install folder pandoc_locate(NULL)
# This may require a mocking mechanism.
# For now it is useful to test that everything is working on different OS.

.get_assets_info <- function(os, arch) {
  versions <- suppressMessages(pandoc_available_releases())
  map(versions, ~ {
    tryCatch(pandoc_release_asset(.x, os = os, arch = arch),
      error = function(e) list(version = .x, url = NULL, error = e$message)
    )
  })
}

expect_pandoc_installed <- function(version) {
  install_dir <- suppressWarnings(pandoc_locate(version))
  if (!is.null(install_dir)) fs::dir_delete(install_dir)
  install_dir <- suppressMessages(pandoc_install(version))
  bin <- fs::path(install_dir, "pandoc",
    ext = ifelse(pandoc_os() == "windows", "exe", "")
  )
  expect_true(fs::file_exists(bin))
}

skip_on_cran()
skip_if_offline()

test_that("Release information are cached - fetch Github", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(is.na(Sys.getenv("PANDOC_CACHE_GITHUB", NA_character_)))
  # don't use specific file cache for this test
  withr::local_envvar(list(PANDOC_CACHE_GITHUB = NA))
  # clean cached values
  rlang::env_unbind(the, "pandoc_releases")
  # with message Fetching
  expect_snapshot(x <- pandoc_releases())
  # without message Fetching
  expect_snapshot(x <- pandoc_releases())
})

test_that("Release information are cached - cached file", {
  skip_on_cran()
  # only run when specific file cached is set
  skip_if(is.na(Sys.getenv("PANDOC_CACHE_GITHUB", NA_character_)))
  # clean cached values
  rlang::env_unbind(the, "pandoc_releases")
  # Use specific file cached
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
  pandoc_223 <- keep(assets, ~ .x$version == "2.2.3")[[1]]
  expect_match(pandoc_223$error, "regression")
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

test_that("No versions are installed", {
  skip_on_cran()
  # clean state
  walk(pandoc_installed_versions(), pandoc_uninstall)
  expect_null(pandoc_installed_versions())
  expect_null(pandoc_installed_latest())
  expect_true(the$active_version %in% c("", the$external_versions))
})

test_that("Pandoc nightly can be installed and ran", {
  skip_on_cran()
  skip_if_offline()
  expect_pandoc_installed("nightly")
  time <- fs::file_info(pandoc_locate("nightly"))$modification_time
  expect_message(expect_message(pandoc_install("nightly")), "already installed", fixed = TRUE)
  # installed version is working
  expect_error(pandoc_version("nightly"), NA)
})

test_that("Pandoc specific release can be installed and ran", {
  skip_on_cran()
  skip_if_offline()
  expect_pandoc_installed("2.11.4")
  expect_snapshot(expect_null(pandoc_install("2.11.4")))
  expect_identical(
    suppressMessages(pandoc_install("2.11.4", force = TRUE)),
    pandoc_locate("2.11.4")
  )
  # installed version is working
  expect_equal(pandoc_version("2.11.4"), numeric_version("2.11.4"))
  # does not exist
  expect_error(pandoc_install("2.2.3"))
})

test_that("`pandoc_locate()` does not work with external pandoc", {
  skip_on_cran()
  expect_error(pandoc_locate("rstudio"), "pandoc_bin")
  expect_error(pandoc_locate("system"), "pandoc_bin")
})

test_that("pandoc-citeproc is correctly placed in root folder", {
  skip_on_cran()
  skip_if_offline()
  # Before Pandoc 2.11, pandoc-citeproc is also shipped
  expect_pandoc_installed("2.7.3")
  bin <- fs::path(pandoc_locate("2.7.3"), "pandoc-citeproc",
    ext = ifelse(pandoc_os() == "windows", "exe", "")
  )
  expect_true(fs::file_exists(bin))
})

test_that("Installed versions can be listed", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  suppressMessages(pandoc_install("2.7.3"))
  suppressMessages(pandoc_install("nightly"))
  expect_equal(pandoc_installed_versions(), c("nightly", "2.11.4", "2.7.3"))
})

test_that("Most recent version installed can be identified", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  suppressMessages(pandoc_install("2.7.3"))
  expect_equal(pandoc_installed_latest(), "2.11.4")
})

test_that("Is a version installed ?", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  expect_true(pandoc_is_installed("2.11.4"), c("2.11.4"))
})

test_that("Pandoc release can be uninstall", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("nightly"))
  expect_true(pandoc_uninstall("nightly"))
  expect_false(fs::dir_exists(pandoc_home("nigthly")))
  expect_equal(pandoc_installed_versions(), c("2.11.4", "2.7.3"))
})

test_that("Pandoc release can be uninstall", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  suppressMessages(pandoc_install("2.7.3"))
  the$active_version <- "2.11.4"
  expect_true(pandoc_uninstall("2.11.4"))
  expect_equal(the$active_version, pandoc_installed_latest())
  expect_true(pandoc_uninstall("2.7.3"))
  expect_equal(the$active_version, "")
})

test_that("Pandoc latest release can be installed", {
  skip_on_cran()
  skip_if_offline()
  expect_pandoc_installed("latest")
  expect_message(expect_message(pandoc_update()), "already installed", fixed = TRUE)
})
