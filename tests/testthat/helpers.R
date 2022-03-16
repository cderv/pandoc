# run first
message(">> pandoc_home(): ", pandoc_home())
message(">> Cached found: ", fs::file_exists(Sys.getenv("PANDOC_CACHE_GITHUB", NA_character_)))
