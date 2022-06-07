# Use devmode locally when running test to avoid cluttering Pandoc install dir
if (!isTRUE(as.logical(Sys.getenv("CI")))) devmode(TRUE)
withr::defer(devmode(FALSE), teardown_env())

# Don't activate rmarkdown by default when using activation function
old_opts <- options(pandoc.activate_rmarkdown = FALSE)
withr::defer(options(old_opts), teardown_env())

# run first
message(">> pandoc_home(): ", pandoc_home())
message(">> Cached found: ", fs::file_exists(Sys.getenv("PANDOC_CACHE_GITHUB", NA_character_)))
message(">> R Markdown pandoc: ", paste0(the$rmarkdown_active_version$dir, "-", the$rmarkdown_active_version$version))
message(">> Active version: ", the$active_version)
