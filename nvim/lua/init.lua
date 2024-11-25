-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local bootstrap_lazy = require("bootstrap")
bootstrap_lazy()
require("config.options")
require("config.lazy")
require("config.lsp")
vim.g["conjure#client#fennel#aniseed#deprecation_warning"] = false
return vim.cmd("colorscheme tokyonight")
