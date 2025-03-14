-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local bootstrap_lazy = require("bootstrap")
bootstrap_lazy()
require("config.options")
require("config.lazy")
require("config.lsp")
require("config.keybinds")
local mini_ai = require("mini.ai")
mini_ai.setup()
local fidget = require("fidget")
fidget.setup()
_G.vim.keymap.set("n", "<leader>A", require("grapple").toggle)
_G.vim.keymap.set("n", "<leader>a", require("grapple").toggle_tags)
_G.vim.keymap.set("n", "<leader>r", ":w <bar> exec '!python3 '.shellescape('%')<CR>")
_G.vim.keymap.set("n", "<leader>l", "a\206\187<Esc>")
require("leap").create_default_mappings()
require("bufferline").setup()
_G.vim.lsp.inlay_hint.enable(true)
_G.vim.g["conjure#client#fennel#aniseed#deprecation_warning"] = false
_G.vim.cmd("colorscheme everforest")
_G.vim.everforrest_enable_italic = true
_G.vim.everforrest_background = "hard"
local lualine = require("lualine")
return lualine.setup({options = {theme = "everforest"}})
