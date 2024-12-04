-- [nfnl] Compiled from config/keybinds.fnl by https://github.com/Olical/nfnl, do not edit.
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
keybind({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true})
keybind({"n", "x"}, "<Down>", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true})
keybind({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true})
keybind({"n", "x"}, "<Up>", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true})
keybind("n", "<C-h>", "<C-w>h", {desc = "Go to Left Window", remap = true})
keybind("n", "<C-j>", "<C-w>j", {desc = "Go to Lower Window", remap = true})
keybind("n", "<C-k>", "<C-w>k", {desc = "Go to Upper Window", remap = true})
keybind("n", "<C-l>", "<C-w>l", {desc = "Go to Right Window", remap = true})
keybind("n", "<C-Up>", "<cmd>resize +2<cr>", {desc = "Increase Window Height"})
keybind("n", "<C-Down>", "<cmd>resize -2<cr>", {desc = "Decrease Window Height"})
keybind("n", "<C-Left>", "<cmd>vertical resize -2<cr>", {desc = "Decrease Window Width"})
keybind("n", "<C-Right>", "<cmd>vertical resize +2<cr>", {desc = "Increase Window Width"})
keybind("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", {desc = "Move Down"})
keybind("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", {desc = "Move Up"})
keybind("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", {desc = "Move Down"})
keybind("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", {desc = "Move Up"})
keybind("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", {desc = "Move Down"})
keybind("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", {desc = "Move Up"})
keybind("v", "<", "<gv", {})
return keybind("v", ">", ">gv", {})
