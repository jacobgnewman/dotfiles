;; leaders
;; Set main leader to space, fast
;; why does it do anything in normal and visual...
(set vim.g.mapleader " ")
(vim.keymap.set :n :<Space> :<Nop> {:silent true})
(vim.keymap.set :v :<Space> :<Nop> {:silent true})

(set vim.g.maplocalleader "\\")

;; mouse can drag splits 
(set vim.opt.mouse :a)

;; ignore case in commands
(set vim.opt.ignorecase true)
(set vim.opt.smartcase true)

;; time paused till updates are run
(set vim.opt.updatetime 250)
(set vim.opt.timeoutlen 300)

;; Highlight stuff properly
; (set vim.opt.cursorline true)

;; TAB HOLY WAR
(set vim.opt.tabstop 2)
(set vim.opt.softtabstop 0)

;; width 
(set vim.opt.shiftwidth 0)

;; width used in shifting commands
(set vim.opt.expandtab true)
(set vim.opt.smartindent true)

(set vim.opt.signcolumn :yes)
(set vim.opt.wrap false)
(set vim.opt.number true)
(set vim.opt.termguicolors true)
(set vim.opt.undofile true)
(set vim.opt.undolevels 1000)
(set vim.opt.shell :fish)
