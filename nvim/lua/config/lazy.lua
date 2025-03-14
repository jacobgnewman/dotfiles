-- [nfnl] Compiled from lazy.fnl by https://github.com/Olical/nfnl, do not edit.
local lazy = require("lazy")
local function mod(...)
  local args = {...}
  local to_merge
  if __fnl_global__table_3f(args[#args]) then
    to_merge = table.remove(args)
  else
    to_merge = nil
  end
  if to_merge then
    for key, value in pairs(to_merge) do
      args[key] = value
    end
    return args
  else
    return args
  end
end
return lazy.setup({spec = {{"neovim/nvim-lspconfig"}, {"hrsh7th/nvim-cmp", dependancies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer"}}, {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/vim-vsnip"}, {"stevearc/conform.nvim", opts = {format_on_save = {timeout_ms = 500, lsp_format = "fallback"}, formatters_by_ft = {fennel = {"fnlfmt"}, nix = {"alejandra"}}}}, {"echasnovski/mini.nvim", version = false}, {"ggandor/leap.nvim"}, {"akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons"}, {"j-hui/fidget.nvim"}, {"cbochs/grapple.nvim", dependencies = {{"nvim-tree/nvim-web-devicons", lazy = true}}}, {"nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons"}, {"folke/tokyonight.nvim", lazy = true, opts = {style = "moon"}}, {"sainnhe/everforest"}, {"Olical/nfnl", ft = "fennel"}, {"mrcjkb/rustaceanvim", version = "^5", lazy = false}, {import = "packages"}}, defaults = {lazy = false, version = false}, checker = {enabled = true, notify = true}})
