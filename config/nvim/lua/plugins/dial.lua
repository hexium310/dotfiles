local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.semver.alias.semver,
    augend.misc.alias.markdown_header,
  },
})
