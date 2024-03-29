;extends
(jsx_opening_element ((identifier) @constructor
 (#match? @constructor "^[A-Z]")))

(jsx_closing_element ((identifier) @constructor
 (#match? @constructor "^[A-Z]")))

(jsx_self_closing_element ((identifier) @constructor
 (#match? @constructor "^[A-Z]")))

; Handle the dot operator effectively - <My.Component>
(jsx_opening_element ((nested_identifier (identifier) @constructor (identifier) @constructor)))

; Handle the dot operator effectively - </My.Component>
(jsx_closing_element ((nested_identifier (identifier) @constructor (identifier) @constructor)))

; Handle the dot operator effectively - <My.Component />
(jsx_self_closing_element ((nested_identifier (identifier) @constructor (identifier) @constructor)))
