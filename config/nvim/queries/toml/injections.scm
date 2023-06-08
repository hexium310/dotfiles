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
(
  (table_array_element
    (pair
      (bare_key) @_lua_hook_identifier
      (string) @lua
    )
  )
  (#contains? @_lua_hook_identifier "lua_")
  (#offset! @lua 0 3 0 -3)
)
