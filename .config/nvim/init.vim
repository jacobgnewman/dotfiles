" NEOVIM CONFIG
"
" Note lines with `*` may be under evaluation
"
"
" General Config
set shell=/bin/bash         " turn off fish :( doesn't play nice with config
set nocompatible            " Disables compatiablility to old vi
set wildmode=longest,list   " 'bash' style tab completion in vim cmdline *
syntax on                   " syntax highlighting *
set ttyfast                 " fast vim scrolling
set mouse=a
" Tab configuration
set tabstop=4     " Sets # col occupied by tabs
set softtabstop=4 " 4 spaces  recognized as a tab for <BS> function
set expandtab     " sets tabs to whitespace
set shiftwidth=4  " sets width for auto-indent
set smarttab      " ?
set autoindent    " indents a new line the same ammount as the last line
" relative line numbering
set relativenumber
set number
" add 80 col highlight
highlight ColorColumn ctermbg=darkcyan
call matchadd('ColorColumn', '\%81v', 100)
" Key Mapping
let mapleader = "\<Space>" " https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity
imap jk <ESC>
imap kj <ESC>


"install's vim plugged if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ==================
"     PLUGINS!!!
" =================
call plug#begin()

" Themes
Plug 'morhetz/gruvbox'
" File Tree Plugins
Plug 'scrooloose/nerdtree'          " file explorer
Plug 'Xuyuanp/nerdtree-git-plugin'  " adds git status to file explorer *
Plug 'ryanoasis/vim-devicons'       " adds file glyphs 
" General Plugins
Plug 'preservim/nerdcommenter'      " for comment functions
Plug 'mhinz/vim-startify'           " fancy start screen
Plug 'feline-nvim/feline.nvim'      " statusline
Plug 'nvim-lua/plenary.nvim'        " lua functions for other plugins

" LSP Packages
Plug 'neovim/nvim-lspconfig'
"Syntax support
Plug 'cespare/vim-toml'
Plug 'elkowar/yuck.vim'
Plug 'dag/vim-fish'

call plug#end()

set termguicolors
colorscheme gruvbox

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle Terminal on/off
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" highlight yanked text
" au TextYankPost * silent! lua vim.highlight.on_yank()

" LUA TIME
lua << EOF
require('feline').setup()
EOF


