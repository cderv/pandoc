# Use devmode locally when running test to avoid cluttering Pandoc install dir
if (!isTRUE(as.logical(Sys.getenv("CI")))) devmode(TRUE)
withr::defer(devmode(FALSE), teardown_env())

# run first
message(">> pandoc_home(): ", pandoc_home())
message(">> Cached found: ", fs::file_exists(Sys.getenv("PANDOC_CACHE_GITHUB", NA_character_)))
