;extends
(
  (table_array_element
    (pair
      (bare_key) @_hook_identifier
      (string) @injection.content
    )
  )
  (#contains? @_hook_identifier "hook_")
  (#set! injection.language "vim")
  (#offset! @injection.content 0 3 0 -3)
)
(
  (table_array_element
    (pair
      (bare_key) @_lua_hook_identifier
      (string) @injection.content
    )
  )
  (#contains? @_lua_hook_identifier "lua_")
  (#set! injection.language "lua")
  (#offset! @injection.content 0 3 0 -3)
)
