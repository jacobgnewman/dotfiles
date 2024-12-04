-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local bootstrap_lazy = require("bootstrap")
bootstrap_lazy()
require("config.options")
require("config.lazy")
require("config.lsp")
require("config.keybinds")
local mini_ai = require("mini.ai")
mini_ai.setup()
_G.vim.lsp.inlay_hint.enable(true)
_G.vim.g["conjure#client#fennel#aniseed#deprecation_warning"] = false
return _G.vim.cmd("colorscheme habamax")
