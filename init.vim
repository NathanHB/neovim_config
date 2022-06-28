set exrc
set secure

                             " ===== VIM PLUG =====

call plug#begin(stdpath('data') . '/plugged') " For Neovim: stdpath('data') . '/plugged'

Plug 'tpope/vim-fugitive'             " git integration in vim

Plug 'jiangmiao/auto-pairs'           " Automaticaly close parenthese etc...
Plug 'preservim/nerdcommenter'        " Simple shortcut to comment out lines
Plug 'ntpeters/vim-better-whitespace' " highlight bad whitespace
Plug 'godlygeek/tabular'              " Align text and tables
Plug 'tpope/vim-eunuch'               " Vim sugar for the UNIX shell commands that need it the most.

Plug 'drewtempelmeyer/palenight.vim'  " Theme
Plug 'morhetz/gruvbox'                " Theme
Plug 'jacoborus/tender.vim'           " Theme
Plug 'vim-airline/vim-airline'        " The bar at the bottom of screen

Plug 'SirVer/ultisnips'               " Snippet engine
Plug 'honza/vim-snippets'             " Some snippets for ultisnips

Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'          " native LSP config

Plug 'nvim-lua/plenary.nvim'          " All the lua functions I don't want to write twice.
Plug 'nvim-telescope/telescope.nvim'  " highly extendable fuzzy finder
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'}

Plug 'hrsh7th/nvim-cmp'               " Autocompletion engine
Plug 'hrsh7th/cmp-nvim-lsp'           " Autocompletion engine
Plug 'hrsh7th/cmp-buffer'             " Autocompletion engine
Plug 'hrsh7th/cmp-path'               " Autocompletion engine
Plug 'quangnguyen30192/cmp-nvim-ultisnips'


Plug 'kyazdani42/nvim-web-devicons'

call plug#end()


                            " ===== AESTETHIC =====

set cursorline
set colorcolumn=80
set nu rnu " display relative number on left
highlight ColorColumn ctermbg=0 guibg=lightgrey
set list listchars=trail:·,tab:<->,eol:¬


                       " ===== WHITESPACES CONTROLS =====
"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=80
set expandtab
" Some python shit for indent and all
set breakindent
set autoindent


                           " ===== COLORSCHEME =====
"
colorscheme tender
let g:airline_theme = "tender"
highlight Comment cterm=italic gui=italic
set termguicolors


                               " ===== MISC =====
"
let mapleader=" "
" deactivate that annoying af shortcut
map q: <nop>
nnoremap Q <nop>
" When The buffer is not active, set the numbers to not relative
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END


                            " ====== ULTISNIPS =====
"
let g:UltiSnipsJumpForwardTrigger="<tab>"


                            " ===== TELESCOPE =====

lua require("telescope_config")

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>dg <cmd>lua require('telescope.builtin').diagnostics()<cr>


                             " ===== NVIMCMP =====

lua require("nvimcmp_config")


                               " ===== LSP =====
lua require("lsp_config")

