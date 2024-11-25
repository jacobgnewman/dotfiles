-- [nfnl] Compiled from config/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local lspconfig_configs = require("lspconfig.configs")
local lspconfig_defaults = lspconfig.util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, cmp_nvim_lsp.default_capabilities())
local function lsp_callback(event)
  local opts = {buffer = event.buf}
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
  vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
  vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
  vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  vim.keymap.set({"n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
  return vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
end
vim.api.nvim_create_autocmd("LspAttach", {desc = "LSP actions", callback = lsp_callback})
lspconfig_configs.fennel_language_server = {default_config = {cmd = {"fennel-language-server"}, filetypes = {"fennel"}, single_file_support = true, root_dir = lspconfig.util.root_pattern("fnl"), settings = {fennel = {workspace = {library = vim.api.nvim_list_runtime_paths()}, diagnostics = {globals = {"vim"}}}}}}
lspconfig.racket_langserver.setup({})
local cmp = require("cmp")
local function _1_(args)
  _G.assert((nil ~= args), "Missing argument args on /Users/gray/.config/nvim/fnl/config/lsp.fnl:40")
  return vim.snippet.expand(args.body)
end
return cmp.setup({sources = {name = "nvim_lsp"}, snippet = {expand = _1_}, mapping = cmp.mapping.preset.insert({})})
