[{1 :nvim-treesitter/nvim-treesitter
  :build ":TSUpdate"
  :config (lambda []
            (let [configs (require :nvim-treesitter.configs)]
              (configs.setup {:ensure_installed [:c
                                                 :lua
                                                 :fennel
                                                 :racket
                                                 :rust
                                                 :javascript
                                                 :typst
                                                 :html
                                                 :python]
                              :sync_install false
                              :highlight {:enable true}
                              :indent {:enable true}})))}]
