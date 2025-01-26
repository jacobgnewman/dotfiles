-- [nfnl] Compiled from fnl/packages/conjure.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local cmp = require("cmp")
  local config = cmp.get_config()
  table.insert(config.sources, {name = "conjure"})
  return cmp.setup(config)
end
return {{"Olical/conjure", dependencies = {"PaterJason/cmp-conjure"}, ft = {"clojure", "fennel", "python", "racket"}, lazy = true}, {"PaterJason/cmp-conjure", lazy = true, config = _1_}}
