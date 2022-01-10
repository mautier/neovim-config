" vim-plug plugin manager: https://github.com/junegunn/vim-plug

" Directory for vim-plug plugins.
call plug#begin('~/.vim/vim-plug')

" A collection of lua utilities that lots of plugins want.
Plug 'nvim-lua/plenary.nvim'

" Fuzzy search / overlays
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'nvim-telescope/telescope.nvim'

" File browsing
Plug 'scrooloose/nerdtree'

" Misc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" Syntax highlighting and formatting
" To list all available parsers: :TSInstallInfo
Plug 'ntpeters/vim-better-whitespace'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ron-rs/ron.vim'
Plug 'vim-autoformat/vim-autoformat'

" Tab- and Status-line
" Requires a nerdfont: https://www.nerdfonts.com/font-downloads, eg "DejaVuSansMono Nerd Font"
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'  " icons in status line
Plug 'kdheepak/tabline.nvim', {'branch': 'main'}

" Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'EdenEast/nightfox.nvim', {'branch': 'main'}
Plug 'marko-cerovac/material.nvim', {'branch': 'main'}

" Motions
Plug 'phaazon/hop.nvim', {'branch': 'v1'}

" LSP
Plug 'folke/trouble.nvim'
Plug 'neovim/nvim-lspconfig'  " This is just helpers for configuring the neovim builtin LSP client.
Plug 'williamboman/nvim-lsp-installer'

call plug#end()

" Leader key is space, nice and convenient.
let mapleader = "\<SPACE>"

"""""""""""""""" Fuzzy search / overlays
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua <<LUA_EOF
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
}
LUA_EOF

"""""""""""""""" File browsing
" Nerdtree
" t like tree.
nnoremap <leader>t :NERDTreeToggle<CR>

"""""""""""""""" Misc
" vim-commentary
nnoremap <Leader>c :Commentary<CR>
vnoremap <Leader>c :Commentary<CR>

"""""""""""""""" Syntax highlighting and formatting
" vim-better-whitespace
let g:better_whitespace_enabled = 1
" vim-autoformat
let g:autoformat_verbosemode=0
let g:formatterpath = ["/home/gautier/.cargo/bin/rustfmt"]
nnoremap <F3> :Autoformat<CR>
" nvim-treesitter
lua <<LUA_EOF
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {"python", "rust", "dockerfile", "bash", "cpp", "markdown", "vim", "lua"},
        highlight = {
            enable = true,
        },
    }
LUA_EOF

"""""""""""""""" Tab- and Status-line
" lualine & tabline:
lua << END
require'lualine'.setup {
    options = {
        theme = "nightfox"
        -- theme = "material-nvim"
    }
}
require'tabline'.setup {
    enable = true,
    options = {
        max_bufferline_percent = 80,
        show_tabs_always = false,
        show_filename_only = false,
    }
}

END

"""""""""""""""" Colorscheme
" Solarized
" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized

" Material
" let g:material_style = "deep ocean"
" colorscheme material
" lua << END
" require('material').setup({
    " borders = true
" })
" END

" Nightfox
colorscheme nightfox

"""""""""""""""" Motions
" Hop
" Use in priority keys from the home row on my dvorak keyboard, and then
" others further away.
lua require'hop'.setup { keys = 'uhidetonaspgyfcrlxbkmjwqvz' }
noremap f <cmd>HopChar2<cr>
noremap <Leader>j <cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>
noremap <Leader>k <cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>
noremap <Leader>w <cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>
noremap <Leader>b <cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>
noremap <Leader>/ <cmd>HopPattern<cr>

"""""""""""""""" LSP
lua << LUA_EOF
-- trouble
require("trouble").setup {}
-- nvim-lsp-installer
local lsp_installer = require("nvim-lsp-installer")

-- Handler that is run for all installed servers.
lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "rust_analyzer" then
        opts.settings = {
            ["rust-analyzer"] = {
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
            }
        }
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

-- Now install the servers we want.
local lsp_installer_servers = require("nvim-lsp-installer.servers")
for _i, name in ipairs({"jedi_language_server", "rust_analyzer"}) do
    local is_available, server = lsp_installer_servers.get_server(name)
    if not is_available then
        error("Server " .. name .. " is not available. Typo?")
    end
    if not server:is_installed() then
        server:install()
    end
end

-- Key to enable / disable diagnostics.
-- LSP diagnostics can be distracting when they change every time I exit insert mode.
-- This function and keymap makes it easy to toggle them.
vim.g.diagnostics_visible = true
function _G.toggle_diagnostics()
    if vim.g.diagnostics_visible then
        vim.g.diagnostics_visible = false
        vim.diagnostic.disable()
        print("Disabled diagnostics.")
    else
        vim.g.diagnostics_visible = true
        vim.diagnostic.enable()
        print("Enabled diagnostics.")
    end
end
LUA_EOF
" <leader>d/D for diagnostics
nnoremap <Leader>D :call v:lua.toggle_diagnostics()<CR>
nnoremap <Leader>d <cmd>lua vim.diagnostic.open_float()<cr>
" <leader>l" for LSP
"   h for hover
nnoremap <Leader>lh <cmd>lua vim.lsp.buf.hover()<cr>

""""""""""""""""" Other settings
" The sign column where diagnostic icons show up can flicker, which shifts the
" text to the left and right and is annoying. This turns on the sign column
" for good.
set signcolumn=yes:1

syntax enable
set tabstop=4
set shiftwidth=4
set expandtab

" Map Ctrl-lhjk to move between splits.
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Map Shift-jk to move between buffers.
nnoremap K :bnext<CR>
nnoremap J :bprev<CR>

" Syntax highlighting for files with strange extensions
autocmd BufNewFile,BufRead *.lalrpop set syntax=rust
