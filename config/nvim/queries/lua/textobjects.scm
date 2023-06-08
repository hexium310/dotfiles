;extends
; FIXME: Commas multiplies when I switch field that is table
(table_constructor
  "," @_start .
  (_) @definition.field
  (#make-range! "parameter.outer" @_start @definition.field))
(table_constructor
  . (_) @definition.field
  . ","? @_end
  (#make-range! "parameter.outer" @definition.field @_end))
