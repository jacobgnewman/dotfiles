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

(_G.vim.lsp.inlay_hint.enable true)

(set _G.vim.g.conjure#client#fennel#aniseed#deprecation_warning false)

(_G.vim.cmd "colorscheme habamax")
