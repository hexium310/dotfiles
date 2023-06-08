;extends
(
  (table_array_element
    (pair
      (bare_key) @property
      (string) @none
    )
  )
  (#contains? @property "hook_")
)
