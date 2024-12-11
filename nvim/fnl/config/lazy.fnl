(local lazy (require :lazy))

(lazy.setup {:spec [;; LSP && Completion
                    {1 :neovim/nvim-lspconfig}
                    {1 :hrsh7th/nvim-cmp
                     :dependancies [:hrsh7th/cmp-nvim-lsp :hrsh7th/cmp-buffer]}
                    {1 :hrsh7th/cmp-nvim-lsp}
                    {1 :hrsh7th/vim-vsnip}
                    ;; Formatting
                    {1 :stevearc/conform.nvim
                     :opts {:format_on_save {:timeout_ms 500
                                             :lsp_format :fallback}
                            :formatters_by_ft {:fennel [:fnlfmt]
                                               :nix [:alejandra]}}}
                    ;; Editor UI
                    {1 :echasnovski/mini.nvim :version false}
                    ;; ?
                    {1 :ggandor/leap.nvim}
                    ;; fast movement
                    {1 :akinsho/bufferline.nvim
                     :version "*"
                     :dependencies :nvim-tree/nvim-web-devicons}
                    ;; buffer at top of editor
                    {1 :nvim-lualine/lualine.nvim
                     :dependencies :nvim-tree/nvim-web-devicons}
                    ;; label search matches, TODO: update keys...
                    {1 :folke/flash.nvim :event :VeryLazy :keys []}
                    ;; Colors...
                    {1 :ntk148v/habamax.nvim :dependencies [:rktjmp/lush.nvim]}
                    {1 :folke/tokyonight.nvim :lazy true :opts {:style :moon}}
                    ;; Fennel
                    {1 :Olical/nfnl :ft :fennel}
                    {:import :packages}]
             :defaults {;; TODO: convert more packages to lazy
                        :lazy false
                        :version false}
             ;; latest git commit
             ;; :version "*" ; <- latest stable semver
             :checker {:enabled true :notify true}})
