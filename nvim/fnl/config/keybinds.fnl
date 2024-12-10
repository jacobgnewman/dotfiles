;; TODO: Move to keymap file
(fn keybind [mode keybind command opts]
  (vim.keymap.set mode keybind command opts))

(fn keybind-normal [keybind command opts] (keybind :n keybind command opts))
(fn keybind-visual [keybind command opts] (keybind :v keybind command opts))

;; neotree bindings
(local neotree-command (require :neo-tree.command))
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

;; better up/down
(keybind [:n :x] :j "v:count == 0 ? 'gj' : 'j'"
         {:desc :Down :expr true :silent true})

(keybind [:n :x] :<Down> "v:count == 0 ? 'gj' : 'j'"
         {:desc :Down :expr true :silent true})

(keybind [:n :x] :k "v:count == 0 ? 'gk' : 'k'"
         {:desc :Up :expr true :silent true})

(keybind [:n :x] :<Up> "v:count == 0 ? 'gk' : 'k'"
         {:desc :Up :expr true :silent true})

;; Window controls
;; TODO: bind <leader>w to stuff

;; File controls
(keybind :n :<leader>fn :<cmd>enew<cr> {:desc "New File"})
(keybind :n :<leader>ff
         "<cmd>:lua Snacks.dashboard.pick('files', {cwd = vim.fn.getcwd()})<cr>"
         {:desc "Search cwd"})

;(keybind :n :<leader>cf {})

(keybind :n :<leader>fn :<cmd>enew<cr> {:desc "New File"})
(keybind :n :<leader>fn :<cmd>enew<cr> {:desc "New File"})

;; move to window using ctrl+hjkl
(keybind :n :<C-h> :<C-w>h {:desc "Go to Left Window" :remap true})
(keybind :n :<C-j> :<C-w>j {:desc "Go to Lower Window" :remap true})
(keybind :n :<C-k> :<C-w>k {:desc "Go to Upper Window" :remap true})
(keybind :n :<C-l> :<C-w>l {:desc "Go to Right Window" :remap true})
(keybind :n :<C-Up> "<cmd>resize +2<cr>" {:desc "Increase Window Height"})
(keybind :n :<C-Down> "<cmd>resize -2<cr>" {:desc "Decrease Window Height"})
(keybind :n :<C-Left> "<cmd>vertical resize -2<cr>"
         {:desc "Decrease Window Width"})

(keybind :n :<C-Right> "<cmd>vertical resize +2<cr>"
         {:desc "Increase Window Width"})

;; move lines up/down with alt+jk
(keybind :n :<A-j> "<cmd>execute 'move .+' . v:count1<cr>=="
         {:desc "Move Down"})

(keybind :n :<A-k> "<cmd>execute 'move .-' . (v:count1 + 1)<cr>=="
         {:desc "Move Up"})

(keybind :i :<A-j> "<esc><cmd>m .+1<cr>==gi" {:desc "Move Down"})
(keybind :i :<A-k> "<esc><cmd>m .-2<cr>==gi" {:desc "Move Up"})
(keybind :v :<A-j> ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv"
         {:desc "Move Down"})

(keybind :v :<A-k> ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv"
         {:desc "Move Up"})

;; better indenting
(keybind :v "<" :<gv {})
(keybind :v ">" :>gv {})

;; open nvim config
;; pick('files', {cwd = vim.fn.stdpath('config')}
(keybind :n :<leader>cf
         "<cmd>:lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})<cr>"
         {})

;; Window Jazz?
(keybind :n :<leader>w :<c-w> {:desc :Windows :remap true})
(keybind :n :<leader>- :<C-W>s {:desc "Split Window Below" :remap true})
(keybind :n :<leader>| :<C-W>v {:desc "Split Window Right" :remap true})
(keybind :n :<leader>wd :<C-W>c {:desc "Delete Window" :remap true})

;; MISC
(keybind :n :<leader>qq :<cmd>qall<cr> {:desc "Quit All" :remap true})

;; LSP
; (keybind :n :<leader>cr ""

;; terminal
; (local Snacks (require :snacks))
; (keybind :n :<leader>fT (fn [] (Snacks.terminal)) {:desc "Terminal (cwd)"})
; (keybind :n :<leader>ft
;      (fn []
;        (Snacks.terminal nil {:cwd (Lazy-vim.root)}))
;      {:desc "Terminal (Root Dir)"})
; (keybind :n :<c-/> (fn []
;                  (Snacks.terminal nil {:cwd (Lazy-vim.root)}))
;      {:desc "Terminal (Root Dir)"})
; (keybind :n :<c-_> (fn []
;                  (Snacks.terminal nil {:cwd (Lazy-vim.root)}))
;      {:desc :which_key_ignore})
; (keybind :t :<C-/> :<cmd>close<cr> {:desc "Hide Terminal"})
; (keybind :t :<c-_> :<cmd>close<cr> {:desc :which_key_ignore})
