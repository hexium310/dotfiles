;extends

((parameters
  "," @_start . (type_identifier) @parameter.inner)
 (#make-range! "parameter.outer" @_start @parameter.inner))
((parameters
  . (type_identifier) @parameter.inner . ","? @_end)
 (#make-range! "parameter.outer" @parameter.inner @_end))

((tuple_type
  "," @_start . (_) @parameter.inner)
 (#make-range! "parameter.outer" @_start @parameter.inner))
((tuple_type
  . (_) @parameter.inner . ","? @_end)
 (#make-range! "parameter.outer" @parameter.inner @_end))

((array_expression
  "," @_start . (_) @parameter.inner)
 (#make-range! "parameter.outer" @_start @parameter.inner))
((array_expression
  . (_) @parameter.inner . ","? @_end)
 (#make-range! "parameter.outer" @parameter.inner @_end))

((call_expression
  function: (field_expression
    value: (_) "." @_start
    field: (field_identifier) @method.inner)
  arguments: (arguments) @_end)
  (#make-range! "method.outer" @_start @_end))
