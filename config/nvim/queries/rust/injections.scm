;exntends
(macro_invocation
  (
    (identifier) @_regex_macro
    (#match? @_regex_macro "^(lazy_)?regex|regex_(captures|find|is_match|replace(_all)?)$")
  )
  (token_tree
    (raw_string_literal) @injection.content
  )
  (#set! injection.language "regex")
)

(macro_invocation
  (scoped_identifier
    path: (identifier) @_regex_path
    (#match? @_regex_path "^lazy_regex$")
    name: (identifier) @_regex_macro
    (#match? @_regex_macro "^(lazy_)?regex|regex_(captures|find|is_match|replace(_all)?)$")
  )
  (token_tree
    (raw_string_literal) @injection.content
  )
  (#set! injection.language "regex")
)
