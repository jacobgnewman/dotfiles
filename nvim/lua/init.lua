-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local bootstrap_lazy = require("bootstrap")
bootstrap_lazy()
require("config.options")
require("config.lazy")
require("config.lsp")
local mini_ai = require("mini.ai")
mini_ai.setup()
local function keybind(mode, keybind0, command, opts)
  return vim.keymap.set(mode, keybind0, command, opts)
end
local function keybind_normal(keybind0, command, opts)
  return keybind0("n", keybind0, command, opts)
end
local function keybind_visual(keybind0, command, opts)
  return keybind0("v", keybind0, command, opts)
end
local neotree_command = require("neo-tree.command")
local function toggle_neotree()
  if (vim.bo.filetype == "neo-tree") then
    return neotree_command.execute({action = "close"})
  else
    return neotree_command.execute({action = "focus"})
  end
end
keybind("n", "<leader>e", toggle_neotree, {noremap = true, silent = true, desc = "Toggle Neotree"})
keybind("v", "<leader>y", "\"+y", {noremap = true, silent = true, desc = "Copy to clipboard"})
keybind("n", "<leader>p", "\"+p", {noremap = true, silent = true, desc = "Paste Clipboard"})
keybind("v", "<leader>p", "\"+p", {noremap = true, silent = true, desc = "Paste Clipboard"})
vim.lsp.inlay_hint.enable(true)
vim.g["conjure#client#fennel#aniseed#deprecation_warning"] = false
return vim.cmd("colorscheme habamax")
