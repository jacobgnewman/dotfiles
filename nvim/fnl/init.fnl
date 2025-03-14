;; Ah, a simple tool
(local bootstrap-lazy (require :bootstrap))

;; setup lazy as plugin manager, with fennel :)
(bootstrap-lazy)

(require :config.options)
(require :config.lazy)
(require :config.lsp)
(require :config.keybinds)

(local mini-ai (require :mini.ai))
(mini-ai.setup)

(local fidget (require :fidget))
(fidget.setup)

(_G.vim.keymap.set :n :<leader>A (. (require :grapple) :toggle))
(_G.vim.keymap.set :n :<leader>a (. (require :grapple) :toggle_tags))
;(vim.keymap.set :n :<leader>L1 "<cmd>Grapple select index=1<cr>")
(_G.vim.keymap.set :n :<leader>r
                   ":w <bar> exec '!python3 '.shellescape('%')<CR>")

(_G.vim.keymap.set :n :<leader>l "aλ<Esc>")

((. (require :leap) :create_default_mappings))
((. (require :bufferline) :setup))

(_G.vim.lsp.inlay_hint.enable true)

(set _G.vim.g.conjure#client#fennel#aniseed#deprecation_warning false)

(_G.vim.cmd "colorscheme everforest")
(set _G.vim.everforrest_enable_italic true)
(set _G.vim.everforrest_background :hard)

(local lualine (require :lualine))
(lualine.setup {:options {:theme :everforest}})
