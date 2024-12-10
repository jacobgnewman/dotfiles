(local lspconfig (require :lspconfig))
(local lspconfig-configs (require :lspconfig.configs))

(fn lsp_callback [event]
  (let [opts {:buffer event.buf}]
    (vim.keymap.set :n :K "<cmd>lua vim.lsp.buf.hover()<cr>" opts)
    (vim.keymap.set :n :gd "<cmd>lua vim.lsp.buf.definition()<cr>" opts)
    (vim.keymap.set :n :gD "<cmd>lua vim.lsp.buf.declaration()<cr>" opts)
    (vim.keymap.set :n :gi "<cmd>lua vim.lsp.buf.implementation()<cr>" opts)
    (vim.keymap.set :n :go "<cmd>lua vim.lsp.buf.type_definition():<cr>" opts)
    (vim.keymap.set :n :gr "<cmd>lua vim.lsp.buf.references()<cr>" opts)
    (vim.keymap.set :n :gs "<cmd>lua vim.lsp.buf.signature_help()<cr>" opts)
    (vim.keymap.set :n :<F2> "<cmd>lua vim.lsp.buf.rename()<cr>" opts)
    (vim.keymap.set [:n :x] :<F3>
                    "<cmd>lua vim.lsp.buf.format({async = true})<cr>" opts)
    (vim.keymap.set :n :<F4> "<cmd>lua vim.lsp.buf.code_action()<cr>" opts)))

(vim.api.nvim_create_autocmd :LspAttach
                             {:desc "LSP actions" :callback lsp_callback})

(local capabilities ((. (require :cmp_nvim_lsp) :default_capabilities)))
;; FENNEL
;; (lspconfig.fennel_ls.setup {})
(set lspconfig-configs.fennel_language_server
     {:default_config {:cmd [:fennel-language-server]
                       :filetypes [:fennel]
                       :single_file_support true
                       ;; source code resides in directory `fnl/`
                       :root_dir (lspconfig.util.root_pattern :fnl)
                       :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
                                           :diagnostics {:globals [:vim]}}}}})

(lspconfig.fennel_language_server.setup {: capabilities})

; (setup-servers
;   [hls ;; Haskell
;    nil_ls ;; Nix
;    pylsp ;; Python
;    racket_langserver ;; Racket
;   ])

(lspconfig.erlangls.setup {: capabilities})

;; Typst
(lspconfig.tinymist.setup {: capabilities})

;; Nix
(lspconfig.nil_ls.setup {: capabilities})

;; PYTHON
(lspconfig.pylsp.setup {: capabilities})

;; RACKET 
(lspconfig.racket_langserver.setup {: capabilities})

;; Rust
(lspconfig.rust_analyzer.setup {: capabilities
                                :settings {:rust-analyzer {:diagnostics {:enable true}}}})

;; WEB :(

(lspconfig.astro.setup {: capabilities
                        :cmd [:astro-ls :--stdio]
                        :filetypes [:astro]
                        :root_dir (lspconfig.util.root_pattern :package.json
                                                               :.git)})

;; Update 
(local cmp (require :cmp))
(cmp.setup {:sources {:name :nvim_lsp}
            :snippet {:expand (lambda [args] (vim.snippet.expand args.body))}
            :mapping (cmp.mapping.preset.insert {})})

(cmp.setup {:mapping (cmp.mapping.preset.insert {:<C-Space> (cmp.mapping.complete)
                                                 :<C-b> (cmp.mapping.scroll_docs (- 4))
                                                 :<C-e> (cmp.mapping.abort)
                                                 :<C-f> (cmp.mapping.scroll_docs 4)
                                                 :<CR> (cmp.mapping.confirm {:select true})})
            :snippet {:expand (fn [args]
                                ((. vim.fn "vsnip#anonymous") args.body))}
            :sources (cmp.config.sources [{:name :nvim_lsp} {:name :vsnip}]
                                         [{:name :buffer}])
            :window {}})

;(local capabilities ((. (require :cmp_nvim_lsp) :default_capabilities)))
;((. (require :lspconfig) :<YOUR_LSP_SERVER> :setup) {: capabilities})

; (use :neovim/nvim-lspconfig)
; (use :hrsh7th/nvim-cmp)
; (use :hrsh7th/cmp-nvim-lsp)
; (use :saadparwaiz1/cmp_luasnip)
; (use :L3MON4D3/LuaSnip)

; (local cmp (require :cmp))
; (cmp.setup {:mapping (cmp.mapping.preset.insert {:<C-Space> (cmp.mapping.complete)
;                                                  :<C-d> (cmp.mapping.scroll_docs 4)
;                                                  :<C-u> (cmp.mapping.scroll_docs (- 4))
;                                                  :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
;                                                                              :select true})
;                                                  :<S-Tab> (cmp.mapping (fn [fallback]
;                                                                          (if (cmp.visible)
;                                                                              (cmp.select_prev_item)
;                                                                              (luasnip.jumpable (- 1))
;                                                                              (luasnip.jump (- 1))
;                                                                              (fallback)))
;                                                                        [:i :s])
;                                                  :<Tab> (cmp.mapping (fn [fallback]
;                                                                        (if (cmp.visible)
;                                                                            (cmp.select_next_item)
;                                                                            (luasnip.expand_or_jumpable)
;                                                                            (luasnip.expand_or_jump)
;                                                                            (fallback)))
;                                                                      [:i :s])})
;             ;;:snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
;             :sources [{:name :nvim_lsp}]})
