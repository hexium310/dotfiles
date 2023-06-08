;extends
(
  (table_array_element
    (pair
      (bare_key) @_hook_identifier
      (string) @vim
    )
  )
  (#contains? @_hook_identifier "hook_")
  (#offset! @vim 0 3 0 -3)
)
