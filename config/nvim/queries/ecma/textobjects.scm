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
