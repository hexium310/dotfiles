;extends
(
  (table_array_element
    (pair
      (bare_key) @property
      (string) @none
    )
  )
  (#match? @property "^\(hook|lua\)_")
)
