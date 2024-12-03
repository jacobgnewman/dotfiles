;; Ah, a simple tool
(local bootstrap-lazy (require :bootstrap))

;; setup lazy as plugin manager, with fennel :)
(bootstrap-lazy)

(require :config.options)
(require :config.lazy)
(require :config.lsp)

(local mini-ai (require :mini.ai))
(mini-ai.setup)

;; TODO: Move to keymap file
(fn keybind [mode keybind command opts]
  (vim.keymap.set mode keybind command opts))

(fn keybind-normal [keybind command opts] (keybind :n keybind command opts))
(fn keybind-visual [keybind command opts] (keybind :v keybind command opts))

(local neotree-command (require :neo-tree.command))

;; neotree bindings
(fn toggle-neotree []
  (if (= vim.bo.filetype :neo-tree)
      ;; open or focus
      (neotree-command.execute {:action :close})
      ;; close if focused
      (neotree-command.execute {:action :focus})))

(keybind :n :<leader>e toggle-neotree
         {:noremap true :silent true :desc "Toggle Neotree"})

;; setup yank to clipboard
(keybind :v :<leader>y "\"+y"
         {:noremap true :silent true :desc "Copy to clipboard"})

;; paste from clipboard
(keybind :n :<leader>p "\"+p"
         {:noremap true :silent true :desc "Paste Clipboard"})

(keybind :v :<leader>p "\"+p"
         {:noremap true :silent true :desc "Paste Clipboard"})

(vim.lsp.inlay_hint.enable true)

(set vim.g.conjure#client#fennel#aniseed#deprecation_warning false)

(vim.cmd "colorscheme habamax")
