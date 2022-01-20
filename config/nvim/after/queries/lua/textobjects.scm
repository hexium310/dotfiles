(table_constructor
  "," @_start .
  (_) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))
(table_constructor
  . (_) @parameter.inner
  . ","? @_end
  (#make-range! "parameter.outer" @parameter.inner @_end))
