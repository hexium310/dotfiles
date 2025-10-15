;extends

((array_expression
  "," @parameter.outer
  .
  _ @parameter.inner @parameter.outer))
((array_expression
  .
  _ @parameter.inner @parameter.outer
  .
  ","? @parameter.outer))

; @method.inner
; foo.methodA(args).methodB()
;     |<--->|       |<--->|
; @method.outer
; foo.methodA(args).methodB()
;    |<---------->||<------>|
((call_expression
  function: (field_expression
    value: _
    "." @method.outer
    field: (field_identifier) @method.inner @method.outer)
  arguments: (arguments) @method.outer))
