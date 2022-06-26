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
Plug 'vim-airline/vim-airline'        " The bar at the bottom of screen

Plug 'SirVer/ultisnips'               " Snippet engine
Plug 'honza/vim-snippets'             " Some snippets for ultisnips

Plug 'neovim/nvim-lspconfig'          " native LSP config

Plug 'nvim-lua/plenary.nvim'          " All the lua functions I don't want to write twice.
Plug 'nvim-telescope/telescope.nvim'  " highly extendable fuzzy finder
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'}

Plug 'hrsh7th/nvim-cmp'               " Autocompletion engine
Plug 'hrsh7th/cmp-nvim-lsp'           " Autocompletion engine
Plug 'hrsh7th/cmp-buffer'             " Autocompletion engine
Plug 'hrsh7th/cmp-path'               " Autocompletion engine


call plug#end()

" ===== AESTETHIC =====
set cursorline
set colorcolumn=80
set nu rnu " display relative number on left
highlight ColorColumn ctermbg=0 guibg=lightgrey
set list listchars=trail:·,tab:<->,eol:¬

" ===== WHITESPACES CONTROLS =====
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=80
set expandtab
" Some python shit for indent and all
set breakindent
set autoindent

" ===== COLORSCHEME =====
colorscheme gruvbox
let g:airline_theme = "gruvbox"
highlight Comment cterm=italic gui=italic
set termguicolors

" ===== MISC =====
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

" ===== TELESCOPE =====
lua << EOF
require('telescope').setup{
    defaults = {
        prompt_prefix = "$ "
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


lua << EOF
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

EOF


" ===== LSP =====
lua << EOF

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client)
 local bufopts = { noremap=true, silent=true, buffer=bufnr }

 vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

 vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
 vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
 vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)

 vim.keymap.set('n', ' fm', vim.lsp.buf.formatting, bufopts)

 vim.keymap.set('n', ' dj', vim.diagnostic.goto_next, bufopts)
 vim.keymap.set('n', ' dg', "<cmd>Telescope diagnostics<cr>", bufopts)

 vim.keymap.set('n', ' rr', vim.lsp.buf.rename, bufopts)

 vim.keymap.set('n', ' ca', vim.lsp.buf.code_action, bufopts)
end;

require('lspconfig')['pyright'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['metals'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['texlab'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['sumneko_lua'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  cmd = {"/home/nathanh/lua-language-server/bin/lua-language-server"}
}

EOF

