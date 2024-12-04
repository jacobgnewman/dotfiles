-- [nfnl] Compiled from config/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local lspconfig = require("lspconfig")
local lspconfig_configs = require("lspconfig.configs")
local function lsp_callback(event)
  local opts = {buffer = event.buf}
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
  vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition():<cr>", opts)
  vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
  vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
  vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  vim.keymap.set({"n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
  return vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
end
vim.api.nvim_create_autocmd("LspAttach", {desc = "LSP actions", callback = lsp_callback})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig_configs.fennel_language_server = {default_config = {cmd = {"fennel-language-server"}, filetypes = {"fennel"}, single_file_support = true, root_dir = lspconfig.util.root_pattern("fnl"), settings = {fennel = {workspace = {library = vim.api.nvim_list_runtime_paths()}, diagnostics = {globals = {"vim"}}}}}}
lspconfig.fennel_language_server.setup({})
lspconfig.rust_analyzer.setup({capabilities = capabilities, settings = {["rust-analyzer"] = {diagnostics = {enable = true}}}})
lspconfig.astro.setup({cmd = {"astro-ls", "--stdio"}, filetypes = {"astro"}, root_dir = lspconfig.util.root_pattern("package.json", ".git")})
local cmp = require("cmp")
local function _1_(args)
  _G.assert((nil ~= args), "Missing argument args on /home/gray/dotfiles/nvim/fnl/config/lsp.fnl:82")
  return vim.snippet.expand(args.body)
end
return cmp.setup({sources = {name = "nvim_lsp"}, snippet = {expand = _1_}, mapping = cmp.mapping.preset.insert({})})
