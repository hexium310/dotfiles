;extends

(array_expression
  "," @parameter.outer
  .
  _ @parameter.inner @parameter.outer)
(array_expression
  .
  _ @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

; Method
; @method.inner
; foo.identifier.methodA(args).methodB()
;                |<--->|       |<--->|
; @method.outer
; foo.identifier.methodA(args).methodB()
;               |<---------->||------|
(call_expression
  function: (field_expression
              value: _
              "." @method.outer
              field: (field_identifier) @method.inner @method.outer)
  arguments: (arguments) @method.outer)

; Field identifier
; @method.inner
; foo.identifier.methodA(args).methodB()
;     |<------>|
; @method.outer
; foo.identifier.methodA(args).methodB()
;    |<------->|
(field_expression
  (field_expression
    value: _
    "." @method.outer
    field: (field_identifier) @method.inner @method.outer))
