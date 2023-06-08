;extends
(define_directive
  [
    "define"
    "endef"
  ] @keyword.function
)

(define_directive
  name: (word) @variable @function
)

(
  (recipe_line) @punctuation.special
  (#lua-match? @punctuation.special "^@")
)

(rule
  (targets
    (word) @label
  )
)

(rule
  (targets
    (word) @keyword
    (#any-of? @keyword
      ".DEFAULT"
      ".SUFFIXES"
      ".DEFAULT"
      ".DELETE_ON_ERROR"
      ".EXPORT_ALL_VARIABLES"
      ".IGNORE"
      ".INTERMEDIATE"
      ".LOW_RESOLUTION_TIME"
      ".NOTPARALLEL"
      ".ONESHELL"
      ".PHONY"
      ".POSIX"
      ".PRECIOUS"
      ".SECONDARY"
      ".SECONDEXPANSION"
      ".SILENT"
      ".SUFFIXES"
    )
  )
)
