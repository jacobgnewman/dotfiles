(local cmp_nvim_lsp (require :cmp_nvim_lsp))
(local lspconfig (require :lspconfig))
(local lspconfig-configs (require :lspconfig.configs))
(local lspconfig_defaults lspconfig.util.default_config)

(set lspconfig_defaults.capabilities
     (vim.tbl_deep_extend :force lspconfig_defaults.capabilities
                          (cmp_nvim_lsp.default_capabilities)))

(fn lsp_callback [event]
  (let [opts {:buffer event.buf}]
    (vim.keymap.set :n :K "<cmd>lua vim.lsp.buf.hover()<cr>" opts)
    (vim.keymap.set :n :gd "<cmd>lua vim.lsp.buf.definition()<cr>" opts)
    (vim.keymap.set :n :gD "<cmd>lua vim.lsp.buf.declaration()<cr>" opts)
    (vim.keymap.set :n :gi "<cmd>lua vim.lsp.buf.implementation()<cr>" opts)
    (vim.keymap.set :n :go "<cmd>lua vim.lsp.buf.type_definition()<cr>" opts)
    (vim.keymap.set :n :gr "<cmd>lua vim.lsp.buf.references()<cr>" opts)
    (vim.keymap.set :n :gs "<cmd>lua vim.lsp.buf.signature_help()<cr>" opts)
    (vim.keymap.set :n :<F2> "<cmd>lua vim.lsp.buf.rename()<cr>" opts)
    (vim.keymap.set [:n :x] :<F3>
                    "<cmd>lua vim.lsp.buf.format({async = true})<cr>" opts)
    (vim.keymap.set :n :<F4> "<cmd>lua vim.lsp.buf.code_action()<cr>" opts)))

(vim.api.nvim_create_autocmd :LspAttach
                             {:desc "LSP actions" :callback lsp_callback})

(set lspconfig-configs.fennel_language_server
     {:default_config {:cmd [:fennel-language-server]
                       :filetypes [:fennel]
                       :single_file_support true
                       ;; source code resides in directory `fnl/`
                       :root_dir (lspconfig.util.root_pattern :fnl)
                       :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
                                           :diagnostics {:globals [:vim]}}}}})

(lspconfig.fennel_language_server.setup [])

(lspconfig.racket_langserver.setup {})

(local cmp (require :cmp))
(cmp.setup {:sources {:name :nvim_lsp}
            :snippet {:expand (lambda [args] (vim.snippet.expand args.body))}
            :mapping (cmp.mapping.preset.insert {})})
