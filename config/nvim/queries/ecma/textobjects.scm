;extends

; @method.inner
; foo.methodA().methodB().methodC()
;     |<--->|   |<--->|   |<--->|
; @method.outer
; foo.methodA().methodB().methodC()
;    |<------>||<------>||<------>|
(call_expression
  function: (member_expression
    object: _
    "." @method.outer
    property: (property_identifier) @method.inner @method.outer)
  arguments: (arguments) @method.outer)

; @parameter.inner
; [firstItem, secondItem, thirdItem]
;  |<----->|  |<------>|  |<----->|
; @parameter.outer
; [firstItem, secondItem, thirdItem]
;  |<------>|
;           |<-------->||-------|
(array
  "," @parameter.outer
  .
  _ @parameter.inner @parameter.outer)
(array
  .
  _ @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

; @parameter.inner
; { foo: value, shorthand_bar, baz: value }
;   |<------>|  |<--------->|  |<------>|
; @parameter.outer
; { foo: value, shorthand_bar, baz: value }
;   |<------->|
;             |<----------->||<-------->|
(object
  "," @parameter.outer
  .
  (_) @parameter.inner @parameter.outer)
(object
  .
  (_) @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)
