(local lazy (require :lazy))

(lazy.setup {:spec [{1 :neovim/nvim-lspconfig}
                    {1 :hrsh7th/nvim-cmp
                     :dependancies [:hrsh7th/cmp-nvim-lsp :hrsh7th/cmp-buffer]}
                    {1 :hrsh7th/cmp-nvim-lsp}
                    {1 :echasnovski/mini.nvim :version false}
                    {1 :Olical/nfnl :ft :fennel}
                    {1 :atweiden/vim-fennel}
                    ;; {1 :gpanders/nvim-parinfer}
                    {1 :stevearc/conform.nvim
                     :opts {:format_on_save {:timeout_ms 500
                                             :lsp_format :fallback}
                            :formatters_by_ft {:fennel [:fnlfmt]}}}
                    {1 :ntk148v/habamax.nvim :dependencies [:rktjmp/lush.nvim]}
                    {1 :folke/tokyonight.nvim
                     :lazy false
                     :priority 1000
                     :opts {}}
                    {:import :packages}]
             :defaults {;; TODO: convert more packages to lazy
                        :lazy false
                        :version false}
             ;; latest git commit
             ;; :version "*" ; <- latest stable semver
             :checker {:enabled true :notify true}})
