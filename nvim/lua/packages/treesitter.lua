-- [nfnl] Compiled from packages/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local configs = require("nvim-treesitter.configs")
  return configs.setup({ensure_installed = {"c", "lua", "fennel", "racket", "rust", "javascript", "typst", "html", "python"}, highlight = {enable = true}, indent = {enable = true}, sync_install = false})
end
return {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _1_}}
