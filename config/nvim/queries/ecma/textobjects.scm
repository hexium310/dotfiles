;extends

; @method.inner
; foo.methodA().methodB().methodC()
;     |<--->|   |<--->|   |<--->|
; @method.outer
; foo.methodA().methodB().methodC()
;    |<------>||<------>||<------>|
(call_expression
  function: (member_expression
    object: (_)
    "." @_start
    property: (property_identifier) @method.inner)
  arguments: (arguments) @_end
  (#make-range! "method.outer" @_start @_end))

; @parameter.inner
; [firstItem, secondItem, thirdItem]
;  |<----->|  |<------>|  |<----->|
; @parameter.outer
; [firstItem, secondItem, thirdItem]
;  |<------>|
;           |<-------->||<------->|
((array
  "," @_start
  .
  (_) @parameter.inner)
 (#make-range! "parameter.outer" @_start @parameter.inner))
((array
   .
  (_) @parameter.inner
  .
  ","? @_end)
 (#make-range! "parameter.outer" @parameter.inner @_end))

; @parameter.inner
; { foo: value, bar: value, baz: value }
;   |<------>|  |<------>|  |<------>|
; @parameter.outer
; { foo: value, bar: value, baz: value }
;   |<------->|
;             |<-------->||<-------->|
(object
  "," @_start
  .
  (pair) @parameter.inner
 (#make-range! "parameter.outer" @_start @parameter.inner))
(object
  .
  (pair) @parameter.inner
  .
  ","? @_end
 (#make-range! "parameter.outer" @parameter.inner @_end))
