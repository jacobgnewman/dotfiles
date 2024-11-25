;; Ah, a simple tool
(local bootstrap-lazy (require :bootstrap))

;; setup lazy as plugin manager, with fennel :)
(bootstrap-lazy)

(require :config.options)
(require :config.lazy)
(require :config.lsp)

(set vim.g.conjure#client#fennel#aniseed#deprecation_warning false)

(vim.cmd "colorscheme tokyonight")
